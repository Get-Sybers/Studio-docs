public import Foundation
public import TextModel
import WireFormat

extension AttributedString {
  /// The character that stands for an element with no text of its own.
  static let objectReplacement = "\u{FFFC}"

  /// Creates the attributed form of paragraphs: their text, a line feed after each, and the library's attributes.
  ///
  /// A run that holds U+000A, U+000D or U+2029 is refused, since it would read back as two paragraphs.
  public init(
    paragraphs: [Paragraph], options: AttributedTextOptions = AttributedTextOptions()
  ) throws(AttributedTextError) {
    self.init()
    for (index, paragraph) in paragraphs.enumerated() {
      var frame = paragraph
      frame.contents = nil
      var text = try AttributedString(contentsOf: paragraph, at: index)
      if index + 1 < paragraphs.count || options.terminatesLastParagraph {
        text.append(AttributedString("\n"))
      }
      text[ParagraphAttribute.self] = frame
      append(text)
    }
  }

  /// Creates the attributed form of a body of text, whichever form it takes.
  public init(_ body: TextBody, options: AttributedTextOptions = AttributedTextOptions()) throws(AttributedTextError) {
    try self.init(paragraphs: body.allParagraphs, options: options)
  }

  /// Creates the attributed form of one paragraph's contents: no line feed, and no paragraph attribute.
  public init(contentsOf paragraph: Paragraph) throws(AttributedTextError) {
    try self.init(contentsOf: paragraph, at: 0)
  }

  private init(contentsOf paragraph: Paragraph, at index: Int) throws(AttributedTextError) {
    self.init()
    for (position, content) in (paragraph.contents ?? []).enumerated() {
      var template = content
      var piece: AttributedString
      switch content.form {
      case .run(var run):
        piece = AttributedString(run.string)
        piece.mark(with: run.style)
        run.string = ""
        template.form = .run(run)
      case .hyperlink(var link):
        piece = AttributedString(link.run.string)
        piece.mark(with: link.run.style)
        if case .url(let address) = link.target.form, let url = URL(string: address) { piece.link = url }
        link.run.string = ""
        template.form = .hyperlink(link)
      case .inlineObject, nil:
        piece = AttributedString(Self.objectReplacement)
      }
      if let run = content.textRun, let scalar = ParagraphSeparator.first(in: run.string) {
        throw .paragraphSeparator(paragraph: index, content: position, scalar: scalar)
      }
      piece[ContentAttribute.self] = template
      piece[RunIndexAttribute.self] = position
      append(piece)
    }
  }

  private mutating func mark(with style: CharacterProperties?) {
    guard let style else { return }
    let intent = style.presentationIntent
    if !intent.isEmpty { self.inlinePresentationIntent = intent }
    if let underline = style.underlineMark { self[UnderlineAttribute.self] = underline }
  }
}
