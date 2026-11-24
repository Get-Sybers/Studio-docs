package import Foundation
import OrderedCollections
import RawDeflate

/// A writer of a ZIP archive in memory: UTF-8 names, one fixed timestamp, and no Zip64 records.
package struct ZipWriter: Sendable {
  private var body = Data()
  private var directory = Data()
  private var names: OrderedSet<String> = []

  /// Midnight on 1 January 1980, the earliest date the format holds, so equal contents give equal bytes.
  private static let date = 0x0021
  /// Bit 11 says that names are UTF-8.
  private static let flags = 0x0800
  /// A sample this long decides whether a large entry is worth compressing.
  private static let sample = 1 << 18

  /// Creates a writer with no entries.
  package init() {}

  /// Adds a file; with `.deflated` the bytes are stored as they are when compression does not shrink them.
  package mutating func add(
    _ contents: Data, named name: String, compression: ZipCompression = .deflated
  ) throws(ZipError) {
    guard ZipEntryName.isSafe(name), !name.hasSuffix("/") else { throw .hostile(.unsafeEntryName(name)) }
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
    let limit = 0xFFFF_FFFF
    guard names.count < 0xFFFF, nameBytes.count <= 0xFFFF, contents.count < limit,
      offset + 30 + nameBytes.count + stored.count < limit
    else { throw .unsupported(.zip64Writing) }
    let checksum = Int(CyclicRedundancyCheck.checksum(contents))

    var shared = Data()
    shared.append(littleEndian: 20, width: 2)
    shared.append(littleEndian: Self.flags, width: 2)
    shared.append(littleEndian: Int(method.rawValue), width: 2)
    shared.append(littleEndian: 0, width: 2)
    shared.append(littleEndian: Self.date, width: 2)
    shared.append(littleEndian: checksum, width: 4)
    shared.append(littleEndian: stored.count, width: 4)
    shared.append(littleEndian: contents.count, width: 4)
    shared.append(littleEndian: nameBytes.count, width: 2)
    shared.append(littleEndian: 0, width: 2)

    body.append(littleEndian: Int(ZipSignature.localHeader), width: 4)
    body.append(shared)
    body.append(nameBytes)
    body.append(stored)

    directory.append(littleEndian: Int(ZipSignature.directoryHeader), width: 4)
    // Made by version 2.0 on Unix, so the attributes below are a file mode.
    directory.append(littleEndian: 0x0314, width: 2)
    directory.append(shared)
    directory.append(littleEndian: 0, width: 6)
    directory.append(littleEndian: 0o100644 << 16, width: 4)
    directory.append(littleEndian: offset, width: 4)
    directory.append(nameBytes)
  }

  /// Returns the archive: the entries, their directory and the end record.
  package func finish() throws(ZipError) -> Data {
    guard body.count + directory.count < 0xFFFF_FFFF else { throw .unsupported(.zip64Writing) }
    var archive = body
    archive.append(directory)
    archive.append(littleEndian: Int(ZipSignature.endRecord), width: 4)
    archive.append(littleEndian: 0, width: 4)
    archive.append(littleEndian: names.count, width: 2)
    archive.append(littleEndian: names.count, width: 2)
    archive.append(littleEndian: directory.count, width: 4)
    archive.append(littleEndian: body.count, width: 4)
    archive.append(littleEndian: 0, width: 2)
    return archive
  }

  // Media is compressed already; a sample spares the cost of finding that out on the whole of it.
  private static func shrinks(_ contents: Data) -> Bool {
    guard contents.count > 4 * sample else { return !contents.isEmpty }
    let head = contents.prefix(sample)
    guard let packed = try? DeflateStream.deflate(head) else { return false }
    return packed.count * 100 < head.count * 97
  }
}
