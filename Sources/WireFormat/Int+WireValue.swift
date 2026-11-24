public import JSONTree

extension Int: WireValue {
  /// Reads a JSON number that has no fraction; `2.0` is the integer 2.
  public init(wire value: JSONValue) throws(WireError) {
    guard case .number(let number) = value else {
      throw .unexpectedKind(expected: .number, found: value.kind, at: .root)
    }
    guard let whole = number.intValue else { throw .notAnInteger(at: .root) }
    self = whole
  }

  /// The integer as JSON.
  public var wireValue: JSONValue { .integer(self) }
}
