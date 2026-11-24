public import JSONTree
public import WireFormat

/// The union `category-comparison-chart` of the format.
public struct CategoryComparisonChart: WireUnion {
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
    /// The `column3Dchart` form.
    case column3Dchart(Column3DChart)
    /// The `columnChart` form.
    case columnChart(ColumnChart)
    /// The `columnInteractiveChart` form.
    case columnInteractiveChart(ColumnInteractiveChart)
    /// The `genericCategoryComparisonChart` form.
    case genericCategoryComparisonChart(GenericCategoryComparisonChart)
    /// The `line3Dchart` form.
    case line3Dchart(Line3DChart)
    /// The `lineChart` form.
    case lineChart(LineChart)
    /// The `mixedChart` form.
    case mixedChart(MixedChart)
    /// The `radarChart` form.
    case radarChart(RadarChart)
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
  public static let schema = ChartModelFormat.table.union(named: "CategoryComparisonChart")

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
  public static func area3Dchart(_ value: Area3DChart) -> CategoryComparisonChart {
    CategoryComparisonChart(.area3Dchart(value))
  }

  /// Makes the `areaChart` form.
  public static func areaChart(_ value: AreaChart) -> CategoryComparisonChart {
    CategoryComparisonChart(.areaChart(value))
  }

  /// Makes the `bar3Dchart` form.
  public static func bar3Dchart(_ value: Bar3DChart) -> CategoryComparisonChart {
    CategoryComparisonChart(.bar3Dchart(value))
  }

  /// Makes the `barChart` form.
  public static func barChart(_ value: BarChart) -> CategoryComparisonChart {
    CategoryComparisonChart(.barChart(value))
  }

  /// Makes the `barInteractiveChart` form.
  public static func barInteractiveChart(_ value: BarInteractiveChart) -> CategoryComparisonChart {
    CategoryComparisonChart(.barInteractiveChart(value))
  }

  /// Makes the `column3Dchart` form.
  public static func column3Dchart(_ value: Column3DChart) -> CategoryComparisonChart {
    CategoryComparisonChart(.column3Dchart(value))
  }

  /// Makes the `columnChart` form.
  public static func columnChart(_ value: ColumnChart) -> CategoryComparisonChart {
    CategoryComparisonChart(.columnChart(value))
  }

  /// Makes the `columnInteractiveChart` form.
  public static func columnInteractiveChart(_ value: ColumnInteractiveChart) -> CategoryComparisonChart {
    CategoryComparisonChart(.columnInteractiveChart(value))
  }

  /// Makes the `genericCategoryComparisonChart` form.
  public static func genericCategoryComparisonChart(_ value: GenericCategoryComparisonChart) -> CategoryComparisonChart
  {
    CategoryComparisonChart(.genericCategoryComparisonChart(value))
  }

  /// Makes the `line3Dchart` form.
  public static func line3Dchart(_ value: Line3DChart) -> CategoryComparisonChart {
    CategoryComparisonChart(.line3Dchart(value))
  }

  /// Makes the `lineChart` form.
  public static func lineChart(_ value: LineChart) -> CategoryComparisonChart {
    CategoryComparisonChart(.lineChart(value))
  }

  /// Makes the `mixedChart` form.
  public static func mixedChart(_ value: MixedChart) -> CategoryComparisonChart {
    CategoryComparisonChart(.mixedChart(value))
  }

  /// Makes the `radarChart` form.
  public static func radarChart(_ value: RadarChart) -> CategoryComparisonChart {
    CategoryComparisonChart(.radarChart(value))
  }

  /// Makes the `stackedArea3Dchart` form.
  public static func stackedArea3Dchart(_ value: StackedArea3DChart) -> CategoryComparisonChart {
    CategoryComparisonChart(.stackedArea3Dchart(value))
  }

  /// Makes the `stackedAreaChart` form.
  public static func stackedAreaChart(_ value: StackedAreaChart) -> CategoryComparisonChart {
    CategoryComparisonChart(.stackedAreaChart(value))
  }

  /// Makes the `stackedBar3Dchart` form.
  public static func stackedBar3Dchart(_ value: StackedBar3DChart) -> CategoryComparisonChart {
    CategoryComparisonChart(.stackedBar3Dchart(value))
  }

  /// Makes the `stackedBarChart` form.
  public static func stackedBarChart(_ value: StackedBarChart) -> CategoryComparisonChart {
    CategoryComparisonChart(.stackedBarChart(value))
  }

  /// Makes the `stackedColumn3Dchart` form.
  public static func stackedColumn3Dchart(_ value: StackedColumn3DChart) -> CategoryComparisonChart {
    CategoryComparisonChart(.stackedColumn3Dchart(value))
  }

  /// Makes the `stackedColumnChart` form.
  public static func stackedColumnChart(_ value: StackedColumnChart) -> CategoryComparisonChart {
    CategoryComparisonChart(.stackedColumnChart(value))
  }

  /// Makes the `twoAxisChart` form.
  public static func twoAxisChart(_ value: TwoAxisChart) -> CategoryComparisonChart {
    CategoryComparisonChart(.twoAxisChart(value))
  }

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "area3Dchart": .area3Dchart(try Area3DChart(wire: contents))
    case "areaChart": .areaChart(try AreaChart(wire: contents))
    case "bar3Dchart": .bar3Dchart(try Bar3DChart(wire: contents))
    case "barChart": .barChart(try BarChart(wire: contents))
    case "barInteractiveChart": .barInteractiveChart(try BarInteractiveChart(wire: contents))
    case "column3Dchart": .column3Dchart(try Column3DChart(wire: contents))
    case "columnChart": .columnChart(try ColumnChart(wire: contents))
    case "columnInteractiveChart": .columnInteractiveChart(try ColumnInteractiveChart(wire: contents))
    case "genericCategoryComparisonChart":
      .genericCategoryComparisonChart(try GenericCategoryComparisonChart(wire: contents))
    case "line3Dchart": .line3Dchart(try Line3DChart(wire: contents))
    case "lineChart": .lineChart(try LineChart(wire: contents))
    case "mixedChart": .mixedChart(try MixedChart(wire: contents))
    case "radarChart": .radarChart(try RadarChart(wire: contents))
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
    case .column3Dchart(let value): ("column3Dchart", value.wireValue)
    case .columnChart(let value): ("columnChart", value.wireValue)
    case .columnInteractiveChart(let value): ("columnInteractiveChart", value.wireValue)
    case .genericCategoryComparisonChart(let value): ("genericCategoryComparisonChart", value.wireValue)
    case .line3Dchart(let value): ("line3Dchart", value.wireValue)
    case .lineChart(let value): ("lineChart", value.wireValue)
    case .mixedChart(let value): ("mixedChart", value.wireValue)
    case .radarChart(let value): ("radarChart", value.wireValue)
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
