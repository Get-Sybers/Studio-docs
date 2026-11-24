package import Foundation
import zlib

/// The CRC-32 that a ZIP archive records for each entry.
package enum CyclicRedundancyCheck {
  /// Returns the CRC-32 of the bytes.
  package static func checksum(_ bytes: Data) -> UInt32 {
    unsafe bytes.withUnsafeBytes { buffer in
      var value = crc32(0, nil, 0)
      var offset = 0
      while offset < buffer.count {
        let length = min(buffer.count - offset, 1 << 30)
        let start = unsafe buffer.baseAddress.map { unsafe ($0 + offset).assumingMemoryBound(to: UInt8.self) }
        value = unsafe crc32(value, start, UInt32(length))
        offset += length
      }
      return UInt32(truncatingIfNeeded: value)
    }
  }
}
