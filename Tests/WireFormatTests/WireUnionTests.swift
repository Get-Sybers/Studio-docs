import Foundation
import GoldenFiles
import JSONTree
import Testing
import WireFormat

struct UnionCase: Sendable, CustomTestStringConvertible {
  var name: String
  var json: String
  var edit: @Sendable (inout Coating) -> Void = { _ in }
  var testDescription: String { name }

  static let all: [UnionCase] = [
    UnionCase(name: "a case with contents", json: #"{"label": "primer"}"#),
    UnionCase(name: "a case that holds an object", json: #"{"swatch": {"name": "ochre", "x-note": "kept"}}"#),
    UnionCase(name: "a case with no contents, as a string", json: #""bare""#),
    UnionCase(name: "a case with no contents, as a member", json: #"{"bare": null}"#),
    UnionCase(name: "a case with no contents beside a preset", json: #"{"bare": null, "preset_identifier": "thin"}"#),
    UnionCase(name: "a preset alone", json: #"{"preset_identifier": "thin"}"#),
    UnionCase(name: "a later case", json: #"{"glaze": 0.3}"#),
    UnionCase(
      name: "a later case under an earlier version is not read",
      json: #"{"glaze": 0.3, "label": "old", "version": "1.0"}"#),
    UnionCase(name: "a case the library does not model", json: #"{"varnish": {"coats": 2}}"#),
    UnionCase(name: "a name the library does not model", json: #""lacquer""#),
    UnionCase(name: "two cases: the newest is read", json: #"{"label": "old", "glaze": 0.3}"#),
    UnionCase(
      name: "two cases: the named one is read", json: #"{"label": "old", "glaze": 0.3, "primary_case": "label"}"#),
    UnionCase(
      name: "an unmodelled primary beside a modelled case",
      json: #"{"label": "fallback", "varnish": {"coats": 2}, "primary_case": "varnish"}"#),
    UnionCase(
      name: "a new form drops a primary that names a case no longer there",
      json: #"{"label": "old", "primary_case": "label"}"#, edit: { $0.form = .glaze(1) }),
    UnionCase(
      name: "a new form keeps a primary whose case is still there",
      json: #"{"label": "fallback", "varnish": {"coats": 2}, "primary_case": "varnish"}"#,
      edit: { $0.form = .label("new") }),
    UnionCase(
      name: "every envelope member",
      json: #"{"type_identifier": "org.example.coating", "version": "1.1", "label": "x"}"#),
  ]

  static let refused: [UnionCase] = [
    UnionCase(name: "the value is a number", json: "3"),
    UnionCase(name: "the contents are of another kind", json: #"{"label": 3}"#),
    UnionCase(name: "the fault lies inside the contents", json: #"{"swatch": {"name": "a", "layers": [{}]}}"#),
    UnionCase(name: "the value names another type", json: #"{"type_identifier": "org.example.swatch", "label": "x"}"#),
    UnionCase(name: "the value declares a later major version", json: #"{"version": "3.1", "label": "x"}"#),
  ]
}

@Suite struct WireUnionTests {
  let goldens: GoldenFile

  init() throws {
    goldens = try GoldenFile(named: "wire-format", in: .module)
  }

  @Test(arguments: UnionCase.all)
  func roundTrip(_ item: UnionCase) throws {
    var coating = try Coating(wire: try JSONValue(parsing: Data(item.json.utf8)))
    let read =
      "form \(coating.form.map { Coating.member(for: $0).name } ?? "nil"), unmodelled \(coating.envelope.unmodelled.keys)"
    item.edit(&coating)
    let written = coating.wireValue
    #expect(try Coating(wire: written).wireValue == written)
    let got = read + "\n" + String(decoding: try written.text(), as: UTF8.self)
    #expect(got == (try goldens.want("union: \(item.name)", got: got)))
  }

  @Test(arguments: UnionCase.refused)
  func refuses(_ item: UnionCase) throws {
    let tree = try JSONValue(parsing: Data(item.json.utf8))
    var got = "accepted"
    do throws(WireError) {
      _ = try Coating(wire: tree)
    } catch {
      got = "\(error) at \(error.path)"
    }
    #expect(got == (try goldens.want("union refused: \(item.name)", got: got)))
    #expect(got != "accepted")
  }

  @Test func aFormAloneIsWrittenWithItsType() throws {
    #expect(
      try Coating(.label("primer")).wireValue.text()
        == Data(#"{"label":"primer","type_identifier":"org.example.coating"}"#.utf8))
    #expect(Coating(.bare).wireValue == "bare")
    #expect(Coating(.glaze(2)).wireValue["version"] == nil)
  }
}
