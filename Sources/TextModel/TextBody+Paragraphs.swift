import WireFormat

extension TextBody {
  /// Creates a body of paragraphs from plain texts, one run each.
  public init(paragraphs texts: [String]) {
    self.init(.paragraphs(texts.map { Paragraph($0) }))
  }

  /// The body as paragraphs, whichever form it takes.
  ///
  /// A plain string and a list of runs are split where a paragraph separator stands; an unmodelled form gives none.
  public var allParagraphs: [Paragraph] {
    switch form {
    case .paragraphs(let paragraphs):
      return paragraphs
    case .string(let text):
      return ParagraphSeparator.split(text).map { Paragraph(String($0)) }
    case .runs(let runs):
      var paragraphs: [Paragraph] = []
      var contents: [ParagraphContent] = []
      for run in runs {
        let pieces = ParagraphSeparator.split(run.string)
        for (index, piece) in pieces.enumerated() {
          if index > 0 {
            paragraphs.append(Paragraph(contents: contents.isEmpty ? nil : contents))
            contents = []
          }
          if !piece.isEmpty {
            var part = run
            part.string = String(piece)
            contents.append(.run(part))
          }
        }
      }
      paragraphs.append(Paragraph(contents: contents.isEmpty ? nil : contents))
      return paragraphs
    case nil:
      return []
    }
  }

  /// The body as plain text, a line feed between paragraphs.
  public var plainText: String {
    allParagraphs.map(\.plainText).joined(separator: "\n")
  }
}
