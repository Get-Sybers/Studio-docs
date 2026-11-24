public import JSONTree

extension JSONValue: WireValue {
  /// Takes any JSON as it is, for a place whose content the library does not model.
  public init(wire value: JSONValue) throws(WireError) {
    self = value
  }

  /// The value itself.
  public var wireValue: JSONValue { self }
}
