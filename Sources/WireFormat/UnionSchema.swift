/// The facts of one union type of the format: its name, its version and its cases.
public struct UnionSchema: Sendable, Hashable {
  /// One form that a value of the union may take.
  public struct Case: Sendable, Hashable {
    /// The name of the case, which is the name of its member in JSON.
    public var name: String
    /// The version of the union that introduced the case.
    public var since: FormatVersion
    /// Whether the case has no contents, so that its name alone is written.
    public var isValueless: Bool

    /// Creates the description of a case.
    public init(_ name: String, since: FormatVersion = .initial, isValueless: Bool = false) {
      self.name = name
      self.since = since
      self.isValueless = isValueless
    }
  }

  /// The name of the type.
  public let typeIdentifier: TypeIdentifier
  /// The latest version of the type that the library models.
  public let version: FormatVersion
  /// The cases, in the order of the format's own listing.
  public let cases: [Case]

  /// Creates a schema.
  public init(typeIdentifier: TypeIdentifier, version: FormatVersion = .initial, cases: [Case]) {
    self.typeIdentifier = typeIdentifier
    self.version = version
    self.cases = cases
  }

  /// The description of a case, if the schema lists it.
  public func `case`(named name: String) -> Case? {
    cases.first { $0.name == name }
  }
}
