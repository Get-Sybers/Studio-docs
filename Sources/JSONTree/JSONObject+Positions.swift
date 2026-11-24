import OrderedCollections

extension JSONObject {
  /// The place of a member in the iteration order, which a reader uses to mark what it has taken.
  package func position(of name: String) -> Int? {
    members.index(forKey: name)
  }

  /// The member at a place in the iteration order.
  package func member(at position: Int) -> (name: String, value: JSONValue) {
    let element = members.elements[position]
    return (element.key, element.value)
  }
}
