import Foundation
import TextModel
import WireFormat

/// Reads an attributed string back into paragraphs, one run of equal attributes at a time.
struct ParagraphAssembler {
  private(set) var paragraphs: [Paragraph] = []
  private var contents: [ParagraphContent] = []
  private var frame: Paragraph?
  private var isOpen = false

  init(_ text: AttributedString) {
    for run in text.runs {
      let pieces = ParagraphSeparator.split(String(text[run.range].characters))
      for (index, piece) in pieces.enumerated() {
        // Between two pieces stood a character that ends the paragraph.
        if index > 0 { close() }
        guard !piece.isEmpty || index + 1 < pieces.count else { continue }
        if !isOpen {
          frame = run[ParagraphAttribute.self]
          isOpen = true
        }
        if !piece.isEmpty { add(String(piece), from: run) }
      }
    }
    if isOpen { close() }
  }

  private mutating func close() {
    var paragraph = frame ?? Paragraph()
    paragraph.contents = contents.isEmpty ? nil : contents
    paragraphs.append(paragraph)
    contents = []
    frame = nil
    isOpen = false
  }

  private mutating func add(_ text: String, from run: AttributedString.Runs.Run) {
    let intent = run.inlinePresentationIntent ?? []
    let underline = run[UnderlineAttribute.self]
    let restyle = { (style: CharacterProperties?) -> CharacterProperties? in
      let styled = (style ?? CharacterProperties()).applying(intent: intent, underline: underline)
      return style == nil && styled == CharacterProperties() ? nil : styled
    }
    guard var content = run[ContentAttribute.self] else {
      // Text that came from elsewhere: a plain run, or a link if Foundation's attribute says so.
      let plain = TextRun(text, style: restyle(nil))
      let link = run.link.map { HyperlinkField(target: .url($0.absoluteString), run: plain) }
      append(link.map(ParagraphContent.hyperlink) ?? .run(plain))
      return
    }
    switch content.form {
    case .run(var template):
      template.string = text
      template.style = restyle(template.style)
      content.form = .run(template)
      append(content)
    case .hyperlink(var template):
      template.run.string = text
      template.run.style = restyle(template.run.style)
      content.form = .hyperlink(template)
      append(content)
    case .inlineObject, nil:
      // Each U+FFFC is the element once more; anything typed beside it is plain text.
      for part in text.split(separator: AttributedString.objectReplacement, omittingEmptySubsequences: false)
        .enumerated()
      {
        if part.offset > 0 { contents.append(content) }
        if !part.element.isEmpty { append(.run(TextRun(String(part.element), style: restyle(nil)))) }
      }
    }
  }

  // An attribute that the library does not carry may cut a run in two; the two halves are one run again here.
  private mutating func append(_ content: ParagraphContent) {
    guard let last = contents.last, let joined = Self.join(last, content) else {
      contents.append(content)
      return
    }
    contents[contents.count - 1] = joined
  }

  private static func join(_ first: ParagraphContent, _ second: ParagraphContent) -> ParagraphContent? {
    guard let left = first.textRun, let right = second.textRun, let template = retexted(first, ""),
      template == retexted(second, "")
    else { return nil }
    return retexted(first, left.string + right.string)
  }

  /// A run or a link with its text replaced; nil for an element that has no text.
  private static func retexted(_ content: ParagraphContent, _ text: String) -> ParagraphContent? {
    var content = content
    if case .run(var run) = content.form {
      run.string = text
      content.form = .run(run)
      return content
    }
    if case .hyperlink(var link) = content.form {
      link.run.string = text
      content.form = .hyperlink(link)
      return content
    }
    return nil
  }
}
