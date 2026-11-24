public import WireFormat

/// The enumeration `TableColumnHeaderVisibilityState` of the format.
public struct ColumnVisibility: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The value `user_hidden`.
  public static let userHidden = ColumnVisibility(rawValue: "user_hidden")
  /// The value `visible`.
  public static let visible = ColumnVisibility(rawValue: "visible")

  /// The values that the library knows, from the format table.
  public static let modelled = TableModelFormat.table.values(of: "ColumnVisibility").map(
    ColumnVisibility.init(rawValue:))
}
