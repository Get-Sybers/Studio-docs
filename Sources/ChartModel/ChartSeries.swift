public import Appearance
public import TableModel
public import TextModel
public import WireFormat

/// The type `chart-series` of the format.
public struct ChartSeries: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = ChartModelFormat.table.object(named: "ChartSeries")

  /// The `label_format_type` member.
  public var labelFormatType: CellFormatType?
  /// The `label_date_format` member.
  public var labelDateFormat: DateTimeFormat?
  /// The `label_duration_format` member.
  public var labelDurationFormat: DurationFormat?
  /// The `label_number_format` member.
  public var labelNumberFormat: NumberFormat?
  /// The `label_currency_format` member.
  public var labelCurrencyFormat: CurrencyFormat?
  /// The `series_index` member.
  public var seriesIndex: Int?
  /// The `show_value_labels` member; false when omitted.
  public var showValueLabels: Bool?
  /// The `value_label_position` member.
  public var valueLabelPosition: SeriesValueLabelPosition?
  /// The `value_label_text_style` member; kept out of line, so the value stays small.
  public var valueLabelTextStyle: Indirect<ParagraphProperties>?
  /// The `value_label_outside_text_style` member; kept out of line, so the value stays small.
  public var valueLabelOutsideTextStyle: Indirect<ParagraphProperties>?
  /// The `fill` member; omitted, it is inherited, and `.cleared` writes `null`.
  public var fill: Inheritable<Fill>
  /// The `stroke` member.
  public var stroke: Stroke?
  /// The `symbol_type` member.
  public var symbolType: SeriesSymbolType?
  /// The `symbol_stroke` member.
  public var symbolStroke: Stroke?
  /// The `symbol_fill` member; omitted, it is inherited, and `.cleared` writes `null`.
  public var symbolFill: Inheritable<Fill>
  /// The `symbol_size` member.
  public var symbolSize: Double?
  /// The `fill_reuse_rules` member.
  public var fillReuseRules: [FillReuseRule]?
  /// The `fill_use_series_stroke_alpha_multiplier` member.
  public var fillUseSeriesStrokeAlphaMultiplier: Double?
  /// The `connection_line_type` member.
  public var connectionLineType: ConnectionLineType?
  /// The `value_labels_selection` member.
  public var valueLabelsSelection: ValueLabelsSelection?
  /// The `show_negative_data` member; false when omitted.
  public var showNegativeData: Bool?
  /// The `mixed_series_type` member.
  public var mixedSeriesType: MixedSeriesType?
  /// The `y_axis_selection` member.
  public var yAxisSelection: Int?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    labelFormatType: CellFormatType? = nil, labelDateFormat: DateTimeFormat? = nil,
    labelDurationFormat: DurationFormat? = nil, labelNumberFormat: NumberFormat? = nil,
    labelCurrencyFormat: CurrencyFormat? = nil, seriesIndex: Int? = nil, showValueLabels: Bool? = nil,
    valueLabelPosition: SeriesValueLabelPosition? = nil, valueLabelTextStyle: ParagraphProperties? = nil,
    valueLabelOutsideTextStyle: ParagraphProperties? = nil, fill: Inheritable<Fill> = .inherited, stroke: Stroke? = nil,
    symbolType: SeriesSymbolType? = nil, symbolStroke: Stroke? = nil, symbolFill: Inheritable<Fill> = .inherited,
    symbolSize: Double? = nil, fillReuseRules: [FillReuseRule]? = nil,
    fillUseSeriesStrokeAlphaMultiplier: Double? = nil, connectionLineType: ConnectionLineType? = nil,
    valueLabelsSelection: ValueLabelsSelection? = nil, showNegativeData: Bool? = nil,
    mixedSeriesType: MixedSeriesType? = nil, yAxisSelection: Int? = nil
  ) {
    self.labelFormatType = labelFormatType
    self.labelDateFormat = labelDateFormat
    self.labelDurationFormat = labelDurationFormat
    self.labelNumberFormat = labelNumberFormat
    self.labelCurrencyFormat = labelCurrencyFormat
    self.seriesIndex = seriesIndex
    self.showValueLabels = showValueLabels
    self.valueLabelPosition = valueLabelPosition
    self.valueLabelTextStyle = valueLabelTextStyle.map(Indirect.init)
    self.valueLabelOutsideTextStyle = valueLabelOutsideTextStyle.map(Indirect.init)
    self.fill = fill
    self.stroke = stroke
    self.symbolType = symbolType
    self.symbolStroke = symbolStroke
    self.symbolFill = symbolFill
    self.symbolSize = symbolSize
    self.fillReuseRules = fillReuseRules
    self.fillUseSeriesStrokeAlphaMultiplier = fillUseSeriesStrokeAlphaMultiplier
    self.connectionLineType = connectionLineType
    self.valueLabelsSelection = valueLabelsSelection
    self.showNegativeData = showNegativeData
    self.mixedSeriesType = mixedSeriesType
    self.yAxisSelection = yAxisSelection
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    labelFormatType = try reader.optional("label_format_type")
    labelDateFormat = try reader.optional("label_date_format")
    labelDurationFormat = try reader.optional("label_duration_format")
    labelNumberFormat = try reader.optional("label_number_format")
    labelCurrencyFormat = try reader.optional("label_currency_format")
    seriesIndex = try reader.optional("series_index")
    showValueLabels = try reader.optional("show_value_labels")
    valueLabelPosition = try reader.optional("value_label_position")
    valueLabelTextStyle = try reader.optional("value_label_text_style")
    valueLabelOutsideTextStyle = try reader.optional("value_label_outside_text_style")
    fill = try reader.inheritable("fill")
    stroke = try reader.optional("stroke")
    symbolType = try reader.optional("symbol_type")
    symbolStroke = try reader.optional("symbol_stroke")
    symbolFill = try reader.inheritable("symbol_fill")
    symbolSize = try reader.optional("symbol_size")
    fillReuseRules = try reader.optional("fill_reuse_rules")
    fillUseSeriesStrokeAlphaMultiplier = try reader.optional("fill_use_series_stroke_alpha_multiplier")
    connectionLineType = try reader.optional("connection_line_type")
    valueLabelsSelection = try reader.optional("value_labels_selection")
    showNegativeData = try reader.optional("show_negative_data")
    mixedSeriesType = try reader.optional("mixed_series_type")
    yAxisSelection = try reader.optional("y_axis_selection")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("label_format_type", labelFormatType)
    writer.optional("label_date_format", labelDateFormat)
    writer.optional("label_duration_format", labelDurationFormat)
    writer.optional("label_number_format", labelNumberFormat)
    writer.optional("label_currency_format", labelCurrencyFormat)
    writer.optional("series_index", seriesIndex)
    writer.optional("show_value_labels", showValueLabels)
    writer.optional("value_label_position", valueLabelPosition)
    writer.optional("value_label_text_style", valueLabelTextStyle)
    writer.optional("value_label_outside_text_style", valueLabelOutsideTextStyle)
    writer.inheritable("fill", fill)
    writer.optional("stroke", stroke)
    writer.optional("symbol_type", symbolType)
    writer.optional("symbol_stroke", symbolStroke)
    writer.inheritable("symbol_fill", symbolFill)
    writer.optional("symbol_size", symbolSize)
    writer.optional("fill_reuse_rules", fillReuseRules)
    writer.optional("fill_use_series_stroke_alpha_multiplier", fillUseSeriesStrokeAlphaMultiplier)
    writer.optional("connection_line_type", connectionLineType)
    writer.optional("value_labels_selection", valueLabelsSelection)
    writer.optional("show_negative_data", showNegativeData)
    writer.optional("mixed_series_type", mixedSeriesType)
    writer.optional("y_axis_selection", yAxisSelection)
  }
}
