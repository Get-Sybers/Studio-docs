import Foundation
import RawDeflate

/// Builds archives by hand, so that a test can state a defect that no writer produces.
struct ArchiveForge {
  struct Part {
    var name: Data
    var contents: Data
    var method = 8
    var flags = 0x0800
    var localName: Data?
    var declaredSize: Int?
    var declaredStoredSize: Int?
    var checksum: UInt32?
    var offset: Int?
    var stored: Data?
  }

  var parts: [Part] = []
  var declaredCount: Int?
  var directoryShift = 0
  var disk = 0
  var comment = Data()
  var trailer = Data()
  var usesZip64 = false

  mutating func add(_ name: String, _ text: String, _ change: (inout Part) -> Void = { _ in }) {
    var part = Part(name: Data(name.utf8), contents: Data(text.utf8))
    change(&part)
    parts.append(part)
  }

  func bytes() throws -> Data {
    var body = Data()
    var directory = Data()
    for part in parts {
      let stored = try part.stored ?? (part.method == 8 ? DeflateStream.deflate(part.contents) : part.contents)
      let offset = part.offset ?? body.count
      var shared = Data()
      shared.append16(20)
      shared.append16(part.flags)
      shared.append16(part.method)
      shared.append16(0)
      shared.append16(0x0021)
      shared.append32(Int(part.checksum ?? CyclicRedundancyCheck.checksum(part.contents)))
      shared.append32(part.declaredStoredSize ?? stored.count)
      shared.append32(part.declaredSize ?? part.contents.count)
      let localName = part.localName ?? part.name
      body.append32(0x0403_4B50)
      body.append(shared.dropLast(0))
      body.append16(localName.count)
      body.append16(0)
      body.append(localName)
      body.append(stored)
      directory.append32(0x0201_4B50)
      directory.append16(0x0314)
      directory.append(shared)
      directory.append16(part.name.count)
      directory.append16(usesZip64 ? 12 : 0)
      directory.append16(0)
      directory.append16(0)
      directory.append16(0)
      directory.append32(0)
      directory.append32(usesZip64 ? 0xFFFF_FFFF : offset)
      directory.append(part.name)
      if usesZip64 {
        directory.append16(1)
        directory.append16(8)
        directory.append32(offset)
        directory.append32(0)
      }
    }
    var archive = body
    archive.append(directory)
    if usesZip64 {
      let record = archive.count
      archive.append32(0x0606_4B50)
      archive.append32(44)
      archive.append32(0)
      archive.append16(45)
      archive.append16(45)
      archive.append32(0)
      archive.append32(0)
      for value in [parts.count, parts.count, directory.count, body.count] {
        archive.append32(value)
        archive.append32(0)
      }
      archive.append32(0x0706_4B50)
      archive.append32(0)
      archive.append32(record)
      archive.append32(0)
      archive.append32(1)
    }
    archive.append32(0x0605_4B50)
    archive.append16(disk)
    archive.append16(0)
    archive.append16(usesZip64 ? 0xFFFF : declaredCount ?? parts.count)
    archive.append16(usesZip64 ? 0xFFFF : declaredCount ?? parts.count)
    archive.append32(usesZip64 ? 0xFFFF_FFFF : directory.count)
    archive.append32(usesZip64 ? 0xFFFF_FFFF : body.count + directoryShift)
    archive.append16(comment.count)
    archive.append(comment)
    archive.append(trailer)
    return archive
  }

  /// The header and bytes of one stored file, as they stand before a directory names them.
  static func storedRecord(_ name: String, _ text: String) throws -> Data {
    var forge = ArchiveForge()
    forge.add(name, text) { $0.method = 0 }
    return try forge.bytes().prefix(30 + name.utf8.count + text.utf8.count)
  }
}

extension Data {
  mutating func append16(_ value: Int) {
    append(UInt8(truncatingIfNeeded: value))
    append(UInt8(truncatingIfNeeded: value >> 8))
  }

  mutating func append32(_ value: Int) {
    append16(value)
    append16(value >> 16)
  }
}
