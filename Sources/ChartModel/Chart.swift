public import JSONTree
public import WireFormat

/// The union `chart` of the format.
public struct Chart: WireUnion {
  /// The forms that the library models; each is kept out of line, so the value stays small.
  public indirect enum Form: Sendable, Hashable {
    /// The `area` form.
    case area(AreaChart)
    /// The `area_3d` form.
    case area3d(Area3DChart)
    /// The `bar` form.
    case bar(BarChart)
    /// The `bar_3d` form.
    case bar3d(Bar3DChart)
    /// The `bar_interactive` form.
    case barInteractive(BarInteractiveChart)
    /// The `bubble` form.
    case bubble(BubbleChart)
    /// The `bubble_interactive` form.
    case bubbleInteractive(BubbleInteractiveChart)
    /// The `column` form.
    case column(ColumnChart)
    /// The `column_3d` form.
    case column3d(Column3DChart)
    /// The `column_interactive` form.
    case columnInteractive(ColumnInteractiveChart)
    /// The `donut` form.
    case donut(DonutChart)
    /// The `line` form.
    case line(LineChart)
    /// The `line_3d` form.
    case line3d(Line3DChart)
    /// The `mixed` form.
    case mixed(MixedChart)
    /// The `pie` form.
    case pie(PieChart)
    /// The `pie_3d` form.
    case pie3d(Pie3DChart)
    /// The `radar` form.
    case radar(RadarChart)
    /// The `scatter` form.
    case scatter(ScatterChart)
    /// The `scatter_interactive` form.
    case scatterInteractive(ScatterInteractiveChart)
    /// The `stacked_area` form.
    case stackedArea(StackedAreaChart)
    /// The `stacked_area_3d` form.
    case stackedArea3d(StackedArea3DChart)
    /// The `stacked_bar` form.
    case stackedBar(StackedBarChart)
    /// The `stacked_bar_3d` form.
    case stackedBar3d(StackedBar3DChart)
    /// The `stacked_column` form.
    case stackedColumn(StackedColumnChart)
    /// The `stacked_column_3d` form.
    case stackedColumn3d(StackedColumn3DChart)
    /// The `two_axis` form.
    case twoAxis(TwoAxisChart)
  }

  /// The facts of the type, from the format table.
  public static let schema = ChartModelFormat.table.union(named: "Chart")

  /// The form the value takes; nil when a preset supplies it or the library does not model it.
  public var form: Form?
  /// The version and preset of the value, and its members beside the form.
  public var envelope: ObjectEnvelope

  /// Creates a value from its parts.
  public init(form: Form?, envelope: ObjectEnvelope = ObjectEnvelope()) {
    self.form = form
    self.envelope = envelope
  }

  /// Makes the `area` form.
  public static func area(_ value: AreaChart) -> Chart {
    Chart(.area(value))
  }

  /// Makes the `area_3d` form.
  public static func area3d(_ value: Area3DChart) -> Chart {
    Chart(.area3d(value))
  }

  /// Makes the `bar` form.
  public static func bar(_ value: BarChart) -> Chart {
    Chart(.bar(value))
  }

  /// Makes the `bar_3d` form.
  public static func bar3d(_ value: Bar3DChart) -> Chart {
    Chart(.bar3d(value))
  }

  /// Makes the `bar_interactive` form.
  public static func barInteractive(_ value: BarInteractiveChart) -> Chart {
    Chart(.barInteractive(value))
  }

  /// Makes the `bubble` form.
  public static func bubble(_ value: BubbleChart) -> Chart {
    Chart(.bubble(value))
  }

  /// Makes the `bubble_interactive` form.
  public static func bubbleInteractive(_ value: BubbleInteractiveChart) -> Chart {
    Chart(.bubbleInteractive(value))
  }

  /// Makes the `column` form.
  public static func column(_ value: ColumnChart) -> Chart {
    Chart(.column(value))
  }

  /// Makes the `column_3d` form.
  public static func column3d(_ value: Column3DChart) -> Chart {
    Chart(.column3d(value))
  }

  /// Makes the `column_interactive` form.
  public static func columnInteractive(_ value: ColumnInteractiveChart) -> Chart {
    Chart(.columnInteractive(value))
  }

  /// Makes the `donut` form.
  public static func donut(_ value: DonutChart) -> Chart {
    Chart(.donut(value))
  }

  /// Makes the `line` form.
  public static func line(_ value: LineChart) -> Chart {
    Chart(.line(value))
  }

  /// Makes the `line_3d` form.
  public static func line3d(_ value: Line3DChart) -> Chart {
    Chart(.line3d(value))
  }

  /// Makes the `mixed` form.
  public static func mixed(_ value: MixedChart) -> Chart {
    Chart(.mixed(value))
  }

  /// Makes the `pie` form.
  public static func pie(_ value: PieChart) -> Chart {
    Chart(.pie(value))
  }

  /// Makes the `pie_3d` form.
  public static func pie3d(_ value: Pie3DChart) -> Chart {
    Chart(.pie3d(value))
  }

  /// Makes the `radar` form.
  public static func radar(_ value: RadarChart) -> Chart {
    Chart(.radar(value))
  }

  /// Makes the `scatter` form.
  public static func scatter(_ value: ScatterChart) -> Chart {
    Chart(.scatter(value))
  }

