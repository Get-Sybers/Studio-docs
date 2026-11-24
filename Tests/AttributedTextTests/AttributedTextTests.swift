import AttributedText
import DocumentIdentifiers
import Foundation
import GoldenFiles
import JSONTree
import Testing
import TextModel
import WireFormat

struct BridgeCase: Sendable, CustomTestStringConvertible {
  var name: String
  var paragraphs: @Sendable () -> [Paragraph]
  var testDescription: String { name }

  static let italic = CharacterProperties(italic: true)
  static let bold = CharacterProperties(bold: true)

  static let all: [BridgeCase] = [
    BridgeCase(name: "plain text") { [Paragraph("Low water at six.")] },
    BridgeCase(name: "an italic run that ends with a space") {
      [Paragraph(contents: [.text("He said "), .text("no ", style: italic), .text("twice.")])]
    },
    BridgeCase(name: "an italic run that begins with a space") {
      [Paragraph(contents: [.text("He said"), .text(" no", style: italic), .text(" twice.")])]
    },
    BridgeCase(name: "an italic run that begins and ends with punctuation") {
      [Paragraph(contents: [.text("She wrote "), .text("\u{2018}never!\u{2019}", style: italic), .text(" and left.")])]
    },
    BridgeCase(name: "an italic run that is only punctuation and space") {
      [Paragraph(contents: [.text("Wait"), .text(" \u{2014} ", style: italic), .text("what?")])]
    },
    BridgeCase(name: "runs that touch") {
      [
        Paragraph(contents: [
          .text("bold", style: bold), .text("italic", style: italic), .text("plain"),
          .text("both", style: CharacterProperties(bold: true, italic: true)),
        ])
      ]
    },
    BridgeCase(name: "underline and strikethrough of each kind") {
      [
        Paragraph(contents: [
          .text("single", style: CharacterProperties(underline: .value(.single))),
          .text("double", style: CharacterProperties(underline: .value(.double))),
          .text("wavy", style: CharacterProperties(underline: .value(.wavy))),
          .text("struck", style: CharacterProperties(strikethrough: .value(.single))),
          .text("twice", style: CharacterProperties(strikethrough: .value(.double))),
        ])
      ]
    },
    BridgeCase(name: "switches that are off, cleared or left alone") {
      [
        Paragraph(contents: [
          .text(
            "off",
            style: CharacterProperties(bold: false, italic: false, strikethrough: .value(.off), underline: .value(.off))
          ),
          .text("cleared", style: CharacterProperties(bold: .cleared, italic: .cleared, underline: .cleared)),
          .text("empty style", style: CharacterProperties()),
        ])
      ]
    },
    BridgeCase(name: "unusual characters") {
      [
        Paragraph(contents: [
          .text("non-breaking\u{00A0}space, line\u{2028}separator, "), .text("e\u{0301} and \u{00E9}", style: italic),
          .text(" \u{1F469}\u{200D}\u{1F4BB} \u{1F1EC}\u{1F1E7} \u{FFFC} tab\there"),
        ])
      ]
    },
    BridgeCase(name: "other character properties and a preset") {
      var style = CharacterProperties(fontName: "Fenwick-Regular", fontSize: 11.5, italic: true, language: "en-GB")
      style.presetIdentifier = "stress"
      return [Paragraph(contents: [.text("styled", style: style)])]
    },
    BridgeCase(name: "paragraph properties, breaks and identifiers") {
      var first = Paragraph("First.")
      first.identifier = "p-1"
      first.style = ParagraphProperties(alignment: .value(.justified))
      first.style?.presetIdentifier = "body"
      first.breakType = .page
      var second = Paragraph("Second.")
      second.identifier = "p-2"
      second.listLevel = 1
      second.setValue("kept", of: ClientProperty<String>("x-mark"))
      return [first, second]
    },
    BridgeCase(name: "empty paragraphs, the last included") {
      var middle = Paragraph("")
      middle.identifier = "p-2"
      var last = Paragraph("")
      last.identifier = "p-3"
      return [Paragraph("One."), middle, Paragraph("Three."), last]
    },
    BridgeCase(name: "no paragraphs") { [] },
    BridgeCase(name: "links") {
      [
        Paragraph(contents: [
          .text("See "),
          .hyperlink(
            HyperlinkField(target: .url("https://example.org/tides"), run: TextRun("the tables", style: italic))),
          .text(" or "), .hyperlink(HyperlinkField(target: .slideJump(.next), run: TextRun("go on"))), .text("."),
        ])
      ]
    },
    BridgeCase(name: "an inline object and an element the library does not model") {
      let picture: JSONValue = ["image": ["resource": ["indirect": ["filename": "anchor.png"]]]]
      let unmodelled = ParagraphContent(form: nil, envelope: ObjectEnvelope(unmodelled: ["footnote": ["number": 1]]))
      return [
        Paragraph(contents: [
          .text("Before"), .inlineObject(picture), .inlineObject(picture), unmodelled, .text("after"),
        ])
      ]
    },
  ]
}

