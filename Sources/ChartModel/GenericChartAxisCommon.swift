public import TextModel
public import WireFormat

/// The type `chart-axis-common-generic` of the format.
public struct GenericChartAxisCommon: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = ChartModelFormat.table.object(named: "GenericChartAxisCommon")

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
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    title: String? = nil, titleTextStyle: ParagraphProperties? = nil, labelTextStyle: ParagraphProperties? = nil,
    showLabels: Bool? = nil, showTitle: Bool? = nil, showMajorTickmarks: Bool? = nil, showMinorTickmarks: Bool? = nil,
    labelsOrientation: AxisLabelOrientation? = nil
  ) {
    self.title = title
    self.titleTextStyle = titleTextStyle.map(Indirect.init)
    self.labelTextStyle = labelTextStyle.map(Indirect.init)
    self.showLabels = showLabels
    self.showTitle = showTitle
    self.showMajorTickmarks = showMajorTickmarks
    self.showMinorTickmarks = showMinorTickmarks
    self.labelsOrientation = labelsOrientation
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
  }
}
