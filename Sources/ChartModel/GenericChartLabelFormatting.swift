public import TableModel
public import WireFormat

/// The type `chart-label-formatting-generic` of the format.
public struct GenericChartLabelFormatting: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = ChartModelFormat.table.object(named: "GenericChartLabelFormatting")

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
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    labelFormatType: CellFormatType? = nil, labelDateFormat: DateTimeFormat? = nil,
    labelDurationFormat: DurationFormat? = nil, labelNumberFormat: NumberFormat? = nil,
    labelCurrencyFormat: CurrencyFormat? = nil
  ) {
    self.labelFormatType = labelFormatType
    self.labelDateFormat = labelDateFormat
    self.labelDurationFormat = labelDurationFormat
    self.labelNumberFormat = labelNumberFormat
    self.labelCurrencyFormat = labelCurrencyFormat
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    labelFormatType = try reader.optional("label_format_type")
    labelDateFormat = try reader.optional("label_date_format")
    labelDurationFormat = try reader.optional("label_duration_format")
    labelNumberFormat = try reader.optional("label_number_format")
    labelCurrencyFormat = try reader.optional("label_currency_format")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("label_format_type", labelFormatType)
    writer.optional("label_date_format", labelDateFormat)
    writer.optional("label_duration_format", labelDurationFormat)
    writer.optional("label_number_format", labelNumberFormat)
    writer.optional("label_currency_format", labelCurrencyFormat)
  }
}
