import Foundation

/// Little-endian reads over the bytes of an archive, each checked against the bounds.
struct ByteCursor {
  let bytes: Data
  var offset: Int

  init(_ bytes: Data, at offset: Int = 0) {
    self.bytes = bytes
    self.offset = offset
  }

  var remaining: Int { bytes.count - offset }

  mutating func unsigned(_ width: Int) throws(ZipError) -> UInt64 {
    guard offset >= 0, width <= remaining else { throw .malformed(.recordOutOfBounds) }
    var value: UInt64 = 0
    for index in 0..<width {
      value |= UInt64(bytes[bytes.startIndex + offset + index]) << UInt64(8 * index)
    }
    offset += width
    return value
  }

  mutating func integer(_ width: Int) throws(ZipError) -> Int {
    guard let value = Int(exactly: try unsigned(width)) else { throw .malformed(.recordOutOfBounds) }
    return value
  }

  mutating func slice(_ count: Int) throws(ZipError) -> Data {
    guard offset >= 0, count >= 0, count <= remaining else { throw .malformed(.recordOutOfBounds) }
    let start = bytes.startIndex + offset
    offset += count
    return bytes[start..<start + count]
  }

  mutating func skip(_ count: Int) throws(ZipError) {
    _ = try slice(count)
  }
}
