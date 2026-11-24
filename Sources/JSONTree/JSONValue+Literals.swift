extension JSONValue: ExpressibleByNilLiteral, ExpressibleByBooleanLiteral, ExpressibleByIntegerLiteral,
  ExpressibleByFloatLiteral, ExpressibleByStringLiteral, ExpressibleByArrayLiteral, ExpressibleByDictionaryLiteral
{
  /// Creates `null`.
  public init(nilLiteral: ()) {
    self = .null
  }

  /// Creates a Boolean.
  public init(booleanLiteral value: Bool) {
    self = .bool(value)
  }

  /// Creates a whole number.
  public init(integerLiteral value: Int64) {
    self = .number(JSONNumber(value))
  }

  /// Creates a number.
  public init(floatLiteral value: Double) {
    self = .number(JSONNumber(value))
  }

  /// Creates a string.
  public init(stringLiteral value: String) {
    self = .string(value)
  }

  /// Creates an array.
  public init(arrayLiteral elements: JSONValue...) {
    self = .array(elements)
  }

  /// Creates an object; a later pair replaces an earlier one of the same name.
  public init(dictionaryLiteral elements: (String, JSONValue)...) {
    self = .object(JSONObject(elements))
  }
}
