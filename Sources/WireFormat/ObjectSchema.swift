public import JSONTree

/// The facts of one object type of the format: its name, its version and what the format says of its members.
public struct ObjectSchema: Sendable, Hashable {
  /// What the format says of one member.
  public struct Member: Sendable, Hashable {
    /// How a member may be absent.
    public enum Kind: String, Sendable, Hashable, Decodable {
      /// It has to be present and may not be `null`.
      case required
      /// It may be omitted, and may not be `null`.
      case optional
      /// It may be omitted, to inherit, and may be `null`, to clear.
      case inheritable
    }

    /// The name of the member in JSON.
    public var name: String
    /// How the member may be absent.
    public var kind: Kind
    /// The version of the type that introduced the member.
    public var since: FormatVersion
    /// The value that the format declares for an omitted member, if it declares one.
    public var defaultValue: JSONValue?
    /// The least number the member may hold.
    public var minimum: Double?
    /// The greatest number the member may hold.
    public var maximum: Double?
    /// The least number of elements the member may hold.
    public var minimumCount: Int?
    /// The greatest number of elements the member may hold.
    public var maximumCount: Int?

    /// Creates the description of a member; only the name is needed.
    public init(
      _ name: String, kind: Kind = .optional, since: FormatVersion = .initial, defaultValue: JSONValue? = nil,
      minimum: Double? = nil, maximum: Double? = nil, minimumCount: Int? = nil, maximumCount: Int? = nil
    ) {
      self.name = name
      self.kind = kind
      self.since = since
      self.defaultValue = defaultValue
      self.minimum = minimum
      self.maximum = maximum
      self.minimumCount = minimumCount
      self.maximumCount = maximumCount
    }
  }

  /// The name of the type.
  public let typeIdentifier: TypeIdentifier
  /// The latest version of the type that the library models.
  public let version: FormatVersion
  /// The members, in the order of the format's own listing.
  public let members: [Member]
  /// The members that a later version than 1.0 introduced.
  package let introductions: [String: FormatVersion]

  /// Creates a schema; a type of a client's own needs no more than its identifier.
  public init(typeIdentifier: TypeIdentifier, version: FormatVersion = .initial, members: [Member] = []) {
    self.typeIdentifier = typeIdentifier
    self.version = version
    self.members = members
    self.introductions = Dictionary(
      members.filter { $0.since > .initial }.map { ($0.name, $0.since) }, uniquingKeysWith: { first, _ in first })
  }

  /// The description of a member, if the schema lists it.
  public func member(named name: String) -> Member? {
    members.first { $0.name == name }
  }
}
