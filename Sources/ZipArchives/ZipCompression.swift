/// How the bytes of an entry are stored.
package enum ZipCompression: UInt16, Sendable, Hashable {
  /// As they are.
  case stored = 0
  /// As a raw DEFLATE stream.
  case deflated = 8
}
