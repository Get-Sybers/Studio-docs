public import WireFormat

/// The enumeration `CombineMode` of the format.
public struct FilterCombination: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The value `and`.
  public static let and = FilterCombination(rawValue: "and")
  /// The value `or`.
  public static let or = FilterCombination(rawValue: "or")

  /// The values that the library knows, from the format table.
  public static let modelled = TableModelFormat.table.values(of: "FilterCombination").map(
    FilterCombination.init(rawValue:))
}
