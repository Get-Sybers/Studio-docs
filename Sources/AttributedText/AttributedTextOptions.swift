/// How paragraphs are laid out in an attributed string.
public struct AttributedTextOptions: Sendable, Hashable {
  /// Whether the last paragraph ends with a line feed as the others do; true unless set.
  ///
  /// Without it, a last paragraph that is empty has no character to carry its properties and its identifier.
  public var terminatesLastParagraph: Bool

  /// Creates options.
  public init(terminatesLastParagraph: Bool = true) {
    self.terminatesLastParagraph = terminatesLastParagraph
  }
}
