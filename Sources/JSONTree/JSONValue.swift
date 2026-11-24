/// A JSON value held as a tree, so that what a reader does not understand can be written back.
public enum JSONValue: Sendable, Hashable {
  /// The literal `null`.
  case null
  /// `true` or `false`.
  case bool(Bool)
  /// A number.
  case number(JSONNumber)
  /// A string.
  case string(String)
  /// An array.
  case array([JSONValue])
  /// An object.
  case object(JSONObject)

  /// Makes a whole number.
  public static func integer(_ value: Int) -> JSONValue {
    .number(JSONNumber(value))
  }

  /// Makes a number from a double.
  public static func double(_ value: Double) -> JSONValue {
    .number(JSONNumber(value))
  }

  /// The kind of the value.
  public var kind: JSONKind {
    switch self {
    case .null: .null
    case .bool: .boolean
    case .number: .number
    case .string: .string
    case .array: .array
    case .object: .object
    }
  }
}