@Suite struct AttributedTextTests {
  let goldens: GoldenFile

  init() throws {
    goldens = try GoldenFile(named: "attributed-text", in: .module)
  }

  static func dump(_ text: AttributedString) -> String {
    text.runs.map { run in
      let shown = String(text[run.range].characters).unicodeScalars.map { scalar in
        scalar.value < 0x20 || scalar.value > 0x7E
          ? "<\(String(scalar.value, radix: 16, uppercase: true))>" : String(scalar)
      }.joined()
      var marks: [String] = []
      if let intent = run.inlinePresentationIntent {
        if intent.contains(.emphasized) { marks.append("italic") }
        if intent.contains(.stronglyEmphasized) { marks.append("bold") }
        if intent.contains(.strikethrough) { marks.append("struck") }
      }
      if let underline = run[UnderlineAttribute.self] { marks.append("underline=\(underline.rawValue)") }
      if let link = run.link { marks.append("link=\(link.absoluteString)") }
      if let paragraph = run[ParagraphAttribute.self] {
        marks.append("paragraph=\(paragraph.identifier?.rawValue ?? "-")")
      }
      return "[\(shown)] \(marks.joined(separator: " "))"
    }.joined(separator: "\n")
  }

  @Test(arguments: BridgeCase.all)
  func roundTrip(_ item: BridgeCase) throws {
    let paragraphs = item.paragraphs()
    let text = try AttributedString(paragraphs: paragraphs)
    #expect(String(text.characters) == paragraphs.map { $0.plainText + "\n" }.joined())
    #expect([Paragraph](text) == paragraphs)
    #expect(TextBody(text) == TextBody.paragraphs(paragraphs))
    let got = Self.dump(text)
    #expect(got == (try goldens.want("attributed: \(item.name)", got: got)))
  }

  @Test func withoutAFinalLineFeedOnlyAnEmptyLastParagraphIsLost() throws {
    var last = Paragraph("")
    last.identifier = "p-2"
    let options = AttributedTextOptions(terminatesLastParagraph: false)
    let text = try AttributedString(paragraphs: [Paragraph("One."), last], options: options)
    #expect(String(text.characters) == "One.\n")
    #expect([Paragraph](text) == [Paragraph("One.")])
    let whole = try AttributedString(paragraphs: [Paragraph("One."), Paragraph("Two.")], options: options)
    #expect(String(whole.characters) == "One.\nTwo.")
    #expect([Paragraph](whole) == [Paragraph("One."), Paragraph("Two.")])
  }

  @Test func adjacentRunsOfOneStyleComeBackAsOne() throws {
    let text = try AttributedString(paragraphs: [Paragraph(contents: [.text("one "), .text("two"), .text("")])])
    #expect([Paragraph](text) == [Paragraph("one two")])
  }

  @Test(arguments: ["\n", "\r", "\u{2029}", "\r\n"])
  func aRunThatHoldsAParagraphSeparatorIsRefused(_ separator: String) {
    let paragraphs = [Paragraph("fine"), Paragraph(contents: [.text("fine"), .text("one\(separator)two")])]
    #expect(throws: AttributedTextError.self) { _ = try AttributedString(paragraphs: paragraphs) }
    #expect(throws: Never.self) { _ = try AttributedString(TextBody.string("one\(separator)two")) }
  }

