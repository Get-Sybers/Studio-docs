public import JSONTree

extension String: WireValue {
  /// Reads a JSON string.
  public init(wire value: JSONValue) throws(WireError) {
    guard case .string(let text) = value else {
      throw .unexpectedKind(expected: .string, found: value.kind, at: .root)
    }
    self = text
  }

  /// The string as JSON.
  public var wireValue: JSONValue { .string(self) }
}
