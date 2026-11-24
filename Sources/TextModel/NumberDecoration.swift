public import WireFormat

/// What stands around the number of a list item.
public struct NumberDecoration: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// A circle; with Western digits only.
  public static let circled = NumberDecoration(rawValue: "circled")
  /// A full stop after it, the default.
  public static let decimal = NumberDecoration(rawValue: "decimal")
  /// A bracket on each side.
  public static let doubleParen = NumberDecoration(rawValue: "double_paren")
  /// A closing bracket after it.
  public static let paren = NumberDecoration(rawValue: "paren")
  /// Nothing; with Hebrew numerals only.
  public static let standard = NumberDecoration(rawValue: "standard")

  /// The values that the library knows, from the format table.
  public static let modelled = TextFormat.table.values(of: "NumberDecoration").map(NumberDecoration.init(rawValue:))
}
