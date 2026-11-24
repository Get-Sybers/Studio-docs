public import WireFormat

/// The enumeration `ConditionType` of the format.
public struct FormatConditionType: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The value `equal`.
  public static let equal = FormatConditionType(rawValue: "equal")
  /// The value `greater_than`.
  public static let greaterThan = FormatConditionType(rawValue: "greater_than")
  /// The value `greater_than_or_equal_to`.
  public static let greaterThanOrEqualTo = FormatConditionType(rawValue: "greater_than_or_equal_to")
  /// The value `less_than`.
  public static let lessThan = FormatConditionType(rawValue: "less_than")
  /// The value `less_than_or_equal_to`.
  public static let lessThanOrEqualTo = FormatConditionType(rawValue: "less_than_or_equal_to")

  /// The values that the library knows, from the format table.
  public static let modelled = TableModelFormat.table.values(of: "FormatConditionType").map(
    FormatConditionType.init(rawValue:))
}
