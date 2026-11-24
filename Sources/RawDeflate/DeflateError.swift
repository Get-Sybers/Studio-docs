/// A failure of the system's DEFLATE implementation.
package enum DeflateError: Error, Sendable, Hashable {
  /// The library did not start a stream; the value is its status code.
  case unavailable(status: Int32)
  /// The compressed bytes are not a DEFLATE stream; the value is the library's status code.
  case corrupt(status: Int32)
  /// The stream ended before its last block.
  case truncated
  /// The stream holds more or fewer bytes than the caller declared.
  case sizeMismatch(expected: Int)
  /// Bytes follow the end of the stream.
  case trailingBytes
}
