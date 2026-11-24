public import JSONTree

extension Array: WireValue where Element: WireValue {
  /// Reads a JSON array, each element as `Element`.
  public init(wire value: JSONValue) throws(WireError) {
    guard case .array(let elements) = value else {
      throw .unexpectedKind(expected: .array, found: value.kind, at: .root)
    }
    var items: [Element] = []
    items.reserveCapacity(elements.count)
    for (index, element) in elements.enumerated() {
      items.append(try Element.read(element, under: .index(index)))
    }
    self = items
  }

  /// The elements as a JSON array.
  public var wireValue: JSONValue { .array(map(\.wireValue)) }
}
