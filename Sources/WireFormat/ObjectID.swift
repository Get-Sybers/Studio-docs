/// The name by which other objects of a document refer to one object: its `identifier` member.
///
/// The library keeps an identifier as it reads it, and makes a new one only when a caller asks.
public struct ObjectID: RawRepresentable, Sendable, Hashable, ExpressibleByStringLiteral, CustomStringConvertible {
  /// The identifier as written.
  public let rawValue: String

  /// Creates an identifier from its text.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// Creates an identifier from a literal.
  public init(stringLiteral value: String) {
    rawValue = value
  }

  /// The identifier as written.
  public var description: String { rawValue }
}
