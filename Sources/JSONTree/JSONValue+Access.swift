extension JSONValue {
  /// Whether the value is `null`.
  public var isNull: Bool {
    self == .null
  }

  /// The string, when the value is one.
  public var stringValue: String? {
    if case .string(let text) = self { text } else { nil }
  }

  /// The Boolean, when the value is one.
  public var boolValue: Bool? {
    if case .bool(let flag) = self { flag } else { nil }
  }

  /// The number, when the value is one.
  public var numberValue: JSONNumber? {
    if case .number(let number) = self { number } else { nil }
  }

  /// The elements, when the value is an array.
  public var arrayValue: [JSONValue]? {
    if case .array(let elements) = self { elements } else { nil }
  }

  /// The object, when the value is one.
  public var objectValue: JSONObject? {
    if case .object(let object) = self { object } else { nil }
  }

  /// The value of a member, when the value is an object that has it.
  public subscript(name: String) -> JSONValue? {
    objectValue?[name]
  }

  /// The element at an index, when the value is an array that reaches it.
  public subscript(index: Int) -> JSONValue? {
    guard let elements = arrayValue, elements.indices.contains(index) else { return nil }
    return elements[index]
  }

  /// The value at a path below this one, when every step of the path exists.
  public subscript(path: JSONPath) -> JSONValue? {
    var value = self
    for component in path.components {
      let next: JSONValue? =
        switch component {
        case .member(let name): value[name]
        case .index(let index): value[index]
        }
      guard let next else { return nil }
      value = next
    }
    return value
  }
}
