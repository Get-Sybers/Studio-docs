public import WireFormat

/// The type `table.cell-format` of the format.
public struct CellFormat: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "CellFormat")

  /// The `format_type` member.
  public var formatType: CellFormatType?
  /// The `number_format` member.
  public var numberFormat: NumberFormat?
  /// The `currency_format` member.
  public var currencyFormat: CurrencyFormat?
  /// The `fraction_format` member.
  public var fractionFormat: FractionFormat?
  /// The `base_format` member.
  public var baseFormat: BaseFormat?
  /// The `bool_format` member.
  public var boolFormat: BoolFormat?
  /// The `duration_format` member.
  public var durationFormat: DurationFormat?
  /// The `date_time_format` member.
  public var dateTimeFormat: DateTimeFormat?
  /// The `custom_format_identifier` member.
  public var customFormatIdentifier: String?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    formatType: CellFormatType? = nil, numberFormat: NumberFormat? = nil, currencyFormat: CurrencyFormat? = nil,
    fractionFormat: FractionFormat? = nil, baseFormat: BaseFormat? = nil, boolFormat: BoolFormat? = nil,
    durationFormat: DurationFormat? = nil, dateTimeFormat: DateTimeFormat? = nil, customFormatIdentifier: String? = nil
  ) {
    self.formatType = formatType
    self.numberFormat = numberFormat
    self.currencyFormat = currencyFormat
    self.fractionFormat = fractionFormat
    self.baseFormat = baseFormat
    self.boolFormat = boolFormat
    self.durationFormat = durationFormat
    self.dateTimeFormat = dateTimeFormat
    self.customFormatIdentifier = customFormatIdentifier
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    formatType = try reader.optional("format_type")
    numberFormat = try reader.optional("number_format")
    currencyFormat = try reader.optional("currency_format")
    fractionFormat = try reader.optional("fraction_format")
    baseFormat = try reader.optional("base_format")
    boolFormat = try reader.optional("bool_format")
    durationFormat = try reader.optional("duration_format")
    dateTimeFormat = try reader.optional("date_time_format")
    customFormatIdentifier = try reader.optional("custom_format_identifier")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("format_type", formatType)
    writer.optional("number_format", numberFormat)
    writer.optional("currency_format", currencyFormat)
    writer.optional("fraction_format", fractionFormat)
    writer.optional("base_format", baseFormat)
    writer.optional("bool_format", boolFormat)
    writer.optional("duration_format", durationFormat)
    writer.optional("date_time_format", dateTimeFormat)
    writer.optional("custom_format_identifier", customFormatIdentifier)
  }
}
