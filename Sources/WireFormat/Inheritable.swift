/// A property that an object may leave to its preset, clear with `null`, or set.
///
/// A value is kept out of line, so that a type with many such members stays small.
public indirect enum Inheritable<Value> {
  /// The member is omitted: the value comes from the preset chain, then from the declared default.
  case inherited
  /// The member is `null`: the property has no value, whatever a preset says.
  case cleared
  /// The member holds a value.
  case value(Value)

  /// Wraps an optional: nil is `.inherited`.
  public init(_ value: Value?) {
    self = value.map(Inheritable.value) ?? .inherited
  }

  /// The value that the object itself sets, or nil when it inherits or clears.
  public var value: Value? {
    if case .value(let value) = self { value } else { nil }
  }

  /// Whether the member is omitted.
  public var isInherited: Bool {
    if case .inherited = self { true } else { false }
  }

  /// Whether the member is `null`.
  public var isCleared: Bool {
    if case .cleared = self { true } else { false }
  }

  /// Returns the same state with its value transformed.
  public func map<Other, Failure: Error>(
    _ transform: (Value) throws(Failure) -> Other
  ) throws(Failure) -> Inheritable<Other> {
    switch self {
    case .inherited: .inherited
    case .cleared: .cleared
    case .value(let value): .value(try transform(value))
    }
  }
}

extension Inheritable: Sendable where Value: Sendable {}
extension Inheritable: Equatable where Value: Equatable {}
extension Inheritable: Hashable where Value: Hashable {}
