public import WireFormat

/// The enumeration `MixedSeriesType` of the format.
public struct MixedSeriesType: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The value `area`.
  public static let area = MixedSeriesType(rawValue: "area")
  /// The value `column`.
  public static let column = MixedSeriesType(rawValue: "column")
  /// The value `line`.
  public static let line = MixedSeriesType(rawValue: "line")

  /// The values that the library knows, from the format table.
  public static let modelled = ChartModelFormat.table.values(of: "MixedSeriesType").map(MixedSeriesType.init(rawValue:))
}
