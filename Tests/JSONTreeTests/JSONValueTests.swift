import Foundation
import GoldenFiles
import JSONTree
import Testing

struct TextCase: Sendable, CustomTestStringConvertible {
  var name: String
  var text: String
  var testDescription: String { name }

  static let wellFormed: [TextCase] = [
    TextCase(name: "scalars", text: #"[null, true, false, 0, -7, 1.5, "text", ""]"#),
    TextCase(name: "whole numbers lose their fraction", text: "[1.0, 1e2, -0.0, 2.50]"),
    TextCase(
      name: "numbers at the edges", text: "[9007199254740993, 18446744073709551615, 18446744073709551616, 5e-324, 0.1]"),
    TextCase(
      name: "members are ordered by name", text: #"{"zeta": 1, "Alpha": 2, "alpha": 3, "b10": 4, "b2": 5, "_": 6}"#),
    TextCase(name: "nested", text: #"{"a": {"b": [{"c": []}, {}]}, "d": null}"#),
    TextCase(
      name: "unusual characters",
      text: #"["non-breaking space", "line separator", "😀", "é", "tab\there", "quote\"", "a/b", "\u0001"]"#),
    TextCase(name: "a scalar at the top", text: "\"alone\""),
  ]

  static let malformed: [TextCase] = [
    TextCase(name: "empty", text: ""),
    TextCase(name: "a comment", text: "[1] // one"),
    TextCase(name: "a bare word", text: "[NaN]"),
    TextCase(name: "an unclosed object", text: #"{"a": 1"#),
    TextCase(name: "a lone surrogate", text: #"["\ud800"]"#),
    TextCase(name: "a number beyond a double", text: "[1e400]"),
  ]
}

struct RepeatedCase: Sendable, CustomTestStringConvertible {
  var name: String
  var text: String
  var found: (name: String, path: String)?
  var testDescription: String { name }

  static let all: [RepeatedCase] = [
    RepeatedCase(name: "at the root", text: #"{"a": 1, "a": 2}"#, found: ("a", "<root>")),
    RepeatedCase(name: "inside a member", text: #"{"x": {"b": 1, "c": [], "b": 2}}"#, found: ("b", "x")),
    RepeatedCase(name: "inside an array", text: #"[{"c": 1}, {"d": 1, "d": 2}]"#, found: ("d", "[1]")),
    RepeatedCase(name: "spelt with an escape", text: #"{"a": 1, "\u0061": 2}"#, found: ("a", "<root>")),
    RepeatedCase(name: "spelt with a surrogate pair", text: #"{"\ud83d\ude00": 1, "😀": 2}"#, found: ("😀", "<root>")),
    RepeatedCase(name: "names that differ in case", text: #"{"a": 1, "A": 2}"#, found: nil),
    RepeatedCase(name: "values that spell a name", text: #"{"a": "b", "b": "a", "c": ["a", {"a": 1}]}"#, found: nil),
    RepeatedCase(name: "names that hold structure", text: #"{"a:{": 1, "}": 2, "a:{": 3}"#, found: ("a:{", "<root>")),
    RepeatedCase(
      name: "a repeat after a nested object", text: #"{"a": {"a": 1}, "b": 2, "a": 3}"#, found: ("a", "<root>")),
  ]
}

@Suite struct JSONValueTests {
  let goldens: GoldenFile

  init() throws {
    goldens = try GoldenFile(named: "json-tree", in: .module)
  }

  @Test(arguments: TextCase.wellFormed)
  func readsAndWrites(_ item: TextCase) throws {
    let tree = try JSONValue(parsing: Data(item.text.utf8))
    let compact = String(decoding: try tree.text(.compact), as: UTF8.self)
    let readable = String(decoding: try tree.text(.readable), as: UTF8.self)
    #expect(try JSONValue(parsing: Data(compact.utf8)) == tree)
    #expect(try JSONValue(parsing: Data(readable.utf8)) == tree)
    let got = compact + "\n" + readable
    #expect(got == (try goldens.want("text: \(item.name)", got: got)))
  }

  @Test(arguments: TextCase.malformed)
  func refuses(_ item: TextCase) {
    #expect(throws: JSONTreeError.self) { _ = try JSONValue(parsing: Data(item.text.utf8)) }
  }

  @Test func refusesToWriteANumberThatIsNotFinite() {
    #expect(throws: JSONTreeError.self) { _ = try JSONValue.array([.double(.infinity)]).text() }
    #expect(throws: JSONTreeError.self) { _ = try JSONValue.double(.nan).text() }
  }

  @Test(arguments: [
    ("1", "1.0"), ("[1e2]", "[100]"), (#"{"a": 1, "b": 2}"#, #"{"b": 2, "a": 1.0}"#), ("-0.0", "0"),
  ])
  func equalInAnySpelling(_ left: String, _ right: String) throws {
    let first = try JSONValue(parsing: Data(left.utf8))
    let second = try JSONValue(parsing: Data(right.utf8))
    #expect(first == second)
    #expect(first.hashValue == second.hashValue)
  }

  @Test(arguments: [
    ("1", "true"), ("0", "false"), ("null", "0"), (#"{"a": null}"#, "{}"), ("[1, 2]", "[2, 1]"), ("1", "\"1\""),
  ])
  func distinct(_ left: String, _ right: String) throws {
    #expect(try JSONValue(parsing: Data(left.utf8)) != JSONValue(parsing: Data(right.utf8)))
  }

  @Test(arguments: RepeatedCase.all)
  func refusesARepeatedMemberName(_ item: RepeatedCase) {
    do throws(JSONTreeError) {
      _ = try JSONValue(parsing: Data(item.text.utf8))
      #expect(item.found == nil)
    } catch .repeatedMember(let name, let path) {
      #expect(name == item.found?.name)
      #expect(path.description == item.found?.path)
    } catch {
      Issue.record("unexpected \(error)")
    }
  }

  @Test func aNumberThatIsNotFiniteEqualsItself() {
    #expect(JSONNumber(Double.nan) == JSONNumber(Double.nan))
    #expect(!JSONNumber(Double.nan).isFinite)
  }

  @Test func literalsBuildTheSameTree() throws {
    let built: JSONValue = ["name": "a", "sizes": [1, 2.5, nil], "on": true]
    #expect(built == (try JSONValue(parsing: Data(#"{"on": true, "sizes": [1, 2.5, null], "name": "a"}"#.utf8))))
    #expect(built["sizes"]?[1]?.numberValue?.doubleValue == 2.5)
    #expect(built["sizes"]?[2]?.isNull == true)
    #expect(built["sizes"]?[3] == nil)
    #expect(built[JSONPath([.member("sizes"), .index(0)])]?.numberValue?.intValue == 1)
  }
}
