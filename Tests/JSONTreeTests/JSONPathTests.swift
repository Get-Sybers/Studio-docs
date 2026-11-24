import JSONTree
import Testing

@Suite struct JSONPathTests {
  @Test(arguments: [
    (JSONPath.root, "<root>"),
    (JSONPath.root.member("sections").index(2).member("paragraphs").index(0), "sections[2].paragraphs[0]"),
    (JSONPath.root.index(3).member("type_identifier"), "[3].type_identifier"),
    (JSONPath.root.member("a b").member("c"), "[\"a b\"].c"),
    (JSONPath.root.member(""), "[\"\"]"),
  ])
  func describes(_ path: JSONPath, _ want: String) {
    #expect(path.description == want)
  }

  @Test func walkVisitsAParentBeforeItsChildren() {
    let tree: JSONValue = ["b": [1, ["c": true]], "a": "x"]
    var got: [String] = []
    tree.walk { value, steps in got.append("\(JSONPath(steps)) \(value.kind.rawValue)") }
    #expect(got == ["<root> object", "b array", "b[0] number", "b[1] object", "b[1].c boolean", "a string"])
  }
}