  /// Makes the `scatter_interactive` form.
  public static func scatterInteractive(_ value: ScatterInteractiveChart) -> Chart {
    Chart(.scatterInteractive(value))
  }

  /// Makes the `stacked_area` form.
  public static func stackedArea(_ value: StackedAreaChart) -> Chart {
    Chart(.stackedArea(value))
  }

  /// Makes the `stacked_area_3d` form.
  public static func stackedArea3d(_ value: StackedArea3DChart) -> Chart {
    Chart(.stackedArea3d(value))
  }

  /// Makes the `stacked_bar` form.
  public static func stackedBar(_ value: StackedBarChart) -> Chart {
    Chart(.stackedBar(value))
  }

  /// Makes the `stacked_bar_3d` form.
  public static func stackedBar3d(_ value: StackedBar3DChart) -> Chart {
    Chart(.stackedBar3d(value))
  }

  /// Makes the `stacked_column` form.
  public static func stackedColumn(_ value: StackedColumnChart) -> Chart {
    Chart(.stackedColumn(value))
  }

  /// Makes the `stacked_column_3d` form.
  public static func stackedColumn3d(_ value: StackedColumn3DChart) -> Chart {
    Chart(.stackedColumn3d(value))
  }

  /// Makes the `two_axis` form.
  public static func twoAxis(_ value: TwoAxisChart) -> Chart {
    Chart(.twoAxis(value))
  }

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "area": .area(try AreaChart(wire: contents))
    case "area_3d": .area3d(try Area3DChart(wire: contents))
    case "bar": .bar(try BarChart(wire: contents))
    case "bar_3d": .bar3d(try Bar3DChart(wire: contents))
    case "bar_interactive": .barInteractive(try BarInteractiveChart(wire: contents))
    case "bubble": .bubble(try BubbleChart(wire: contents))
    case "bubble_interactive": .bubbleInteractive(try BubbleInteractiveChart(wire: contents))
    case "column": .column(try ColumnChart(wire: contents))
    case "column_3d": .column3d(try Column3DChart(wire: contents))
    case "column_interactive": .columnInteractive(try ColumnInteractiveChart(wire: contents))
    case "donut": .donut(try DonutChart(wire: contents))
    case "line": .line(try LineChart(wire: contents))
    case "line_3d": .line3d(try Line3DChart(wire: contents))
    case "mixed": .mixed(try MixedChart(wire: contents))
    case "pie": .pie(try PieChart(wire: contents))
    case "pie_3d": .pie3d(try Pie3DChart(wire: contents))
    case "radar": .radar(try RadarChart(wire: contents))
    case "scatter": .scatter(try ScatterChart(wire: contents))
    case "scatter_interactive": .scatterInteractive(try ScatterInteractiveChart(wire: contents))
    case "stacked_area": .stackedArea(try StackedAreaChart(wire: contents))
    case "stacked_area_3d": .stackedArea3d(try StackedArea3DChart(wire: contents))
    case "stacked_bar": .stackedBar(try StackedBarChart(wire: contents))
    case "stacked_bar_3d": .stackedBar3d(try StackedBar3DChart(wire: contents))
    case "stacked_column": .stackedColumn(try StackedColumnChart(wire: contents))
    case "stacked_column_3d": .stackedColumn3d(try StackedColumn3DChart(wire: contents))
    case "two_axis": .twoAxis(try TwoAxisChart(wire: contents))
    default: nil
    }
  }

  /// Names the case of a form, with its contents, or nil for a form that has none.
  public static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .area(let value): ("area", value.wireValue)
    case .area3d(let value): ("area_3d", value.wireValue)
    case .bar(let value): ("bar", value.wireValue)
    case .bar3d(let value): ("bar_3d", value.wireValue)
    case .barInteractive(let value): ("bar_interactive", value.wireValue)
    case .bubble(let value): ("bubble", value.wireValue)
    case .bubbleInteractive(let value): ("bubble_interactive", value.wireValue)
    case .column(let value): ("column", value.wireValue)
    case .column3d(let value): ("column_3d", value.wireValue)
    case .columnInteractive(let value): ("column_interactive", value.wireValue)
    case .donut(let value): ("donut", value.wireValue)
    case .line(let value): ("line", value.wireValue)
    case .line3d(let value): ("line_3d", value.wireValue)
    case .mixed(let value): ("mixed", value.wireValue)
    case .pie(let value): ("pie", value.wireValue)
    case .pie3d(let value): ("pie_3d", value.wireValue)
    case .radar(let value): ("radar", value.wireValue)
    case .scatter(let value): ("scatter", value.wireValue)
    case .scatterInteractive(let value): ("scatter_interactive", value.wireValue)
    case .stackedArea(let value): ("stacked_area", value.wireValue)
    case .stackedArea3d(let value): ("stacked_area_3d", value.wireValue)
    case .stackedBar(let value): ("stacked_bar", value.wireValue)
    case .stackedBar3d(let value): ("stacked_bar_3d", value.wireValue)
    case .stackedColumn(let value): ("stacked_column", value.wireValue)
    case .stackedColumn3d(let value): ("stacked_column_3d", value.wireValue)
    case .twoAxis(let value): ("two_axis", value.wireValue)
    }
  }
}
