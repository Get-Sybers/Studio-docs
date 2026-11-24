import Appearance
import Foundation
import GoldenFiles
import JSONTree
import Testing
import TextModel
import WireFormat

struct BuiltCase: Sendable, CustomTestStringConvertible {
  var name: String
  var value: @Sendable () -> JSONValue
  var testDescription: String { name }

  // The shapes follow the examples of Apple's documentation and reference library; the words are invented.
  static let all: [BuiltCase] = [
    BuiltCase(name: "a plain string") { TextBody.string("Low water at six.").wireValue },
    BuiltCase(name: "two paragraphs, the second with a bold run") {
      var bold = CharacterProperties()
      bold.bold = true
      return TextBody.paragraphs([
        Paragraph("Harbour notes"),
        Paragraph(contents: [.text("The swell rose "), .text("two metres", style: bold), .text(" before dawn.")]),
      ]).wireValue
    },
    BuiltCase(name: "runs with a style each") {
      TextBody.runs([TextRun("A title", style: CharacterProperties(bold: true, fontSize: 32))]).wireValue
    },
    BuiltCase(name: "a link of each kind") {
      let link = { (text: String, target: Hyperlink) in
        ParagraphContent.hyperlink(HyperlinkField(target: target, run: TextRun(text)))
      }
      return Paragraph(contents: [
        link("a page", .url("https://example.org/harbour")),
        link("a slide", .slideJump(.byIdentifier("slide-two"))),
        link("the next slide", .slideJump(.next)),
        link("a file", .file("notes/tides.txt")),
        link("the way out", .program("exit_slideshow")),
      ]).wireValue
    },
    BuiltCase(name: "a numbered item and a bullet") {
      let numbered = ListProperties(
        levels: .value([
          ListLevel(
            labelIndent: 0, textIndent: 1.5,
            label: .number(ListNumberLabel(numberFormat: ListNumberFormat(kind: .numeric, format: .decimal))))
        ]))
      let bullets = ListProperties(
        levels: .value([ListLevel(labelIndent: 0, textIndent: 1.5, label: .string(ListStringLabel(string: "•")))]))
      var first = Paragraph("Check the moorings")
      first.listStyle = numbered
      first.listStart = 1
      var second = Paragraph("Then the fenders")
      second.listStyle = bullets
      second.listLevel = 1
      return TextBody.paragraphs([first, second]).wireValue
    },
    BuiltCase(name: "character properties with a cleared member and a preset") {
      var properties = CharacterProperties(italic: true, underline: .value(.single), underlineColor: .cleared)
      properties.presetIdentifier = "emphasis"
      properties.characterFill = .value(.color(.rgba(RGBAColor(red: 0.1, green: 0.35, blue: 0.85))))
      return properties.wireValue
    },
    BuiltCase(name: "a paragraph with a rule above and an identifier of the client's") {
      var paragraph = Paragraph("Ruled off")
      paragraph.style = ParagraphProperties(
        alignment: .value(.center), borders: ParagraphBorders(width: 2, before: true))
      paragraph.identifier = "p-0001"
      paragraph.breakType = .page
      return paragraph.wireValue
    },
  ]
}

@Suite struct TextShapesTests {
  let goldens: GoldenFile

  init() throws {
    goldens = try GoldenFile(named: "text-model", in: .module)
  }

  @Test(arguments: BuiltCase.all)
  func writesTheShapeOfTheFormat(_ item: BuiltCase) throws {
    let written = item.value()
    let got = String(decoding: try written.text(.readable), as: UTF8.self)
    #expect(got == (try goldens.want("built: \(item.name)", got: got)))
  }

  @Test(arguments: [
    ("one\ntwo", ["one", "two"]),
    ("one\r\ntwo\rthree\u{2029}four", ["one", "two", "three", "four"]),
    ("soft\u{2028}break stays", ["soft\u{2028}break stays"]),
    ("trailing\n", ["trailing", ""]),
    ("", [""]),
  ])
  func aPlainStringSplitsWhereAParagraphEnds(_ text: String, _ want: [String]) {
    #expect(TextBody.string(text).allParagraphs.map(\.plainText) == want)
  }

  @Test func runsSplitWhereAParagraphEndsAndKeepTheirStyles() {
    let italic = CharacterProperties(italic: true)
    let body = TextBody.runs([TextRun("one\ntw"), TextRun("o\n\nfour", style: italic)])
    let paragraphs = body.allParagraphs
    #expect(paragraphs.map(\.plainText) == ["one", "two", "", "four"])
    #expect(paragraphs[1].runs.map(\.style) == [nil, italic])
    #expect(paragraphs[2].contents == nil)
    #expect(body.plainText == "one\ntwo\n\nfour")
  }

  @Test func plainTextMarksAnInlineObject() throws {
    let paragraph = try Paragraph(wire: [
      "contents": [
        ["run": ["string": "Before "]], ["inline_object": ["image": [:]]], ["footnote": ["number": 1]],
        ["hyperlink": ["target": ["url": "https://example.org"], "run": ["string": " after"]]],
      ]
    ])
    #expect(paragraph.plainText == "Before \u{FFFC}\u{FFFC} after")
    #expect(paragraph.runs.map(\.string) == ["Before ", " after"])
  }

  @Test(arguments: ["\n", "\r", "\u{2029}", "\r\n"])
  func theSeparatorsEndAParagraph(_ separator: String) {
    #expect(ParagraphSeparator.first(in: "a\(separator)b") != nil)
    #expect(ParagraphSeparator.split("a\(separator)b").map(String.init) == ["a", "b"])
  }

  @Test(arguments: ["\u{2028}", "\u{0085}", "\u{000B}", "\u{000C}", " "])
  func otherCharactersDoNot(_ other: String) {
    #expect(ParagraphSeparator.first(in: "a\(other)b") == nil)
  }
}
