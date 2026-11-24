public import TableModel
public import TextModel
public import WireFormat

/// The type `chart-value-axis` of the format.
public struct ChartValueAxis: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = ChartModelFormat.table.object(named: "ChartValueAxis")

  /// The `title` member.
  public var title: String?
  /// The `title_text_style` member; kept out of line, so the value stays small.
  public var titleTextStyle: Indirect<ParagraphProperties>?
  /// The `label_text_style` member; kept out of line, so the value stays small.
  public var labelTextStyle: Indirect<ParagraphProperties>?
  /// The `show_labels` member; true when omitted.
  public var showLabels: Bool?
  /// The `show_title` member; false when omitted.
  public var showTitle: Bool?
  /// The `show_major_tickmarks` member; true when omitted.
  public var showMajorTickmarks: Bool?
  /// The `show_minor_tickmarks` member; true when omitted.
  public var showMinorTickmarks: Bool?
  /// The `labels_orientation` member.
  public var labelsOrientation: AxisLabelOrientation?
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
  /// The `scale` member.
  public var scale: AxisScale?
  /// The `max` member.
  public var max: ChartDataValue?
  /// The `min` member.
  public var min: ChartDataValue?
  /// The `show_axis` member; false when omitted.
  public var showAxis: Bool?
  /// The `show_major_gridlines` member; true when omitted.
  public var showMajorGridlines: Bool?
  /// The `show_minimum_label` member; true when omitted.
  public var showMinimumLabel: Bool?
  /// The `number_of_major_gridlines` member.
  public var numberOfMajorGridlines: Int?
  /// The `number_of_decades` member.
  public var numberOfDecades: Int?
  /// The `number_of_minor_gridlines` member.
  public var numberOfMinorGridlines: Int?
  /// The `show_minor_gridlines` member; false when omitted.
  public var showMinorGridlines: Bool?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    title: String? = nil, titleTextStyle: ParagraphProperties? = nil, labelTextStyle: ParagraphProperties? = nil,
    showLabels: Bool? = nil, showTitle: Bool? = nil, showMajorTickmarks: Bool? = nil, showMinorTickmarks: Bool? = nil,
    labelsOrientation: AxisLabelOrientation? = nil, labelFormatType: CellFormatType? = nil,
    labelDateFormat: DateTimeFormat? = nil, labelDurationFormat: DurationFormat? = nil,
    labelNumberFormat: NumberFormat? = nil, labelCurrencyFormat: CurrencyFormat? = nil, scale: AxisScale? = nil,
    max: ChartDataValue? = nil, min: ChartDataValue? = nil, showAxis: Bool? = nil, showMajorGridlines: Bool? = nil,
    showMinimumLabel: Bool? = nil, numberOfMajorGridlines: Int? = nil, numberOfDecades: Int? = nil,
    numberOfMinorGridlines: Int? = nil, showMinorGridlines: Bool? = nil
  ) {
    self.title = title
    self.titleTextStyle = titleTextStyle.map(Indirect.init)
    self.labelTextStyle = labelTextStyle.map(Indirect.init)
    self.showLabels = showLabels
    self.showTitle = showTitle
    self.showMajorTickmarks = showMajorTickmarks
    self.showMinorTickmarks = showMinorTickmarks
    self.labelsOrientation = labelsOrientation
    self.labelFormatType = labelFormatType
    self.labelDateFormat = labelDateFormat
    self.labelDurationFormat = labelDurationFormat
    self.labelNumberFormat = labelNumberFormat
    self.labelCurrencyFormat = labelCurrencyFormat
    self.scale = scale
    self.max = max
    self.min = min
    self.showAxis = showAxis
    self.showMajorGridlines = showMajorGridlines
    self.showMinimumLabel = showMinimumLabel
    self.numberOfMajorGridlines = numberOfMajorGridlines
    self.numberOfDecades = numberOfDecades
    self.numberOfMinorGridlines = numberOfMinorGridlines
    self.showMinorGridlines = showMinorGridlines
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    title = try reader.optional("title")
    titleTextStyle = try reader.optional("title_text_style")
    labelTextStyle = try reader.optional("label_text_style")
    showLabels = try reader.optional("show_labels")
    showTitle = try reader.optional("show_title")
    showMajorTickmarks = try reader.optional("show_major_tickmarks")
    showMinorTickmarks = try reader.optional("show_minor_tickmarks")
    labelsOrientation = try reader.optional("labels_orientation")
    labelFormatType = try reader.optional("label_format_type")
    labelDateFormat = try reader.optional("label_date_format")
    labelDurationFormat = try reader.optional("label_duration_format")
    labelNumberFormat = try reader.optional("label_number_format")
    labelCurrencyFormat = try reader.optional("label_currency_format")
    scale = try reader.optional("scale")
    max = try reader.optional("max")
    min = try reader.optional("min")
    showAxis = try reader.optional("show_axis")
    showMajorGridlines = try reader.optional("show_major_gridlines")
    showMinimumLabel = try reader.optional("show_minimum_label")
    numberOfMajorGridlines = try reader.optional("number_of_major_gridlines")
    numberOfDecades = try reader.optional("number_of_decades")
    numberOfMinorGridlines = try reader.optional("number_of_minor_gridlines")
    showMinorGridlines = try reader.optional("show_minor_gridlines")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("title", title)
    writer.optional("title_text_style", titleTextStyle)
    writer.optional("label_text_style", labelTextStyle)
    writer.optional("show_labels", showLabels)
    writer.optional("show_title", showTitle)
    writer.optional("show_major_tickmarks", showMajorTickmarks)
    writer.optional("show_minor_tickmarks", showMinorTickmarks)
    writer.optional("labels_orientation", labelsOrientation)
    writer.optional("label_format_type", labelFormatType)
    writer.optional("label_date_format", labelDateFormat)
    writer.optional("label_duration_format", labelDurationFormat)
    writer.optional("label_number_format", labelNumberFormat)
    writer.optional("label_currency_format", labelCurrencyFormat)
    writer.optional("scale", scale)
    writer.optional("max", max)
    writer.optional("min", min)
    writer.optional("show_axis", showAxis)
    writer.optional("show_major_gridlines", showMajorGridlines)
    writer.optional("show_minimum_label", showMinimumLabel)
    writer.optional("number_of_major_gridlines", numberOfMajorGridlines)
    writer.optional("number_of_decades", numberOfDecades)
    writer.optional("number_of_minor_gridlines", numberOfMinorGridlines)
    writer.optional("show_minor_gridlines", showMinorGridlines)
  }
}
