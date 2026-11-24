public import JSONTree
public import WireFormat

/// The union `chart-common` of the format.
public struct ChartCommon: WireUnion {
  /// The forms that the library models; each is kept out of line, so the value stays small.
  public indirect enum Form: Sendable, Hashable {
    /// The `area3Dchart` form.
    case area3Dchart(Area3DChart)
    /// The `areaChart` form.
    case areaChart(AreaChart)
    /// The `bar3Dchart` form.
    case bar3Dchart(Bar3DChart)
    /// The `barChart` form.
    case barChart(BarChart)
    /// The `barInteractiveChart` form.
    case barInteractiveChart(BarInteractiveChart)
    /// The `bubbleChart` form.
    case bubbleChart(BubbleChart)
    /// The `bubbleInteractiveChart` form.
    case bubbleInteractiveChart(BubbleInteractiveChart)
    /// The `column3Dchart` form.
    case column3Dchart(Column3DChart)
    /// The `columnChart` form.
    case columnChart(ColumnChart)
    /// The `columnInteractiveChart` form.
    case columnInteractiveChart(ColumnInteractiveChart)
    /// The `donutChart` form.
    case donutChart(DonutChart)
    /// The `genericChartCommon` form.
    case genericChartCommon(GenericChartCommon)
    /// The `line3Dchart` form.
    case line3Dchart(Line3DChart)
    /// The `lineChart` form.
    case lineChart(LineChart)
    /// The `mixedChart` form.
    case mixedChart(MixedChart)
    /// The `pie3Dchart` form.
    case pie3Dchart(Pie3DChart)
    /// The `pieChart` form.
    case pieChart(PieChart)
    /// The `radarChart` form.
    case radarChart(RadarChart)
    /// The `scatterChart` form.
    case scatterChart(ScatterChart)
    /// The `scatterInteractiveChart` form.
    case scatterInteractiveChart(ScatterInteractiveChart)
    /// The `stackedArea3Dchart` form.
    case stackedArea3Dchart(StackedArea3DChart)
    /// The `stackedAreaChart` form.
    case stackedAreaChart(StackedAreaChart)
    /// The `stackedBar3Dchart` form.
    case stackedBar3Dchart(StackedBar3DChart)
    /// The `stackedBarChart` form.
    case stackedBarChart(StackedBarChart)
    /// The `stackedColumn3Dchart` form.
    case stackedColumn3Dchart(StackedColumn3DChart)
    /// The `stackedColumnChart` form.
    case stackedColumnChart(StackedColumnChart)
    /// The `twoAxisChart` form.
    case twoAxisChart(TwoAxisChart)
  }

  /// The facts of the type, from the format table.
  public static let schema = ChartModelFormat.table.union(named: "ChartCommon")

  /// The form the value takes; nil when a preset supplies it or the library does not model it.
  public var form: Form?
  /// The version and preset of the value, and its members beside the form.
  public var envelope: ObjectEnvelope

  /// Creates a value from its parts.
  public init(form: Form?, envelope: ObjectEnvelope = ObjectEnvelope()) {
    self.form = form
    self.envelope = envelope
  }

  /// Makes the `area3Dchart` form.
  public static func area3Dchart(_ value: Area3DChart) -> ChartCommon {
    ChartCommon(.area3Dchart(value))
  }

  /// Makes the `areaChart` form.
  public static func areaChart(_ value: AreaChart) -> ChartCommon {
    ChartCommon(.areaChart(value))
  }

  /// Makes the `bar3Dchart` form.
  public static func bar3Dchart(_ value: Bar3DChart) -> ChartCommon {
    ChartCommon(.bar3Dchart(value))
  }

  /// Makes the `barChart` form.
  public static func barChart(_ value: BarChart) -> ChartCommon {
    ChartCommon(.barChart(value))
  }

  /// Makes the `barInteractiveChart` form.
  public static func barInteractiveChart(_ value: BarInteractiveChart) -> ChartCommon {
    ChartCommon(.barInteractiveChart(value))
  }

  /// Makes the `bubbleChart` form.
  public static func bubbleChart(_ value: BubbleChart) -> ChartCommon {
    ChartCommon(.bubbleChart(value))
  }

