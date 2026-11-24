public import WireFormat

/// The enumeration `Qualifier` of the format.
public struct TextQualifier: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The value `case_insensitive`.
  public static let caseInsensitive = TextQualifier(rawValue: "case_insensitive")
  /// The value `case_sensitive`.
  public static let caseSensitive = TextQualifier(rawValue: "case_sensitive")

  /// The values that the library knows, from the format table.
  public static let modelled = TableModelFormat.table.values(of: "TextQualifier").map(TextQualifier.init(rawValue:))
}
