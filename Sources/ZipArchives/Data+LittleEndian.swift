import Foundation

extension Data {
  /// Appends the low `width` bytes of a value, the least significant first.
  mutating func append(littleEndian value: Int, width: Int) {
    for index in 0..<width {
      append(UInt8(truncatingIfNeeded: value >> (8 * index)))
    }
  }
}
