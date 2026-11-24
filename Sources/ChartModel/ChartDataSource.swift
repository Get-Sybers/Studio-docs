public import WireFormat

/// The enumeration `ChartDataSource` of the format.
public struct ChartDataSource: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The value `chart_data_grid`.
  public static let chartDataGrid = ChartDataSource(rawValue: "chart_data_grid")
  /// The value `table_formula_references`.
  public static let tableFormulaReferences = ChartDataSource(rawValue: "table_formula_references")
  /// The value `uninitialized`.
  public static let uninitialized = ChartDataSource(rawValue: "uninitialized")

  /// The values that the library knows, from the format table.
  public static let modelled = ChartModelFormat.table.values(of: "ChartDataSource").map(ChartDataSource.init(rawValue:))
}
