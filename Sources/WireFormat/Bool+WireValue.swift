public import JSONTree

extension Bool: WireValue {
  /// Reads a JSON Boolean; a string or a number is none.
  public init(wire value: JSONValue) throws(WireError) {
    guard case .bool(let flag) = value else {
      throw .unexpectedKind(expected: .boolean, found: value.kind, at: .root)
    }
    self = flag
  }

  /// The Boolean as JSON.
  public var wireValue: JSONValue { .bool(self) }
}
