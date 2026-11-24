public import TableModel
public import TextModel
public import WireFormat

/// The type `chart-category-axis` of the format.
public struct ChartCategoryAxis: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = ChartModelFormat.table.object(named: "ChartCategoryAxis")

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
  /// The `label_spacing` member.
  public var labelSpacing: LabelSpacing?
  /// The `show_axis` member; true when omitted.
  public var showAxis: Bool?
  /// The `show_major_gridlines` member; false when omitted.
  public var showMajorGridlines: Bool?
  /// The `show_clustered_series_labels` member; false when omitted.
  public var showClusteredSeriesLabels: Bool?
  /// The `show_last_label` member; false when omitted.
  public var showLastLabel: Bool?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    title: String? = nil, titleTextStyle: ParagraphProperties? = nil, labelTextStyle: ParagraphProperties? = nil,
    showLabels: Bool? = nil, showTitle: Bool? = nil, showMajorTickmarks: Bool? = nil, showMinorTickmarks: Bool? = nil,
    labelsOrientation: AxisLabelOrientation? = nil, labelFormatType: CellFormatType? = nil,
    labelDateFormat: DateTimeFormat? = nil, labelDurationFormat: DurationFormat? = nil,
    labelNumberFormat: NumberFormat? = nil, labelCurrencyFormat: CurrencyFormat? = nil,
    labelSpacing: LabelSpacing? = nil, showAxis: Bool? = nil, showMajorGridlines: Bool? = nil,
    showClusteredSeriesLabels: Bool? = nil, showLastLabel: Bool? = nil
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
    self.labelSpacing = labelSpacing
    self.showAxis = showAxis
    self.showMajorGridlines = showMajorGridlines
    self.showClusteredSeriesLabels = showClusteredSeriesLabels
    self.showLastLabel = showLastLabel
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
    labelSpacing = try reader.optional("label_spacing")
    showAxis = try reader.optional("show_axis")
    showMajorGridlines = try reader.optional("show_major_gridlines")
    showClusteredSeriesLabels = try reader.optional("show_clustered_series_labels")
    showLastLabel = try reader.optional("show_last_label")
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
    writer.optional("label_spacing", labelSpacing)
    writer.optional("show_axis", showAxis)
    writer.optional("show_major_gridlines", showMajorGridlines)
    writer.optional("show_clustered_series_labels", showClusteredSeriesLabels)
    writer.optional("show_last_label", showLastLabel)
  }
}
