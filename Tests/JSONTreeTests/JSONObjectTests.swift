import JSONTree
import Testing

@Suite struct JSONObjectTests {
  @Test func keepsTheOrderOfInsertion() {
    var object = JSONObject()
    object["zeta"] = 1
    object["alpha"] = 2
    object["mid"] = nil
    object["zeta"] = 3
    #expect(object.keys == ["zeta", "alpha"])
    #expect(object.map(\.key) == ["zeta", "alpha"])
    object.sortKeys()
    #expect(object.keys == ["alpha", "zeta"])
    #expect(object.removeValue(forKey: "alpha") == 2)
    #expect(object.count == 1)
  }

  @Test func aNullMemberIsAMember() {
    let object: JSONObject = ["cleared": nil]
    #expect(object.contains("cleared"))
    #expect(object["cleared"] == .some(.null))
    #expect(!object.contains("absent"))
  }

  @Test func mergingKeepsItsOwnMembers() {
    let own: JSONObject = ["a": 1, "b": nil]
    let lower: JSONObject = ["b": 2, "c": 3]
    #expect(own.merging(over: lower) == ["a": 1, "b": nil, "c": 3])
  }
}