  /// Makes the `bubbleInteractiveChart` form.
  public static func bubbleInteractiveChart(_ value: BubbleInteractiveChart) -> ChartCommon {
    ChartCommon(.bubbleInteractiveChart(value))
  }

  /// Makes the `column3Dchart` form.
  public static func column3Dchart(_ value: Column3DChart) -> ChartCommon {
    ChartCommon(.column3Dchart(value))
  }

  /// Makes the `columnChart` form.
  public static func columnChart(_ value: ColumnChart) -> ChartCommon {
    ChartCommon(.columnChart(value))
  }

  /// Makes the `columnInteractiveChart` form.
  public static func columnInteractiveChart(_ value: ColumnInteractiveChart) -> ChartCommon {
    ChartCommon(.columnInteractiveChart(value))
  }

  /// Makes the `donutChart` form.
  public static func donutChart(_ value: DonutChart) -> ChartCommon {
    ChartCommon(.donutChart(value))
  }

  /// Makes the `genericChartCommon` form.
  public static func genericChartCommon(_ value: GenericChartCommon) -> ChartCommon {
    ChartCommon(.genericChartCommon(value))
  }

  /// Makes the `line3Dchart` form.
  public static func line3Dchart(_ value: Line3DChart) -> ChartCommon {
    ChartCommon(.line3Dchart(value))
  }

  /// Makes the `lineChart` form.
  public static func lineChart(_ value: LineChart) -> ChartCommon {
    ChartCommon(.lineChart(value))
  }

  /// Makes the `mixedChart` form.
  public static func mixedChart(_ value: MixedChart) -> ChartCommon {
    ChartCommon(.mixedChart(value))
  }

  /// Makes the `pie3Dchart` form.
  public static func pie3Dchart(_ value: Pie3DChart) -> ChartCommon {
    ChartCommon(.pie3Dchart(value))
  }

  /// Makes the `pieChart` form.
  public static func pieChart(_ value: PieChart) -> ChartCommon {
    ChartCommon(.pieChart(value))
  }

  /// Makes the `radarChart` form.
  public static func radarChart(_ value: RadarChart) -> ChartCommon {
    ChartCommon(.radarChart(value))
  }

  /// Makes the `scatterChart` form.
  public static func scatterChart(_ value: ScatterChart) -> ChartCommon {
    ChartCommon(.scatterChart(value))
  }

  /// Makes the `scatterInteractiveChart` form.
  public static func scatterInteractiveChart(_ value: ScatterInteractiveChart) -> ChartCommon {
    ChartCommon(.scatterInteractiveChart(value))
  }

  /// Makes the `stackedArea3Dchart` form.
  public static func stackedArea3Dchart(_ value: StackedArea3DChart) -> ChartCommon {
    ChartCommon(.stackedArea3Dchart(value))
  }

  /// Makes the `stackedAreaChart` form.
  public static func stackedAreaChart(_ value: StackedAreaChart) -> ChartCommon {
    ChartCommon(.stackedAreaChart(value))
  }

  /// Makes the `stackedBar3Dchart` form.
  public static func stackedBar3Dchart(_ value: StackedBar3DChart) -> ChartCommon {
    ChartCommon(.stackedBar3Dchart(value))
  }

  /// Makes the `stackedBarChart` form.
  public static func stackedBarChart(_ value: StackedBarChart) -> ChartCommon {
    ChartCommon(.stackedBarChart(value))
  }

  /// Makes the `stackedColumn3Dchart` form.
  public static func stackedColumn3Dchart(_ value: StackedColumn3DChart) -> ChartCommon {
    ChartCommon(.stackedColumn3Dchart(value))
  }

  /// Makes the `stackedColumnChart` form.
  public static func stackedColumnChart(_ value: StackedColumnChart) -> ChartCommon {
    ChartCommon(.stackedColumnChart(value))
  }

