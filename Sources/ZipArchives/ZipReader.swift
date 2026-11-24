package import Foundation
import OrderedCollections
import RawDeflate

/// A reader of a ZIP archive held in memory, which refuses a hostile one before it expands anything.
package struct ZipReader: Sendable {
  /// The files of the archive, in the order of its central directory.
  package let entries: [ZipEntry]
  private let archive: Data

  private struct Directory {
    var count: Int
    var offset: Int
    var end: Int
  }

  private struct Span {
    var name: String
    var range: Range<Int>
  }

  /// Reads the directory of an archive and checks every entry against the limits.
  package init(_ archive: Data, limits: ZipLimits = .standard) throws(ZipError) {
    let bytes = archive.startIndex == 0 ? archive : Data(archive)
    let directory = try Self.directory(of: bytes)
    guard directory.count <= limits.maximumEntryCount else { throw .hostile(.tooManyEntries(directory.count)) }
    var cursor = ByteCursor(bytes, at: directory.offset)
    var names: OrderedSet<String> = []
    var files: [ZipEntry] = []
    var spans: [Span] = []
    var total = 0
    for index in 0..<directory.count {
      let record = try Self.record(at: index, &cursor, in: bytes, before: directory)
      guard names.append(record.name).inserted else { throw .hostile(.duplicateEntry(record.name)) }
      spans.append(Span(name: record.name, range: record.span))
      guard let entry = record.entry else { continue }
      guard entry.size <= limits.maximumEntrySize else {
        throw .hostile(.entryTooLarge(name: entry.name, size: entry.size))
      }
      total += entry.size
      guard total <= limits.maximumTotalSize else { throw .hostile(.archiveTooLarge(size: total)) }
      let ratio = entry.size / max(entry.storedSize, 1)
      guard entry.size <= limits.ratioThreshold || ratio <= limits.maximumCompressionRatio else {
        throw .hostile(.compressionRatio(name: entry.name, ratio: ratio))
      }
      files.append(entry)
    }
    guard cursor.offset == directory.end else { throw .malformed(.directoryMisplaced) }
    spans.sort { $0.range.lowerBound < $1.range.lowerBound }
    for (earlier, later) in zip(spans, spans.dropFirst()) where earlier.range.upperBound > later.range.lowerBound {
      throw .hostile(.overlappingEntries(earlier.name, later.name))
    }
    self.entries = files
    self.archive = bytes
  }

  /// Returns the expanded bytes of an entry, checked against its recorded size and CRC-32.
  package func contents(of entry: ZipEntry) throws(ZipError) -> Data {
    let stored = archive[entry.storedRange]
    let bytes: Data
    switch entry.compression {
    case .stored:
      bytes = Data(stored)
    case .deflated:
      do throws(DeflateError) {
        bytes = try DeflateStream.inflate(stored, count: entry.size)
      } catch {
        throw .entryCorrupt(name: entry.name, Self.defect(error))
      }
    }
    guard CyclicRedundancyCheck.checksum(bytes) == entry.checksum else {
      throw .entryCorrupt(name: entry.name, .checksumMismatch)
    }
    return bytes
  }

  private static func defect(_ error: DeflateError) -> ZipError.EntryDefect {
    switch error {
    case .unavailable, .corrupt: .notDeflate
    case .truncated: .truncated
    case .sizeMismatch: .sizeMismatch
    case .trailingBytes: .trailingBytes
    }
  }

  private static func directory(of bytes: Data) throws(ZipError) -> Directory {
    let fixed = 22
    var position = bytes.count - fixed
    var found = false
    var hasLooseRecord = false
    while position >= max(0, bytes.count - fixed - 0xFFFF) {
      var cursor = ByteCursor(bytes, at: position)
      if try cursor.unsigned(4) == ZipSignature.endRecord {
        // The comment has to take the record to the last byte, or bytes after the archive could pose as it.
        var comment = ByteCursor(bytes, at: position + 20)
        let length = try comment.integer(2)
        if length == bytes.count - position - fixed {
          found = true
          break
        }
        hasLooseRecord = hasLooseRecord || length < bytes.count - position - fixed
      }
      position -= 1
    }
    guard found else {
      guard !hasLooseRecord else { throw .malformed(.bytesAfterEndRecord) }
      var start = ByteCursor(bytes)
      let opensAsArchive = try bytes.count >= 4 ? start.unsigned(4) == ZipSignature.localHeader : false
      throw opensAsArchive ? .truncated : .notAnArchive
    }
    var cursor = ByteCursor(bytes, at: position + 4)
    let disk = try cursor.integer(2)
    let directoryDisk = try cursor.integer(2)
    let countHere = try cursor.integer(2)
    var count = try cursor.integer(2)
    var size = try cursor.integer(4)
    var offset = try cursor.integer(4)
    var end = position
    var locator = ByteCursor(bytes, at: position - 20)
    if position >= 20, try locator.unsigned(4) == ZipSignature.zip64Locator {
      let recordDisk = try locator.integer(4)
      let recordOffset = try locator.integer(8)
      guard recordDisk == 0, try locator.integer(4) <= 1 else { throw .unsupported(.multipleDisks) }
      var record = ByteCursor(bytes, at: recordOffset)
      guard try record.unsigned(4) == ZipSignature.zip64EndRecord else { throw .malformed(.zip64Misplaced) }
      let recordSize = try record.integer(8)
      guard recordOffset + 12 + recordSize == position - 20 else { throw .malformed(.zip64Misplaced) }
      try record.skip(4)
      guard try record.integer(4) == 0, try record.integer(4) == 0 else { throw .unsupported(.multipleDisks) }
      let wideCountHere = try record.integer(8)
      count = try record.integer(8)
      guard wideCountHere == count else { throw .unsupported(.multipleDisks) }
      size = try record.integer(8)
      offset = try record.integer(8)
      end = recordOffset
    } else {
      guard disk == 0, directoryDisk == 0, countHere == count else { throw .unsupported(.multipleDisks) }
      guard count != 0xFFFF, size != 0xFFFF_FFFF, offset != 0xFFFF_FFFF else { throw .malformed(.zip64Misplaced) }
    }
    guard offset <= end, end - offset == size else { throw .malformed(.directoryMisplaced) }
    return Directory(count: count, offset: offset, end: end)
  }

  private static func record(
    at index: Int, _ cursor: inout ByteCursor, in bytes: Data, before directory: Directory
  ) throws(ZipError) -> (name: String, span: Range<Int>, entry: ZipEntry?) {
    let start = cursor.offset
    guard try cursor.unsigned(4) == ZipSignature.directoryHeader else {
      throw .malformed(.signatureMissing(offset: start))
    }
    try cursor.skip(4)
    let flags = try cursor.integer(2)
    let method = try cursor.integer(2)
    try cursor.skip(4)
    let checksum = UInt32(truncatingIfNeeded: try cursor.unsigned(4))
    var storedSize = try cursor.integer(4)
    var size = try cursor.integer(4)
    let nameLength = try cursor.integer(2)
    let extraLength = try cursor.integer(2)
    let commentLength = try cursor.integer(2)
    var disk = try cursor.integer(2)
    try cursor.skip(6)
    var headerOffset = try cursor.integer(4)
    let nameBytes = try cursor.slice(nameLength)
    var extra = ByteCursor(try cursor.slice(extraLength))
    try cursor.skip(commentLength)
    guard cursor.offset <= directory.end else { throw .malformed(.recordOutOfBounds) }
    while extra.remaining >= 4 {
      let kind = try extra.integer(2)
      let length = try extra.integer(2)
      var block = ByteCursor(try extra.slice(length))
      guard kind == 1 else { continue }
      if size == 0xFFFF_FFFF { size = try block.integer(8) }
      if storedSize == 0xFFFF_FFFF { storedSize = try block.integer(8) }
      if headerOffset == 0xFFFF_FFFF { headerOffset = try block.integer(8) }
      if disk == 0xFFFF { disk = try block.integer(4) }
    }
    guard size != 0xFFFF_FFFF, storedSize != 0xFFFF_FFFF, headerOffset != 0xFFFF_FFFF else {
      throw .malformed(.zip64Misplaced)
    }
    guard disk == 0 else { throw .unsupported(.multipleDisks) }
    guard let name = String(validating: nameBytes, as: UTF8.self) else { throw .malformed(.nameNotUTF8(index: index)) }
    guard ZipEntryName.isSafe(name) else { throw .hostile(.unsafeEntryName(name)) }
    // Bits 0, 6 and 13 mark encryption in its three forms.
    guard flags & 0x2041 == 0 else { throw .unsupported(.encryption(name: name)) }

    var local = ByteCursor(bytes, at: headerOffset)
    guard try local.unsigned(4) == ZipSignature.localHeader else {
      throw .malformed(.signatureMissing(offset: headerOffset))
    }
    try local.skip(2)
    let localFlags = try local.integer(2)
    let localMethod = try local.integer(2)
    try local.skip(8)
    let localStoredSize = try local.integer(4)
    let localSize = try local.integer(4)
    let localNameLength = try local.integer(2)
    let localExtraLength = try local.integer(2)
    let localName = try local.slice(localNameLength)
    try local.skip(localExtraLength)
    // Bit 3 defers the sizes to a record after the bytes; a Zip64 header leaves them saturated.
    let defersSizes = localFlags & 0x0008 != 0 || localStoredSize == 0xFFFF_FFFF || localSize == 0xFFFF_FFFF
    guard localName == nameBytes, localMethod == method, localFlags & 0x2041 == 0,
      defersSizes || (localStoredSize == storedSize && localSize == size)
    else { throw .malformed(.localHeaderMismatch(name: name)) }
    let stored = local.offset..<local.offset + storedSize
    guard stored.upperBound <= directory.offset else { throw .malformed(.recordOutOfBounds) }
    let span = headerOffset..<stored.upperBound
    if name.hasSuffix("/") {
      guard size == 0 else { throw .malformed(.directoryWithContents(name: name)) }
      return (name, span, nil)
    }
    guard let compression = ZipCompression(rawValue: UInt16(truncatingIfNeeded: method)) else {
      throw .unsupported(.compressionMethod(name: name, method: method))
    }
    guard compression == .deflated || storedSize == size else { throw .malformed(.storedSizeMismatch(name: name)) }
    let entry = ZipEntry(
      name: name, compression: compression, checksum: checksum, storedSize: storedSize, size: size,
      storedRange: stored)
    return (name, span, entry)
  }
}
