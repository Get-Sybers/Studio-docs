public import CanvasCommon
public import WireFormat

/// The type `donut-chart` of the format.
public struct DonutChart: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = ChartModelFormat.table.object(named: "DonutChart")

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
  /// The `geometry` member.
  public var geometry: Geometry?
  /// The `aspect_ratio_locked` member; false when omitted.
  public var aspectRatioLocked: Bool?
  /// The `description` member.
  public var description: String?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    title: Label? = nil, caption: Label? = nil, data: ChartData? = nil, showLegend: Bool? = nil,
    legend: ChartLegend? = nil, series: [ChartSeries]? = nil, chartColors: [ChartColor]? = nil,
    geometry: Geometry? = nil, aspectRatioLocked: Bool? = nil, description: String? = nil
  ) {
    self.title = title.map(Indirect.init)
    self.caption = caption.map(Indirect.init)
    self.data = data
    self.showLegend = showLegend
    self.legend = legend
    self.series = series
    self.chartColors = chartColors
    self.geometry = geometry
    self.aspectRatioLocked = aspectRatioLocked
    self.description = description
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
    geometry = try reader.optional("geometry")
    aspectRatioLocked = try reader.optional("aspect_ratio_locked")
    description = try reader.optional("description")
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
    writer.optional("geometry", geometry)
    writer.optional("aspect_ratio_locked", aspectRatioLocked)
    writer.optional("description", description)
  }
}
