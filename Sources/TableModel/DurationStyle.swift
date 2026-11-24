public import WireFormat

/// The enumeration `Style` of the format.
public struct DurationStyle: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The value `compact`.
  public static let compact = DurationStyle(rawValue: "compact")
  /// The value `long`.
  public static let long = DurationStyle(rawValue: "long")
  /// The value `short`.
  public static let short = DurationStyle(rawValue: "short")

  /// The values that the library knows, from the format table.
  public static let modelled = TableModelFormat.table.values(of: "DurationStyle").map(DurationStyle.init(rawValue:))
}
