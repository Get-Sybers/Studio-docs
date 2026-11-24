public import WireFormat

/// The enumeration `TableRowVisibilityState` of the format.
public struct RowVisibility: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The value `filtered`.
  public static let filtered = RowVisibility(rawValue: "filtered")
  /// The value `user_hidden`.
  public static let userHidden = RowVisibility(rawValue: "user_hidden")
  /// The value `visible`.
  public static let visible = RowVisibility(rawValue: "visible")

  /// The values that the library knows, from the format table.
  public static let modelled = TableModelFormat.table.values(of: "RowVisibility").map(RowVisibility.init(rawValue:))
}
