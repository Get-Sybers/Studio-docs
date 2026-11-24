public import WireFormat

/// The enumeration `Scope` of the format.
public struct SortScope: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The value `entire_table`.
  public static let entireTable = SortScope(rawValue: "entire_table")
  /// The value `selected_rows`.
  public static let selectedRows = SortScope(rawValue: "selected_rows")

  /// The values that the library knows, from the format table.
  public static let modelled = TableModelFormat.table.values(of: "SortScope").map(SortScope.init(rawValue:))
}
