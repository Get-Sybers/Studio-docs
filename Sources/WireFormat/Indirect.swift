public import JSONTree

/// A value kept out of line, so that a type of the format can hold a value of its own type.
///
/// It reads and writes as the value itself; only the Swift storage differs.
public indirect enum Indirect<Value: WireValue & Hashable>: WireValue, Hashable {
  /// The value.
  case boxed(Value)

  /// Boxes a value.
  public init(_ value: Value) {
    self = .boxed(value)
  }

  /// The value itself.
  public var value: Value {
    get {
      switch self {
      case .boxed(let value): value
      }
    }
    set { self = .boxed(newValue) }
  }

  /// Reads the value.
  public init(wire value: JSONValue) throws(WireError) {
    self = .boxed(try Value(wire: value))
  }

  /// The value as JSON.
  public var wireValue: JSONValue { value.wireValue }
}

extension Indirect: Codable where Value: Codable {
  /// Reads the value through any decoder.
  public init(from decoder: any Decoder) throws {
    self = .boxed(try Value(from: decoder))
  }

  /// Writes the value through any encoder.
  public func encode(to encoder: any Encoder) throws {
    try value.encode(to: encoder)
  }
}
