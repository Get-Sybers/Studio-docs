import WireFormat

extension ParagraphContent {
  /// Makes a run of text.
  public static func text(_ string: String, style: CharacterProperties? = nil) -> ParagraphContent {
    .run(TextRun(string, style: style))
  }

  /// The run of text that the element shows: its own, or that of a link; nil for an inline object.
  public var textRun: TextRun? {
    switch form {
    case .run(let run): run
    case .hyperlink(let link): link.run
    case .inlineObject, nil: nil
    }
  }

  /// The element as plain text; an inline object and an unmodelled element are U+FFFC.
  public var plainText: String {
    textRun?.string ?? "\u{FFFC}"
  }
}
