/// A reason paragraphs have no attributed form that reads back as the same paragraphs.
public enum AttributedTextError: Error, Sendable, Hashable {
  /// A run inside a paragraph holds a character that ends a paragraph; the values are their places and the scalar.
  case paragraphSeparator(paragraph: Int, content: Int, scalar: Unicode.Scalar)
}
