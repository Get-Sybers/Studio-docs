import WireFormat

extension Paragraph {
  /// Creates a paragraph of one run; an empty text gives a paragraph with no contents.
  public init(_ text: String, style: CharacterProperties? = nil) {
    self.init(contents: text.isEmpty ? nil : [.text(text, style: style)])
  }

  /// The runs of text in order, those of links included.
  public var runs: [TextRun] {
    (contents ?? []).compactMap(\.textRun)
  }

  /// The paragraph as plain text, without the break that ends it; an inline object is U+FFFC.
  public var plainText: String {
    (contents ?? []).map(\.plainText).joined()
  }
}
