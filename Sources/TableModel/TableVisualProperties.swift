public import TextModel
public import WireFormat

/// The type `table.visual-properties` of the format.
public struct TableVisualProperties: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "TableVisualProperties")

  /// The `overall_properties` member; kept out of line, so the value stays small.
  public var overallProperties: Indirect<OverallProperties>?
  /// The `body_cell_properties` member; kept out of line, so the value stays small.
  public var bodyCellProperties: Indirect<CellProperties>?
  /// The `body_text_properties` member; kept out of line, so the value stays small.
  public var bodyTextProperties: Indirect<ParagraphProperties>?
  /// The `body_stroke_properties` member; kept out of line, so the value stays small.
  public var bodyStrokeProperties: Indirect<BodyStrokeProperties>?
  /// The `header_row_cell_properties` member; kept out of line, so the value stays small.
  public var headerRowCellProperties: Indirect<CellProperties>?
  /// The `header_row_text_properties` member; kept out of line, so the value stays small.
  public var headerRowTextProperties: Indirect<ParagraphProperties>?
  /// The `header_row_stroke_properties` member; kept out of line, so the value stays small.
  public var headerRowStrokeProperties: Indirect<HeaderFooterStrokeProperties>?
  /// The `header_column_cell_properties` member; kept out of line, so the value stays small.
  public var headerColumnCellProperties: Indirect<CellProperties>?
  /// The `header_column_text_properties` member; kept out of line, so the value stays small.
  public var headerColumnTextProperties: Indirect<ParagraphProperties>?
  /// The `header_column_stroke_properties` member; kept out of line, so the value stays small.
  public var headerColumnStrokeProperties: Indirect<HeaderFooterStrokeProperties>?
  /// The `footer_row_cell_properties` member; kept out of line, so the value stays small.
  public var footerRowCellProperties: Indirect<CellProperties>?
  /// The `footer_row_text_properties` member; kept out of line, so the value stays small.
  public var footerRowTextProperties: Indirect<ParagraphProperties>?
  /// The `footer_row_stroke_properties` member; kept out of line, so the value stays small.
  public var footerRowStrokeProperties: Indirect<HeaderFooterStrokeProperties>?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    overallProperties: OverallProperties? = nil, bodyCellProperties: CellProperties? = nil,
    bodyTextProperties: ParagraphProperties? = nil, bodyStrokeProperties: BodyStrokeProperties? = nil,
    headerRowCellProperties: CellProperties? = nil, headerRowTextProperties: ParagraphProperties? = nil,
    headerRowStrokeProperties: HeaderFooterStrokeProperties? = nil, headerColumnCellProperties: CellProperties? = nil,
    headerColumnTextProperties: ParagraphProperties? = nil,
    headerColumnStrokeProperties: HeaderFooterStrokeProperties? = nil, footerRowCellProperties: CellProperties? = nil,
    footerRowTextProperties: ParagraphProperties? = nil, footerRowStrokeProperties: HeaderFooterStrokeProperties? = nil
  ) {
    self.overallProperties = overallProperties.map(Indirect.init)
    self.bodyCellProperties = bodyCellProperties.map(Indirect.init)
    self.bodyTextProperties = bodyTextProperties.map(Indirect.init)
    self.bodyStrokeProperties = bodyStrokeProperties.map(Indirect.init)
    self.headerRowCellProperties = headerRowCellProperties.map(Indirect.init)
    self.headerRowTextProperties = headerRowTextProperties.map(Indirect.init)
    self.headerRowStrokeProperties = headerRowStrokeProperties.map(Indirect.init)
    self.headerColumnCellProperties = headerColumnCellProperties.map(Indirect.init)
    self.headerColumnTextProperties = headerColumnTextProperties.map(Indirect.init)
    self.headerColumnStrokeProperties = headerColumnStrokeProperties.map(Indirect.init)
    self.footerRowCellProperties = footerRowCellProperties.map(Indirect.init)
    self.footerRowTextProperties = footerRowTextProperties.map(Indirect.init)
    self.footerRowStrokeProperties = footerRowStrokeProperties.map(Indirect.init)
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    overallProperties = try reader.optional("overall_properties")
    bodyCellProperties = try reader.optional("body_cell_properties")
    bodyTextProperties = try reader.optional("body_text_properties")
    bodyStrokeProperties = try reader.optional("body_stroke_properties")
    headerRowCellProperties = try reader.optional("header_row_cell_properties")
    headerRowTextProperties = try reader.optional("header_row_text_properties")
    headerRowStrokeProperties = try reader.optional("header_row_stroke_properties")
    headerColumnCellProperties = try reader.optional("header_column_cell_properties")
    headerColumnTextProperties = try reader.optional("header_column_text_properties")
    headerColumnStrokeProperties = try reader.optional("header_column_stroke_properties")
    footerRowCellProperties = try reader.optional("footer_row_cell_properties")
    footerRowTextProperties = try reader.optional("footer_row_text_properties")
    footerRowStrokeProperties = try reader.optional("footer_row_stroke_properties")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("overall_properties", overallProperties)
    writer.optional("body_cell_properties", bodyCellProperties)
    writer.optional("body_text_properties", bodyTextProperties)
    writer.optional("body_stroke_properties", bodyStrokeProperties)
    writer.optional("header_row_cell_properties", headerRowCellProperties)
    writer.optional("header_row_text_properties", headerRowTextProperties)
    writer.optional("header_row_stroke_properties", headerRowStrokeProperties)
    writer.optional("header_column_cell_properties", headerColumnCellProperties)
    writer.optional("header_column_text_properties", headerColumnTextProperties)
    writer.optional("header_column_stroke_properties", headerColumnStrokeProperties)
    writer.optional("footer_row_cell_properties", footerRowCellProperties)
    writer.optional("footer_row_text_properties", footerRowTextProperties)
    writer.optional("footer_row_stroke_properties", footerRowStrokeProperties)
  }
}
