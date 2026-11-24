public import WireFormat

/// The enumeration `AxisScale` of the format.
public struct AxisScale: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The value `linear`.
  public static let linear = AxisScale(rawValue: "linear")
  /// The value `log`.
  public static let log = AxisScale(rawValue: "log")
  /// The value `percent`.
  public static let percent = AxisScale(rawValue: "percent")

  /// The values that the library knows, from the format table.
  public static let modelled = ChartModelFormat.table.values(of: "AxisScale").map(AxisScale.init(rawValue:))
}
