public import WireFormat

/// The enumeration `NegativeNumberStyle` of the format.
public struct NegativeNumberStyle: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The value `minus`.
  public static let minus = NegativeNumberStyle(rawValue: "minus")
  /// The value `none`.
  public static let off = NegativeNumberStyle(rawValue: "none")
  /// The value `parentheses`.
  public static let parentheses = NegativeNumberStyle(rawValue: "parentheses")
  /// The value `red`.
  public static let red = NegativeNumberStyle(rawValue: "red")
  /// The value `red_and_parentheses`.
  public static let redAndParentheses = NegativeNumberStyle(rawValue: "red_and_parentheses")

  /// The values that the library knows, from the format table.
  public static let modelled = TableModelFormat.table.values(of: "NegativeNumberStyle").map(
    NegativeNumberStyle.init(rawValue:))
}
