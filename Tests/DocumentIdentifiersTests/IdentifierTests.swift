import DocumentIdentifiers
import Foundation
import GoldenFiles
import JSONTree
import Testing
import TextModel
import WireFormat

@Suite struct IdentifierTests {
  let goldens: GoldenFile

  init() throws {
    goldens = try GoldenFile(named: "document-identifiers", in: .module)
  }

  static let tree: JSONValue = [
    "identifier": "root",
    "sections": [
      ["identifier": "s-1", "paragraphs": [["identifier": "p-1"], ["identifier": "p-2"], [:]]],
      ["identifier": "s-2", "paragraphs": [["identifier": "p-1"], ["identifier": 7], ["identifier": nil]]],
    ],
    "picture": [
      "type_identifier": "com.apple.apps.content-language.resource.indirect-resource", "identifier": "p-2",
      "filename": "p-2",
    ],
  ]

  @Test func indexesEveryIdentifierWithItsPlaces() throws {
    let index = IdentifierIndex(
      of: Self.tree, excluding: ["com.apple.apps.content-language.resource.indirect-resource"])
    let got = index.identifiers.map { "\($0): \(index.paths(of: $0).map(\.description).joined(separator: ", "))" }
      .joined(separator: "\n")
    #expect(got == (try goldens.want("index: every identifier with its places", got: got)))
    #expect(index.duplicates == ["p-1"])
    #expect(index.count == 5)
    #expect(index.contains("s-2"))
    #expect(!index.contains("7"))
    #expect(index.paths(of: "absent").isEmpty)
  }

  @Test func withoutTheExclusionAFileNameCountsAsAnIdentifier() {
    #expect(IdentifierIndex(of: Self.tree).duplicates == ["p-1", "p-2"])
  }

  @Test func mintsTheSameIdentifiersFromTheSameSeed() throws {
    var generator = SeededGenerator(state: 2026)
    var mint = IdentifierMint(avoiding: IdentifierIndex(of: Self.tree))
    let made = (0..<3).map { _ in mint.mint(using: &generator) }
    let got = made.map(\.rawValue).joined(separator: "\n")
    #expect(got == (try goldens.want("mint: three identifiers from a fixed seed", got: got)))
    #expect(Set(made).count == 3)
    #expect(made.allSatisfy { UUID(uuidString: $0.rawValue) != nil && mint.avoids($0) })
    #expect(made.allSatisfy { Array($0.rawValue)[14] == "4" })
  }

  @Test func neverMintsAnIdentifierInUse() {
    var first = SeededGenerator(state: 7)
    var probe = IdentifierMint()
    let expected = probe.mint(using: &first)
    var second = SeededGenerator(state: 7)
    var mint = IdentifierMint(avoiding: [expected])
    let made = mint.mint(using: &second)
    #expect(made != expected)
    #expect(mint.avoids(expected))
    mint.reserve("taken")
    #expect(mint.avoids("taken"))
  }

  @Test func theSystemGeneratorGivesDistinctIdentifiers() {
    var mint = IdentifierMint()
    #expect(mint.mint() != mint.mint())
  }

  @Test func assignsOnlyWhereAnIdentifierIsMissingOrRepeated() throws {
    var generator = SeededGenerator(state: 11)
    var paragraphs = ["kept", "none", "split first", "split second", "kept too"].map { Paragraph($0) }
    paragraphs[0].identifier = "p-1"
    paragraphs[2].identifier = "p-2"
    paragraphs[3].identifier = "p-2"
    paragraphs[4].identifier = "p-3"
    var mint = IdentifierMint(avoiding: ["p-1", "p-2", "p-3", "elsewhere"])
    let changed = mint.assignIdentifiers(to: &paragraphs, using: &generator)
    #expect(changed == [1, 3])
    #expect(paragraphs[0].identifier == "p-1")
    #expect(paragraphs[2].identifier == "p-2")
    #expect(paragraphs[4].identifier == "p-3")
    #expect(Set(paragraphs.compactMap(\.identifier)).count == 5)
    #expect(mint.assignIdentifiers(to: &paragraphs, using: &generator).isEmpty)
    let got = paragraphs.map { "\($0.plainText): \($0.identifier?.rawValue ?? "none")" }.joined(separator: "\n")
    #expect(got == (try goldens.want("mint: assigned to a split and to a new paragraph", got: got)))
  }

  @Test func readingAndWritingNeverChangesAnIdentifier() throws {
    var paragraph = Paragraph("kept")
    paragraph.identifier = "p-0001"
    let reread = try Paragraph(wire: paragraph.wireValue)
    #expect(reread.identifier == "p-0001")
    #expect(try Paragraph(wire: Paragraph("none").wireValue).identifier == nil)
    #expect(Paragraph("none").wireValue["identifier"] == nil)
  }
}
