/// The reverse-DNS name of a type of the format, as an object carries it in `type_identifier`.
public struct TypeIdentifier: RawRepresentable, Sendable, Hashable, ExpressibleByStringLiteral, CustomStringConvertible
{
  /// The name as written.
  public let rawValue: String

  /// Creates an identifier from its text.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// Creates an identifier from a literal.
  public init(stringLiteral value: String) {
    rawValue = value
  }

  /// The name as written.
  public var description: String { rawValue }
}