  /// Makes the `twoAxisChart` form.
  public static func twoAxisChart(_ value: TwoAxisChart) -> ChartCommon {
    ChartCommon(.twoAxisChart(value))
  }

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "area3Dchart": .area3Dchart(try Area3DChart(wire: contents))
    case "areaChart": .areaChart(try AreaChart(wire: contents))
    case "bar3Dchart": .bar3Dchart(try Bar3DChart(wire: contents))
    case "barChart": .barChart(try BarChart(wire: contents))
    case "barInteractiveChart": .barInteractiveChart(try BarInteractiveChart(wire: contents))
    case "bubbleChart": .bubbleChart(try BubbleChart(wire: contents))
    case "bubbleInteractiveChart": .bubbleInteractiveChart(try BubbleInteractiveChart(wire: contents))
    case "column3Dchart": .column3Dchart(try Column3DChart(wire: contents))
    case "columnChart": .columnChart(try ColumnChart(wire: contents))
    case "columnInteractiveChart": .columnInteractiveChart(try ColumnInteractiveChart(wire: contents))
    case "donutChart": .donutChart(try DonutChart(wire: contents))
    case "genericChartCommon": .genericChartCommon(try GenericChartCommon(wire: contents))
    case "line3Dchart": .line3Dchart(try Line3DChart(wire: contents))
    case "lineChart": .lineChart(try LineChart(wire: contents))
    case "mixedChart": .mixedChart(try MixedChart(wire: contents))
    case "pie3Dchart": .pie3Dchart(try Pie3DChart(wire: contents))
    case "pieChart": .pieChart(try PieChart(wire: contents))
    case "radarChart": .radarChart(try RadarChart(wire: contents))
    case "scatterChart": .scatterChart(try ScatterChart(wire: contents))
    case "scatterInteractiveChart": .scatterInteractiveChart(try ScatterInteractiveChart(wire: contents))
    case "stackedArea3Dchart": .stackedArea3Dchart(try StackedArea3DChart(wire: contents))
    case "stackedAreaChart": .stackedAreaChart(try StackedAreaChart(wire: contents))
    case "stackedBar3Dchart": .stackedBar3Dchart(try StackedBar3DChart(wire: contents))
    case "stackedBarChart": .stackedBarChart(try StackedBarChart(wire: contents))
    case "stackedColumn3Dchart": .stackedColumn3Dchart(try StackedColumn3DChart(wire: contents))
    case "stackedColumnChart": .stackedColumnChart(try StackedColumnChart(wire: contents))
    case "twoAxisChart": .twoAxisChart(try TwoAxisChart(wire: contents))
    default: nil
    }
  }

  /// Names the case of a form, with its contents, or nil for a form that has none.
  public static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .area3Dchart(let value): ("area3Dchart", value.wireValue)
    case .areaChart(let value): ("areaChart", value.wireValue)
    case .bar3Dchart(let value): ("bar3Dchart", value.wireValue)
    case .barChart(let value): ("barChart", value.wireValue)
    case .barInteractiveChart(let value): ("barInteractiveChart", value.wireValue)
    case .bubbleChart(let value): ("bubbleChart", value.wireValue)
    case .bubbleInteractiveChart(let value): ("bubbleInteractiveChart", value.wireValue)
    case .column3Dchart(let value): ("column3Dchart", value.wireValue)
    case .columnChart(let value): ("columnChart", value.wireValue)
    case .columnInteractiveChart(let value): ("columnInteractiveChart", value.wireValue)
    case .donutChart(let value): ("donutChart", value.wireValue)
    case .genericChartCommon(let value): ("genericChartCommon", value.wireValue)
    case .line3Dchart(let value): ("line3Dchart", value.wireValue)
    case .lineChart(let value): ("lineChart", value.wireValue)
    case .mixedChart(let value): ("mixedChart", value.wireValue)
    case .pie3Dchart(let value): ("pie3Dchart", value.wireValue)
    case .pieChart(let value): ("pieChart", value.wireValue)
    case .radarChart(let value): ("radarChart", value.wireValue)
    case .scatterChart(let value): ("scatterChart", value.wireValue)
    case .scatterInteractiveChart(let value): ("scatterInteractiveChart", value.wireValue)
    case .stackedArea3Dchart(let value): ("stackedArea3Dchart", value.wireValue)
    case .stackedAreaChart(let value): ("stackedAreaChart", value.wireValue)
    case .stackedBar3Dchart(let value): ("stackedBar3Dchart", value.wireValue)
    case .stackedBarChart(let value): ("stackedBarChart", value.wireValue)
    case .stackedColumn3Dchart(let value): ("stackedColumn3Dchart", value.wireValue)
    case .stackedColumnChart(let value): ("stackedColumnChart", value.wireValue)
    case .twoAxisChart(let value): ("twoAxisChart", value.wireValue)
    }
  }
}
