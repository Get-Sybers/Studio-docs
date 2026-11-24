public import JSONTree

extension Double: WireValue {
  /// Reads a JSON number.
  public init(wire value: JSONValue) throws(WireError) {
    guard case .number(let number) = value else {
      throw .unexpectedKind(expected: .number, found: value.kind, at: .root)
    }
    self = number.doubleValue
  }

  /// The number as JSON; a value that is not finite has no JSON text, and validation reports it.
  public var wireValue: JSONValue { .double(self) }
}
