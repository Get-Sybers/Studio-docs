public import WireFormat

/// The type `chart-data` of the format.
public struct ChartData: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = ChartModelFormat.table.object(named: "ChartData")

  /// The `plot_direction` member.
  public var plotDirection: PlotDirection?
  /// The `shared_xvalues` member; true when omitted.
  public var sharedXvalues: Bool?
  /// The `chart_data_source` member.
  public var chartDataSource: ChartDataSource
  /// The `column_labels` member.
  public var columnLabels: [String]?
  /// The `row_labels` member.
  public var rowLabels: [String]?
  /// The `rows` member.
  public var rows: [ChartDataRow]?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    plotDirection: PlotDirection? = nil, sharedXvalues: Bool? = nil, chartDataSource: ChartDataSource,
    columnLabels: [String]? = nil, rowLabels: [String]? = nil, rows: [ChartDataRow]? = nil
  ) {
    self.plotDirection = plotDirection
    self.sharedXvalues = sharedXvalues
    self.chartDataSource = chartDataSource
    self.columnLabels = columnLabels
    self.rowLabels = rowLabels
    self.rows = rows
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    plotDirection = try reader.optional("plot_direction")
    sharedXvalues = try reader.optional("shared_xvalues")
    chartDataSource = try reader.required("chart_data_source")
    columnLabels = try reader.optional("column_labels")
    rowLabels = try reader.optional("row_labels")
    rows = try reader.optional("rows")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("plot_direction", plotDirection)
    writer.optional("shared_xvalues", sharedXvalues)
    writer.required("chart_data_source", chartDataSource)
    writer.optional("column_labels", columnLabels)
    writer.optional("row_labels", rowLabels)
    writer.optional("rows", rows)
  }
}
