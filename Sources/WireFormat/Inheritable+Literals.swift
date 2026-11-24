extension Inheritable: ExpressibleByBooleanLiteral where Value: ExpressibleByBooleanLiteral {
  /// Creates `.value` from a Boolean literal.
  public init(booleanLiteral value: Value.BooleanLiteralType) {
    self = .value(Value(booleanLiteral: value))
  }
}

extension Inheritable: ExpressibleByIntegerLiteral where Value: ExpressibleByIntegerLiteral {
  /// Creates `.value` from an integer literal.
  public init(integerLiteral value: Value.IntegerLiteralType) {
    self = .value(Value(integerLiteral: value))
  }
}

extension Inheritable: ExpressibleByFloatLiteral where Value: ExpressibleByFloatLiteral {
  /// Creates `.value` from a floating-point literal.
  public init(floatLiteral value: Value.FloatLiteralType) {
    self = .value(Value(floatLiteral: value))
  }
}

extension Inheritable: ExpressibleByUnicodeScalarLiteral where Value: ExpressibleByUnicodeScalarLiteral {
  /// Creates `.value` from a scalar literal.
  public init(unicodeScalarLiteral value: Value.UnicodeScalarLiteralType) {
    self = .value(Value(unicodeScalarLiteral: value))
  }
}

extension Inheritable: ExpressibleByExtendedGraphemeClusterLiteral
where Value: ExpressibleByExtendedGraphemeClusterLiteral {
  /// Creates `.value` from a character literal.
  public init(extendedGraphemeClusterLiteral value: Value.ExtendedGraphemeClusterLiteralType) {
    self = .value(Value(extendedGraphemeClusterLiteral: value))
  }
}

extension Inheritable: ExpressibleByStringLiteral where Value: ExpressibleByStringLiteral {
  /// Creates `.value` from a string literal.
  public init(stringLiteral value: Value.StringLiteralType) {
    self = .value(Value(stringLiteral: value))
  }
}
