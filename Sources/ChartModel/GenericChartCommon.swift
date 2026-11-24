public import CanvasCommon
public import WireFormat

/// The type `chart-common-generic` of the format.
public struct GenericChartCommon: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = ChartModelFormat.table.object(named: "GenericChartCommon")

  /// The `title` member; kept out of line, so the value stays small.
  public var title: Indirect<Label>?
  /// The `caption` member; kept out of line, so the value stays small.
  public var caption: Indirect<Label>?
  /// The `data` member.
  public var data: ChartData?
  /// The `show_legend` member; true when omitted.
  public var showLegend: Bool?
  /// The `legend` member.
  public var legend: ChartLegend?
  /// The `series` member.
  public var series: [ChartSeries]?
  /// The `chart_colors` member.
  public var chartColors: [ChartColor]?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    title: Label? = nil, caption: Label? = nil, data: ChartData? = nil, showLegend: Bool? = nil,
    legend: ChartLegend? = nil, series: [ChartSeries]? = nil, chartColors: [ChartColor]? = nil
  ) {
    self.title = title.map(Indirect.init)
    self.caption = caption.map(Indirect.init)
    self.data = data
    self.showLegend = showLegend
    self.legend = legend
    self.series = series
    self.chartColors = chartColors
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    title = try reader.optional("title")
    caption = try reader.optional("caption")
    data = try reader.optional("data")
    showLegend = try reader.optional("show_legend")
    legend = try reader.optional("legend")
    series = try reader.optional("series")
    chartColors = try reader.optional("chart_colors")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("title", title)
    writer.optional("caption", caption)
    writer.optional("data", data)
    writer.optional("show_legend", showLegend)
    writer.optional("legend", legend)
    writer.optional("series", series)
    writer.optional("chart_colors", chartColors)
  }
}