  @Test func aSplitKeepsTheIdentifierOnBothHalvesAndTheCallerMints() throws {
    var paragraph = Paragraph(contents: [.text("Before the break, "), .text("after it", style: BridgeCase.italic)])
    paragraph.identifier = "p-1"
    var text = try AttributedString(paragraphs: [paragraph])
    let range = try #require(text.range(of: "break, "))
    text.insert(AttributedString("\n"), at: range.upperBound)
    var paragraphs = [Paragraph](text)
    #expect(paragraphs.map(\.plainText) == ["Before the break, ", "after it"])
    #expect(paragraphs.map(\.identifier) == ["p-1", "p-1"])
    #expect(paragraphs[1].runs.first?.style == BridgeCase.italic)
    var mint = IdentifierMint(avoiding: ["p-1"])
    #expect(mint.assignIdentifiers(to: &paragraphs) == [1])
    #expect(paragraphs[0].identifier == "p-1")
    #expect(paragraphs[1].identifier != "p-1")
  }

  @Test func aJoinKeepsTheFirstParagraph() throws {
    var first = Paragraph("One. ")
    first.identifier = "p-1"
    var second = Paragraph("Two.")
    second.identifier = "p-2"
    var text = try AttributedString(paragraphs: [first, second])
    text.removeSubrange(try #require(text.range(of: "\n")))
    let joined = [Paragraph](text)
    #expect(joined.map(\.plainText) == ["One. Two."])
    #expect(joined.map(\.identifier) == ["p-1"])
  }

  @Test func textFromElsewhereBecomesPlainRunsAndLinks() {
    var text = AttributedString("typed ")
    var stressed = AttributedString("stressed")
    stressed.inlinePresentationIntent = [.emphasized, .stronglyEmphasized]
    var linked = AttributedString(" link")
    linked.link = URL(string: "https://example.org")
    text.append(stressed)
    text.append(linked)
    text.append(AttributedString("\nnext"))
    let paragraphs = [Paragraph](text)
    #expect(paragraphs.count == 2)
    #expect(paragraphs[0].identifier == nil)
    #expect(
      paragraphs[0].contents == [
        .text("typed "), .text("stressed", style: CharacterProperties(bold: true, italic: true)),
        .hyperlink(HyperlinkField(target: .url("https://example.org"), run: TextRun(" link"))),
      ])
    #expect(paragraphs[1] == Paragraph("next"))
  }

  @Test func removingTheSemanticAttributeTurnsTheSwitchBackToInheriting() throws {
    let style = CharacterProperties(fontSize: 12, italic: true, underline: .value(.double))
    var text = try AttributedString(paragraphs: [Paragraph(contents: [.text("stressed", style: style)])])
    text.inlinePresentationIntent = nil
    text[UnderlineAttribute.self] = nil
    #expect([Paragraph](text) == [Paragraph(contents: [.text("stressed", style: CharacterProperties(fontSize: 12))])])
  }

  @Test func anAttributeTheLibraryDoesNotCarryDoesNotCutARun() throws {
    enum Foreign: AttributedStringKey {
      typealias Value = Int
      static let name = "org.example.foreign"
    }
    let paragraph = Paragraph(contents: [.text("one run of text", style: BridgeCase.italic)])
    var text = try AttributedString(paragraphs: [paragraph])
    let range = try #require(text.range(of: "run"))
    text[range][Foreign.self] = 1
    #expect(text.runs.count > 1)
    #expect([Paragraph](text) == [paragraph])
  }

  @Test func theContentsOfOneParagraphGoBothWays() throws {
    var paragraph = Paragraph(contents: [.text("Low water at "), .text("six", style: BridgeCase.italic), .text(".")])
    paragraph.identifier = "p-1"
    var text = try AttributedString(contentsOf: paragraph)
    #expect(String(text.characters) == "Low water at six.")
    #expect(text.runs.allSatisfy { $0[ParagraphAttribute.self] == nil })
    text.append(AttributedString(" Then nothing."))
    var edited = paragraph
    edited.replaceContents(with: text)
    #expect(edited.identifier == "p-1")
    #expect(edited.plainText == "Low water at six. Then nothing.")
    #expect(edited.runs.map(\.style) == [nil, BridgeCase.italic, nil])
  }
}
