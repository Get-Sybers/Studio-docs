public import WireFormat

/// The enumeration `DateQualifier` of the format.
public struct DateQualifier: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The value `ago`.
  public static let ago = DateQualifier(rawValue: "ago")
  /// The value `days`.
  public static let days = DateQualifier(rawValue: "days")
  /// The value `from_now`.
  public static let fromNow = DateQualifier(rawValue: "from_now")
  /// The value `months`.
  public static let months = DateQualifier(rawValue: "months")
  /// The value `quarters`.
  public static let quarters = DateQualifier(rawValue: "quarters")
  /// The value `weeks`.
  public static let weeks = DateQualifier(rawValue: "weeks")
  /// The value `years`.
  public static let years = DateQualifier(rawValue: "years")

  /// The values that the library knows, from the format table.
  public static let modelled = TableModelFormat.table.values(of: "DateQualifier").map(DateQualifier.init(rawValue:))
}
