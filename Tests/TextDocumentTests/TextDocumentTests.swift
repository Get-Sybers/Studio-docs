import Appearance
import DocumentPackage
import DocumentValidation
import Foundation
import GoldenFiles
import JSONTree
import ModelFixtures
import PageSizes
import PresetStyles
import Testing
import TextDocument
import TextModel
import WireFormat

@Suite struct TextDocumentTests {
  static let types: [ModelledType] = [ModelledType(TextDocumentBody.self), ModelledType(TextSection.self)]

  let goldens: GoldenFile
  let fixtures: FixtureFile

  init() throws {
    goldens = try GoldenFile(named: "text-document", in: .module)
    fixtures = try FixtureFile(named: "text-document", in: .module)
  }

  @Test(arguments: types)
  func readsAndWritesEveryMember(_ type: ModelledType) throws {
    let result = ModelCheck.roundTrip(type, sample: try fixtures.sample(type.name))
    #expect(result.defects == [])
    let got = String(decoding: try result.written.text(.readable), as: UTF8.self)
    #expect(got == (try goldens.want("type: \(type.name)", got: got)))
  }

  @Test func theTableListsWhatTheTargetModels() {
    #expect(ModelCheck.agreement(types: Self.types, fixtures: fixtures, table: TextDocumentFormat.table) == [])
  }

  // The example of the README, as it stands there.
  @Test func createSaveReopen() throws {
    let url = FileManager.default.temporaryDirectory.appendingPathComponent("\(UUID().uuidString).studio")
    defer { try? FileManager.default.removeItem(at: url) }

    let styled = Paragraph(contents: [
      .text("Low water at "), .text("six", style: CharacterProperties(italic: true)), .text("."),
    ])
    var body = TextDocumentBody(title: .string("Harbour notes"))
    body.sections.append(
      TextSection(
        heading: .string("Monday"), text: .paragraphs([styled, Paragraph("The boats leaned on their keels.")])))
    try StudioDocument(body: body).write(to: url)

    let reopened = try StudioDocument<TextDocumentBody>(contentsOf: url)
    #expect(reopened.body == body)
    #expect(reopened.body.plainText == "Harbour notes\nMonday\nLow water at six.\nThe boats leaned on their keels.")
    #expect(reopened.validate().findings == [])
    let got = String(decoding: try reopened.body.mainTree.text(.readable), as: UTF8.self)
    #expect(got == (try goldens.want("the example of the README", got: got)))
  }

  @Test func aPageSizeTravelsWithTheDocument() throws {
    var body = TextDocumentBody(sections: [TextSection(heading: "One", paragraphs: ["First."])])
    body.pageSize = PageSizeCatalogue.named("US Trade")?.size
    let tree = StudioDocument(body: body).body.mainTree
    #expect(tree["page_size"]?["width"] == 432)
    #expect(tree["version"] == nil)
    let reopened = try StudioDocument<TextDocumentBody>(archive: try StudioDocument(body: body).archive())
    #expect(reopened.body.pageSize == SizeValue(width: 432, height: 648))
  }

  @Test func validationKnowsTheTypesOfTheBody() throws {
    var body = TextDocumentBody(sections: [
      TextSection(heading: "One", paragraphs: ["First."]), TextSection(heading: "Two", paragraphs: ["Second.\nThird."]),
    ])
    body.sections[0].identifier = "s-1"
    body.sections[1].identifier = "s-1"
    var styled = Paragraph("Styled.")
    styled.style = ParagraphProperties()
    styled.style?.presetIdentifier = "body"
    body.sections[0].text = .paragraphs([styled])
    var named = NamedParagraphStyle(properties: ParagraphProperties(alignment: .value(.justified)), name: "Body")
    named.presetIdentifier = "body"
    body.stylesheet = Stylesheet(paragraphStyles: [named])
    let report = StudioDocument(body: body).validate()
    let got = report.findings.map(\.description).joined(separator: "\n")
    #expect(got == (try goldens.want("validation of a text document", got: got)))

    let broken = try JSONValue(
      parsing: Data(#"{"type_identifier": "io.github.get-sybers.studio-docs.text-document"}"#.utf8))
    let findings = DocumentValidator.validate(ValidationInput(main: broken, schemas: TextDocumentBody.schemas)).findings
    #expect(
      findings.map(\.kind) == [
        .missingMember(type: "io.github.get-sybers.studio-docs.text-document", member: "sections")
      ])
  }

  @Test func theEffectivePropertiesOfAParagraphComeThroughTheStylesheet() throws {
    var named = NamedParagraphStyle(
      properties: ParagraphProperties(
        alignment: .value(.justified), characterProperties: CharacterProperties(fontSize: 11)),
      name: "Body")
    named.presetIdentifier = "body"
    var paragraph = Paragraph(contents: [.text("Plain "), .text("stressed", style: CharacterProperties(italic: true))])
    paragraph.style = ParagraphProperties(spaceAfter: 6)
    paragraph.style?.presetIdentifier = "body"
    let resolver = PresetResolver([], stylesheet: Stylesheet(paragraphStyles: [named]))
    let properties = try resolver.paragraphProperties(of: paragraph)
    #expect(properties.alignment == .value(.justified))
    #expect(properties.spaceAfter == 6)
    let stressed = try resolver.characterProperties(of: paragraph.runs[1], in: paragraph)
    #expect(stressed.italic == true)
    #expect(stressed.fontSize == 11)
  }
}
