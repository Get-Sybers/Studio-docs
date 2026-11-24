package import Foundation
import OrderedCollections
import RawDeflate

/// A writer of a ZIP archive in memory: UTF-8 names, one fixed timestamp, and Zip64 records where the sizes need them.
package struct ZipWriter: Sendable {
  private var body = Data()
  private var directory = Data()
  private var names: OrderedSet<String> = []
  private let threshold: Zip64Threshold

  /// Midnight on 1 January 1980, the earliest date the format holds, so equal contents give equal bytes.
  private static let date = 0x0021
  /// Bit 11 says that names are UTF-8.
  private static let flags = 0x0800
  /// A sample this long decides whether a large entry is worth compressing.
  private static let sample = 1 << 18
  /// The value of a 32-bit field whose true value stands in the Zip64 extra field.
  private static let saturated = 0xFFFF_FFFF

  /// Creates a writer with no entries; the thresholds say when a Zip64 record is written.
  package init(zip64Threshold: Zip64Threshold = .standard) {
    threshold = zip64Threshold
  }

  /// Adds a file; with `.deflated` the bytes are stored as they are when compression does not shrink them.
  package mutating func add(
    _ contents: Data, named name: String, compression: ZipCompression = .deflated
  ) throws(ZipError) {
    guard ZipEntryName.isSafe(name), !name.hasSuffix("/"), name.utf8.count <= 0xFFFF else {
      throw .hostile(.unsafeEntryName(name))
    }
    guard names.append(name).inserted else { throw .hostile(.duplicateEntry(name)) }
    let nameBytes = Data(name.utf8)
    var stored = contents
    var method = ZipCompression.stored
    if compression == .deflated, Self.shrinks(contents), let packed = try? DeflateStream.deflate(contents),
      packed.count < contents.count
    {
      stored = packed
      method = .deflated
    }
    let offset = body.count
    let checksum = Int(CyclicRedundancyCheck.checksum(contents))
    let wideSizes = stored.count >= threshold.size || contents.count >= threshold.size
    let wideOffset = offset >= threshold.size
    let version = wideSizes || wideOffset ? 45 : 20

    var localExtra = Data()
    if wideSizes {
      localExtra.append(littleEndian: 1, width: 2)
      localExtra.append(littleEndian: 16, width: 2)
      localExtra.append(littleEndian: contents.count, width: 8)
      localExtra.append(littleEndian: stored.count, width: 8)
    }
    body.append(littleEndian: Int(ZipSignature.localHeader), width: 4)
    body.append(
      Self.header(
        version: version, method: method, checksum: checksum, storedSize: wideSizes ? Self.saturated : stored.count,
        size: wideSizes ? Self.saturated : contents.count, nameCount: nameBytes.count, extraCount: localExtra.count))
    body.append(nameBytes)
    body.append(localExtra)
    body.append(stored)

    var fields = Data()
    if wideSizes {
      fields.append(littleEndian: contents.count, width: 8)
      fields.append(littleEndian: stored.count, width: 8)
    }
    if wideOffset { fields.append(littleEndian: offset, width: 8) }
    var centralExtra = Data()
    if !fields.isEmpty {
      centralExtra.append(littleEndian: 1, width: 2)
      centralExtra.append(littleEndian: fields.count, width: 2)
      centralExtra.append(fields)
    }
    directory.append(littleEndian: Int(ZipSignature.directoryHeader), width: 4)
    // Made on Unix, so the attributes below are a file mode.
    directory.append(littleEndian: 0x0300 | version, width: 2)
    directory.append(
      Self.header(
        version: version, method: method, checksum: checksum, storedSize: wideSizes ? Self.saturated : stored.count,
        size: wideSizes ? Self.saturated : contents.count, nameCount: nameBytes.count, extraCount: centralExtra.count))
    directory.append(littleEndian: 0, width: 6)
    directory.append(littleEndian: 0o100644 << 16, width: 4)
    directory.append(littleEndian: wideOffset ? Self.saturated : offset, width: 4)
    directory.append(nameBytes)
    directory.append(centralExtra)
  }

  /// Returns the archive: the entries, their directory, the Zip64 records when a count or a size needs them, and the end record.
  package func finish() -> Data {
    let wide = names.count >= threshold.count || directory.count >= threshold.size || body.count >= threshold.size
    var archive = body
    archive.append(directory)
    if wide {
      let recordOffset = archive.count
      archive.append(littleEndian: Int(ZipSignature.zip64EndRecord), width: 4)
      archive.append(littleEndian: 44, width: 8)
      archive.append(littleEndian: 0x032D, width: 2)
      archive.append(littleEndian: 45, width: 2)
      archive.append(littleEndian: 0, width: 8)
      archive.append(littleEndian: names.count, width: 8)
      archive.append(littleEndian: names.count, width: 8)
      archive.append(littleEndian: directory.count, width: 8)
      archive.append(littleEndian: body.count, width: 8)
      archive.append(littleEndian: Int(ZipSignature.zip64Locator), width: 4)
      archive.append(littleEndian: 0, width: 4)
      archive.append(littleEndian: recordOffset, width: 8)
      archive.append(littleEndian: 1, width: 4)
    }
    archive.append(littleEndian: Int(ZipSignature.endRecord), width: 4)
    archive.append(littleEndian: 0, width: 4)
    archive.append(littleEndian: wide ? 0xFFFF : names.count, width: 2)
    archive.append(littleEndian: wide ? 0xFFFF : names.count, width: 2)
    archive.append(littleEndian: wide ? Self.saturated : directory.count, width: 4)
    archive.append(littleEndian: wide ? Self.saturated : body.count, width: 4)
    archive.append(littleEndian: 0, width: 2)
    return archive
  }

  /// The fields that a local header and a directory record share, from the version needed to the extra length.
  private static func header(
    version: Int, method: ZipCompression, checksum: Int, storedSize: Int, size: Int, nameCount: Int, extraCount: Int
  ) -> Data {
    var header = Data()
    header.append(littleEndian: version, width: 2)
    header.append(littleEndian: flags, width: 2)
    header.append(littleEndian: Int(method.rawValue), width: 2)
    header.append(littleEndian: 0, width: 2)
    header.append(littleEndian: date, width: 2)
    header.append(littleEndian: checksum, width: 4)
    header.append(littleEndian: storedSize, width: 4)
    header.append(littleEndian: size, width: 4)
    header.append(littleEndian: nameCount, width: 2)
    header.append(littleEndian: extraCount, width: 2)
    return header
  }

  // Media is compressed already; a sample spares the cost of finding that out on the whole of it.
  private static func shrinks(_ contents: Data) -> Bool {
    guard contents.count > 4 * sample else { return !contents.isEmpty }
    let head = contents.prefix(sample)
    guard let packed = try? DeflateStream.deflate(head) else { return false }
    return packed.count * 100 < head.count * 97
  }
}
