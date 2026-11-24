public import WireFormat

/// The enumeration `CustomFormatType` of the format.
public struct CustomFormatType: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The value `date_time`.
  public static let dateTime = CustomFormatType(rawValue: "date_time")
  /// The value `number`.
  public static let number = CustomFormatType(rawValue: "number")
  /// The value `text`.
  public static let text = CustomFormatType(rawValue: "text")

  /// The values that the library knows, from the format table.
  public static let modelled = TableModelFormat.table.values(of: "CustomFormatType").map(
    CustomFormatType.init(rawValue:))
}
