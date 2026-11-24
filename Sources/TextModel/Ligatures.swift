public import WireFormat

/// Which ligatures of the font a reader uses.
public struct Ligatures: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The optional ones as well.
  public static let all = Ligatures(rawValue: "all")
  /// Only those that correct layout needs.
  public static let required = Ligatures(rawValue: "required")
  /// Those that the font marks as standard.
  public static let standard = Ligatures(rawValue: "standard")

  /// The values that the library knows, from the format table.
  public static let modelled = TextFormat.table.values(of: "Ligatures").map(Ligatures.init(rawValue:))
}
