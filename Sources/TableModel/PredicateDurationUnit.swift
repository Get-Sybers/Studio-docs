public import WireFormat

/// The enumeration `DurationUnit` of the format.
public struct PredicateDurationUnit: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The value `day`.
  public static let day = PredicateDurationUnit(rawValue: "day")
  /// The value `hour`.
  public static let hour = PredicateDurationUnit(rawValue: "hour")
  /// The value `millisecond`.
  public static let millisecond = PredicateDurationUnit(rawValue: "millisecond")
  /// The value `minute`.
  public static let minute = PredicateDurationUnit(rawValue: "minute")
  /// The value `second`.
  public static let second = PredicateDurationUnit(rawValue: "second")
  /// The value `week`.
  public static let week = PredicateDurationUnit(rawValue: "week")

  /// The values that the library knows, from the format table.
  public static let modelled = TableModelFormat.table.values(of: "PredicateDurationUnit").map(
    PredicateDurationUnit.init(rawValue:))
}
