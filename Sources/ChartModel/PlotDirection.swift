public import WireFormat

/// The enumeration `PlotDirection` of the format.
public struct PlotDirection: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The value `columns_as_series`.
  public static let columnsAsSeries = PlotDirection(rawValue: "columns_as_series")
  /// The value `rows_as_series`.
  public static let rowsAsSeries = PlotDirection(rawValue: "rows_as_series")

  /// The values that the library knows, from the format table.
  public static let modelled = ChartModelFormat.table.values(of: "PlotDirection").map(PlotDirection.init(rawValue:))
}
