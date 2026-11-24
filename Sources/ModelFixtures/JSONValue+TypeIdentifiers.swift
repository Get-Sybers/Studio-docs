package import JSONTree

extension JSONValue {
  /// The value with every `type_identifier` member removed, to compare with a sample written without them.
  package var withoutTypeIdentifiers: JSONValue {
    switch self {
    case .array(let elements):
      return .array(elements.map(\.withoutTypeIdentifiers))
    case .object(let object):
      var stripped = JSONObject()
      for (name, value) in object where name != "type_identifier" {
        stripped[name] = value.withoutTypeIdentifiers
      }
      return .object(stripped)
    case .null, .bool, .number, .string:
      return self
    }
  }
}
