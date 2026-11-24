public import WireFormat

/// The enumeration `Direction` of the format.
public struct SortDirection: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The value `ascending`.
  public static let ascending = SortDirection(rawValue: "ascending")
  /// The value `descending`.
  public static let descending = SortDirection(rawValue: "descending")

  /// The values that the library knows, from the format table.
  public static let modelled = TableModelFormat.table.values(of: "SortDirection").map(SortDirection.init(rawValue:))
}
