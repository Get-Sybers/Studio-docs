public import WireFormat

/// The enumeration `Unit` of the format.
public struct DurationFormatUnit: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The value `day`.
  public static let day = DurationFormatUnit(rawValue: "day")
  /// The value `hour`.
  public static let hour = DurationFormatUnit(rawValue: "hour")
  /// The value `millisecond`.
  public static let millisecond = DurationFormatUnit(rawValue: "millisecond")
  /// The value `minute`.
  public static let minute = DurationFormatUnit(rawValue: "minute")
  /// The value `none`.
  public static let off = DurationFormatUnit(rawValue: "none")
  /// The value `second`.
  public static let second = DurationFormatUnit(rawValue: "second")
  /// The value `week`.
  public static let week = DurationFormatUnit(rawValue: "week")

  /// The values that the library knows, from the format table.
  public static let modelled = TableModelFormat.table.values(of: "DurationFormatUnit").map(
    DurationFormatUnit.init(rawValue:))
}
