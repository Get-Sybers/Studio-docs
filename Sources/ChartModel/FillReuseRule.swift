public import WireFormat

/// The enumeration `FillReuseRule` of the format.
public struct FillReuseRule: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The value `series_fill_use_series_stroke`.
  public static let seriesFillUseSeriesStroke = FillReuseRule(rawValue: "series_fill_use_series_stroke")
  /// The value `symbol_fill_uses_series_fill`.
  public static let symbolFillUsesSeriesFill = FillReuseRule(rawValue: "symbol_fill_uses_series_fill")
  /// The value `symbol_fill_uses_series_stroke`.
  public static let symbolFillUsesSeriesStroke = FillReuseRule(rawValue: "symbol_fill_uses_series_stroke")

  /// The values that the library knows, from the format table.
  public static let modelled = ChartModelFormat.table.values(of: "FillReuseRule").map(FillReuseRule.init(rawValue:))
}
