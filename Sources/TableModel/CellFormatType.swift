public import WireFormat

/// The enumeration `FormatType` of the format.
public struct CellFormatType: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The value `automatic`.
  public static let automatic = CellFormatType(rawValue: "automatic")
  /// The value `base`.
  public static let base = CellFormatType(rawValue: "base")
  /// The value `boolean`.
  public static let boolean = CellFormatType(rawValue: "boolean")
  /// The value `currency`.
  public static let currency = CellFormatType(rawValue: "currency")
  /// The value `custom`.
  public static let custom = CellFormatType(rawValue: "custom")
  /// The value `date_time`.
  public static let dateTime = CellFormatType(rawValue: "date_time")
  /// The value `duration`.
  public static let duration = CellFormatType(rawValue: "duration")
  /// The value `fraction`.
  public static let fraction = CellFormatType(rawValue: "fraction")
  /// The value `number`.
  public static let number = CellFormatType(rawValue: "number")
  /// The value `percentage`.
  public static let percentage = CellFormatType(rawValue: "percentage")
  /// The value `scientific`.
  public static let scientific = CellFormatType(rawValue: "scientific")
  /// The value `text`.
  public static let text = CellFormatType(rawValue: "text")

  /// The values that the library knows, from the format table.
  public static let modelled = TableModelFormat.table.values(of: "CellFormatType").map(CellFormatType.init(rawValue:))
}
