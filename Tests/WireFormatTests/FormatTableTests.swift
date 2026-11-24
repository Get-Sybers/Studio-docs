import Foundation
import JSONTree
import Testing
import WireFormat

struct TableCase: Sendable, CustomTestStringConvertible {
  var name: String
  var json: String
  var testDescription: String { name }

  static let object =
    #"{"type": "org.example.a", "name": "A", "version": "1.1", "members": [{"name": "x", "kind": "required"}]}"#

  static let defective: [TableCase] = [
    TableCase(name: "two types share a Swift name", json: #"{"objects": [\#(object), \#(object)], "unions": []}"#),
    TableCase(
      name: "a member is listed twice",
      json:
        #"{"objects": [{"type": "t", "name": "A", "version": "1.0", "members": [{"name": "x"}, {"name": "x"}]}], "unions": []}"#
    ),
    TableCase(
      name: "a member is newer than its type",
      json:
        #"{"objects": [{"type": "t", "name": "A", "version": "1.0", "members": [{"name": "x", "since": "1.1"}]}], "unions": []}"#
    ),
    TableCase(
      name: "a range is empty",
      json:
        #"{"objects": [{"type": "t", "name": "A", "version": "1.0", "members": [{"name": "x", "minimum": 2, "maximum": 1}]}], "unions": []}"#
    ),
    TableCase(
      name: "a kind is unknown",
      json:
        #"{"objects": [{"type": "t", "name": "A", "version": "1.0", "members": [{"name": "x", "kind": "sometimes"}]}], "unions": []}"#
    ),
    TableCase(
      name: "a version does not parse",
      json: #"{"objects": [{"type": "t", "name": "A", "version": "one", "members": []}], "unions": []}"#),
    TableCase(
      name: "an object has no member list",
      json: #"{"objects": [{"type": "t", "name": "A", "version": "1.0"}], "unions": []}"#),
    TableCase(
      name: "a union has no cases",
      json: #"{"objects": [], "unions": [{"type": "t", "name": "A", "version": "1.0", "cases": []}]}"#),
    TableCase(name: "the file is no table", json: "[]"),
  ]
}

@Suite struct FormatTableTests {
  @Test func decodesWhatATargetEmbeds() throws {
    let json = #"""
      {"objects": [{"type": "org.example.a", "name": "A", "version": "1.1", "members": [
         {"name": "x", "kind": "required", "minimum": 0, "maximum": 1},
         {"name": "y", "kind": "inheritable", "since": "1.1", "default": [1, "two"], "minimumCount": 1, "maximumCount": 9}]}],
       "unions": [{"type": "org.example.b", "name": "B", "version": "1.0", "cases": [{"name": "p"}, {"name": "q", "valueless": true}]}]}
      """#
    let table = try FormatTable(decoding: Array(json.utf8), target: "Tests")
    let object = table.object(named: "A")
    #expect(object.typeIdentifier == "org.example.a")
    #expect(object.version == FormatVersion(1, 1))
    #expect(object.members.map(\.name) == ["x", "y"])
    #expect(object.member(named: "x")?.kind == .required)
    #expect(object.member(named: "x")?.maximum == 1)
    #expect(object.member(named: "y")?.since == FormatVersion(1, 1))
    #expect(object.member(named: "y")?.defaultValue == [1, "two"])
    #expect(object.member(named: "y")?.maximumCount == 9)
    #expect(object.introductions == ["y": FormatVersion(1, 1)])
    let union = table.union(named: "B")
    #expect(union.case(named: "q")?.isValueless == true)
    #expect(union.case(named: "p")?.isValueless == false)
  }

  @Test(arguments: TableCase.defective)
  func refuses(_ item: TableCase) {
    #expect(throws: (any Error).self) { _ = try FormatTable(decoding: Array(item.json.utf8), target: "Tests") }
  }

  @Test(arguments: [
    ("1.0", FormatVersion(1, 0)), ("12.34", FormatVersion(12, 34)), ("2", FormatVersion(2, 0)),
    ("01.007", FormatVersion(1, 7)),
  ])
  func parsesAVersion(_ text: String, _ want: FormatVersion) {
    #expect(FormatVersion(text) == want)
  }

  @Test(arguments: ["", "1.", ".1", "1.2.3", "a.b", "1.0 ", "-1.0", "1,0", "١.٠"])
  func refusesAVersion(_ text: String) {
    #expect(FormatVersion(text) == nil)
  }

  @Test func ordersVersions() {
    #expect(FormatVersion(1, 9) < FormatVersion(2, 0))
    #expect(FormatVersion(1, 2) < FormatVersion(1, 10))
    #expect(FormatVersion(1, 0).description == "1.0")
  }
}
