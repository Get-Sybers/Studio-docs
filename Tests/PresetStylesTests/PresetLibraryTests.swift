import Foundation
import GoldenFiles
import JSONTree
import PresetStyles
import Testing
import TextModel
import WireFormat

struct LibraryCase: Sendable, CustomTestStringConvertible {
  var name: String
  var json: String
  var testDescription: String { name }

  static let refused: [LibraryCase] = [
    LibraryCase(name: "the file is an object", json: #"{"identifier": "a", "properties": {}}"#),
    LibraryCase(name: "an entry is no object", json: #"["a"]"#),
    LibraryCase(name: "an entry has no identifier", json: #"[{"properties": {}}]"#),
    LibraryCase(name: "an identifier is no string", json: #"[{"identifier": 7, "properties": {}}]"#),
    LibraryCase(name: "an entry has no properties", json: #"[{"identifier": "a"}]"#),
    LibraryCase(name: "the properties are no object", json: #"[{"identifier": "a", "properties": [1]}]"#),
    LibraryCase(
      name: "a display name is no string", json: #"[{"identifier": "a", "properties": {}, "display_name": 1}]"#),
    LibraryCase(
      name: "a parent is no string", json: #"[{"identifier": "a", "properties": {}, "parent_identifier": {}}]"#),
  ]
}

@Suite struct PresetLibraryTests {
  let goldens: GoldenFile

  init() throws {
    goldens = try GoldenFile(named: "preset-styles", in: .module)
  }

  @Test func readsAndWritesWhatItDoesNotKnow() throws {
    let json = #"""
      [{"identifier": "body", "display_name": "Body", "properties": {"alignment": "left", "later": {"x": [1]}}, "x-origin": "import"},
       {"identifier": "quote", "parent_identifier": "body", "properties": {"left_indent": 18}, "display_name": null},
       {"identifier": "quote", "properties": {}}]
      """#
    let tree = try JSONValue(parsing: Data(json.utf8))
    let library = try PresetLibrary(wire: tree)
    #expect(library.wireValue == tree)
    #expect(library.presets.map(\.identifier) == ["body", "quote", "quote"])
    #expect(library["body"]?.displayName == "Body")
    #expect(library["quote"]?.parentIdentifier == nil)
    #expect(library.duplicateIdentifiers == ["quote"])
    let got = String(decoding: try library.wireValue.text(.readable), as: UTF8.self)
    #expect(got == (try goldens.want("library: reads and writes what it does not know", got: got)))
  }

  @Test(arguments: LibraryCase.refused)
  func refuses(_ item: LibraryCase) throws {
    let tree = try JSONValue(parsing: Data(item.json.utf8))
    var got = "accepted"
    do throws(PresetError) {
      _ = try PresetLibrary(wire: tree)
    } catch {
      got = "\(error)"
    }
    #expect(got == (try goldens.want("library refused: \(item.name)", got: got)))
    #expect(got != "accepted")
  }

  @Test func aPresetIsBuiltFromTypedProperties() throws {
    let preset = Preset(
      identifier: "stress", properties: CharacterProperties(italic: true, underline: .cleared), displayName: "Stress",
      parentIdentifier: "body")
    let got = String(decoding: try PresetLibrary([preset]).wireValue.text(), as: UTF8.self)
    #expect(got == (try goldens.want("library: a preset built from typed properties", got: got)))
  }

  @Test func anEmptyLibraryIsAnEmptyArray() throws {
    #expect(PresetLibrary().wireValue == [])
    #expect(try PresetLibrary(wire: []).presets.isEmpty)
  }
}
