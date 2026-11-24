/// A failure to turn JSON text into a tree or a tree into JSON text.
public enum JSONTreeError: Error, Sendable {
  /// The bytes are not JSON text; the value is the decoder's own error.
  case malformed(underlying: any Error)
  /// The tree holds a value that JSON text cannot spell, such as a number that is not finite.
  case notRepresentable(underlying: any Error)
}
