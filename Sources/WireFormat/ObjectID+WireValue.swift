public import JSONTree

extension ObjectID: WireValue {
  /// Reads a JSON string as an identifier.
  public init(wire value: JSONValue) throws(WireError) {
    self.init(rawValue: try String(wire: value))
  }

  /// The identifier as a JSON string.
  public var wireValue: JSONValue { .string(rawValue) }
}
