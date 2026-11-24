public import JSONTree
public import WireFormat

/// The union `chart-label-formatting` of the format.
public struct ChartLabelFormatting: WireUnion {
  /// The forms that the library models; each is kept out of line, so the value stays small.
  public indirect enum Form: Sendable, Hashable {
    /// The `chartCategoryAxis` form.
    case chartCategoryAxis(ChartCategoryAxis)
    /// The `chartSeries` form.
    case chartSeries(ChartSeries)
    /// The `chartValueAxis` form.
    case chartValueAxis(ChartValueAxis)
    /// The `genericChartLabelFormatting` form.
    case genericChartLabelFormatting(GenericChartLabelFormatting)
  }

  /// The facts of the type, from the format table.
  public static let schema = ChartModelFormat.table.union(named: "ChartLabelFormatting")

  /// The form the value takes; nil when a preset supplies it or the library does not model it.
  public var form: Form?
  /// The version and preset of the value, and its members beside the form.
  public var envelope: ObjectEnvelope

  /// Creates a value from its parts.
  public init(form: Form?, envelope: ObjectEnvelope = ObjectEnvelope()) {
    self.form = form
    self.envelope = envelope
  }

  /// Makes the `chartCategoryAxis` form.
  public static func chartCategoryAxis(_ value: ChartCategoryAxis) -> ChartLabelFormatting {
    ChartLabelFormatting(.chartCategoryAxis(value))
  }

  /// Makes the `chartSeries` form.
  public static func chartSeries(_ value: ChartSeries) -> ChartLabelFormatting {
    ChartLabelFormatting(.chartSeries(value))
  }

  /// Makes the `chartValueAxis` form.
  public static func chartValueAxis(_ value: ChartValueAxis) -> ChartLabelFormatting {
    ChartLabelFormatting(.chartValueAxis(value))
  }

  /// Makes the `genericChartLabelFormatting` form.
  public static func genericChartLabelFormatting(_ value: GenericChartLabelFormatting) -> ChartLabelFormatting {
    ChartLabelFormatting(.genericChartLabelFormatting(value))
  }

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "chartCategoryAxis": .chartCategoryAxis(try ChartCategoryAxis(wire: contents))
    case "chartSeries": .chartSeries(try ChartSeries(wire: contents))
    case "chartValueAxis": .chartValueAxis(try ChartValueAxis(wire: contents))
    case "genericChartLabelFormatting": .genericChartLabelFormatting(try GenericChartLabelFormatting(wire: contents))
    default: nil
    }
  }

  /// Names the case of a form, with its contents, or nil for a form that has none.
  public static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .chartCategoryAxis(let value): ("chartCategoryAxis", value.wireValue)
    case .chartSeries(let value): ("chartSeries", value.wireValue)
    case .chartValueAxis(let value): ("chartValueAxis", value.wireValue)
    case .genericChartLabelFormatting(let value): ("genericChartLabelFormatting", value.wireValue)
    }
  }
}
