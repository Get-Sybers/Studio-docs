public import TextModel
public import WireFormat

/// The type `stylesheet.table-style-collection` of the format.
public struct TableStyleCollection: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = PresentationModelFormat.table.object(named: "TableStyleCollection")

  /// The `table_name_shape_style` member; kept out of line, so the value stays small.
  public var tableNameShapeStyle: Indirect<ShapeStyle>?
  /// The `table_name_style` member; kept out of line, so the value stays small.
  public var tableNameStyle: Indirect<NamedParagraphStyle>?
  /// The `overall_style` member; kept out of line, so the value stays small.
  public var overallStyle: Indirect<OverallStyle>
  /// The `body_cell_style` member; kept out of line, so the value stays small.
  public var bodyCellStyle: Indirect<CellStyle>
  /// The `body_text_style` member; kept out of line, so the value stays small.
  public var bodyTextStyle: Indirect<NamedParagraphStyle>
  /// The `body_stroke_style` member; kept out of line, so the value stays small.
  public var bodyStrokeStyle: Indirect<BodyStrokeStyle>
  /// The `header_row_cell_style` member; kept out of line, so the value stays small.
  public var headerRowCellStyle: Indirect<CellStyle>
  /// The `header_row_text_style` member; kept out of line, so the value stays small.
  public var headerRowTextStyle: Indirect<NamedParagraphStyle>
  /// The `header_row_stroke_style` member; kept out of line, so the value stays small.
  public var headerRowStrokeStyle: Indirect<HeaderFooterStrokeStyle>
  /// The `header_column_cell_style` member; kept out of line, so the value stays small.
  public var headerColumnCellStyle: Indirect<CellStyle>
  /// The `header_column_text_style` member; kept out of line, so the value stays small.
  public var headerColumnTextStyle: Indirect<NamedParagraphStyle>
  /// The `header_column_stroke_style` member; kept out of line, so the value stays small.
  public var headerColumnStrokeStyle: Indirect<HeaderFooterStrokeStyle>
  /// The `footer_row_cell_style` member; kept out of line, so the value stays small.
  public var footerRowCellStyle: Indirect<CellStyle>
  /// The `footer_row_text_style` member; kept out of line, so the value stays small.
  public var footerRowTextStyle: Indirect<NamedParagraphStyle>
  /// The `footer_row_stroke_style` member; kept out of line, so the value stays small.
  public var footerRowStrokeStyle: Indirect<HeaderFooterStrokeStyle>
  /// The `category_level1_cell_style` member; kept out of line, so the value stays small.
  public var categoryLevel1CellStyle: Indirect<CellStyle>?
  /// The `category_level1_text_style` member; kept out of line, so the value stays small.
  public var categoryLevel1TextStyle: Indirect<NamedParagraphStyle>?
  /// The `category_level2_cell_style` member; kept out of line, so the value stays small.
  public var categoryLevel2CellStyle: Indirect<CellStyle>?
  /// The `category_level2_text_style` member; kept out of line, so the value stays small.
  public var categoryLevel2TextStyle: Indirect<NamedParagraphStyle>?
  /// The `category_level3_cell_style` member; kept out of line, so the value stays small.
  public var categoryLevel3CellStyle: Indirect<CellStyle>?
  /// The `category_level3_text_style` member; kept out of line, so the value stays small.
  public var categoryLevel3TextStyle: Indirect<NamedParagraphStyle>?
  /// The `category_level4_cell_style` member; kept out of line, so the value stays small.
  public var categoryLevel4CellStyle: Indirect<CellStyle>?
  /// The `category_level4_text_style` member; kept out of line, so the value stays small.
  public var categoryLevel4TextStyle: Indirect<NamedParagraphStyle>?
  /// The `category_level5_cell_style` member; kept out of line, so the value stays small.
  public var categoryLevel5CellStyle: Indirect<CellStyle>?
  /// The `category_level5_text_style` member; kept out of line, so the value stays small.
  public var categoryLevel5TextStyle: Indirect<NamedParagraphStyle>?
  /// The `label_level1_cell_style` member; kept out of line, so the value stays small.
  public var labelLevel1CellStyle: Indirect<CellStyle>?
  /// The `label_level1_text_style` member; kept out of line, so the value stays small.
  public var labelLevel1TextStyle: Indirect<NamedParagraphStyle>?
  /// The `label_level2_cell_style` member; kept out of line, so the value stays small.
  public var labelLevel2CellStyle: Indirect<CellStyle>?
  /// The `label_level2_text_style` member; kept out of line, so the value stays small.
  public var labelLevel2TextStyle: Indirect<NamedParagraphStyle>?
  /// The `label_level3_cell_style` member; kept out of line, so the value stays small.
  public var labelLevel3CellStyle: Indirect<CellStyle>?
  /// The `label_level3_text_style` member; kept out of line, so the value stays small.
  public var labelLevel3TextStyle: Indirect<NamedParagraphStyle>?
  /// The `label_level4_cell_style` member; kept out of line, so the value stays small.
  public var labelLevel4CellStyle: Indirect<CellStyle>?
  /// The `label_level4_text_style` member; kept out of line, so the value stays small.
  public var labelLevel4TextStyle: Indirect<NamedParagraphStyle>?
  /// The `label_level5_cell_style` member; kept out of line, so the value stays small.
  public var labelLevel5CellStyle: Indirect<CellStyle>?
  /// The `label_level5_text_style` member; kept out of line, so the value stays small.
  public var labelLevel5TextStyle: Indirect<NamedParagraphStyle>?
  /// The `pivot_body_summary_row_cell_style` member; kept out of line, so the value stays small.
  public var pivotBodySummaryRowCellStyle: Indirect<CellStyle>?
  /// The `pivot_body_summary_column_cell_style` member; kept out of line, so the value stays small.
  public var pivotBodySummaryColumnCellStyle: Indirect<CellStyle>?
  /// The `pivot_header_column_summary_cell_style` member; kept out of line, so the value stays small.
  public var pivotHeaderColumnSummaryCellStyle: Indirect<CellStyle>?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    tableNameShapeStyle: ShapeStyle? = nil, tableNameStyle: NamedParagraphStyle? = nil, overallStyle: OverallStyle,
    bodyCellStyle: CellStyle, bodyTextStyle: NamedParagraphStyle, bodyStrokeStyle: BodyStrokeStyle,
    headerRowCellStyle: CellStyle, headerRowTextStyle: NamedParagraphStyle,
    headerRowStrokeStyle: HeaderFooterStrokeStyle, headerColumnCellStyle: CellStyle,
    headerColumnTextStyle: NamedParagraphStyle, headerColumnStrokeStyle: HeaderFooterStrokeStyle,
    footerRowCellStyle: CellStyle, footerRowTextStyle: NamedParagraphStyle,
    footerRowStrokeStyle: HeaderFooterStrokeStyle, categoryLevel1CellStyle: CellStyle? = nil,
    categoryLevel1TextStyle: NamedParagraphStyle? = nil, categoryLevel2CellStyle: CellStyle? = nil,
    categoryLevel2TextStyle: NamedParagraphStyle? = nil, categoryLevel3CellStyle: CellStyle? = nil,
    categoryLevel3TextStyle: NamedParagraphStyle? = nil, categoryLevel4CellStyle: CellStyle? = nil,
    categoryLevel4TextStyle: NamedParagraphStyle? = nil, categoryLevel5CellStyle: CellStyle? = nil,
    categoryLevel5TextStyle: NamedParagraphStyle? = nil, labelLevel1CellStyle: CellStyle? = nil,
    labelLevel1TextStyle: NamedParagraphStyle? = nil, labelLevel2CellStyle: CellStyle? = nil,
    labelLevel2TextStyle: NamedParagraphStyle? = nil, labelLevel3CellStyle: CellStyle? = nil,
    labelLevel3TextStyle: NamedParagraphStyle? = nil, labelLevel4CellStyle: CellStyle? = nil,
    labelLevel4TextStyle: NamedParagraphStyle? = nil, labelLevel5CellStyle: CellStyle? = nil,
    labelLevel5TextStyle: NamedParagraphStyle? = nil, pivotBodySummaryRowCellStyle: CellStyle? = nil,
    pivotBodySummaryColumnCellStyle: CellStyle? = nil, pivotHeaderColumnSummaryCellStyle: CellStyle? = nil
  ) {
    self.tableNameShapeStyle = tableNameShapeStyle.map(Indirect.init)
    self.tableNameStyle = tableNameStyle.map(Indirect.init)
    self.overallStyle = Indirect(overallStyle)
    self.bodyCellStyle = Indirect(bodyCellStyle)
    self.bodyTextStyle = Indirect(bodyTextStyle)
    self.bodyStrokeStyle = Indirect(bodyStrokeStyle)
    self.headerRowCellStyle = Indirect(headerRowCellStyle)
    self.headerRowTextStyle = Indirect(headerRowTextStyle)
    self.headerRowStrokeStyle = Indirect(headerRowStrokeStyle)
    self.headerColumnCellStyle = Indirect(headerColumnCellStyle)
    self.headerColumnTextStyle = Indirect(headerColumnTextStyle)
    self.headerColumnStrokeStyle = Indirect(headerColumnStrokeStyle)
    self.footerRowCellStyle = Indirect(footerRowCellStyle)
    self.footerRowTextStyle = Indirect(footerRowTextStyle)
    self.footerRowStrokeStyle = Indirect(footerRowStrokeStyle)
    self.categoryLevel1CellStyle = categoryLevel1CellStyle.map(Indirect.init)
    self.categoryLevel1TextStyle = categoryLevel1TextStyle.map(Indirect.init)
    self.categoryLevel2CellStyle = categoryLevel2CellStyle.map(Indirect.init)
    self.categoryLevel2TextStyle = categoryLevel2TextStyle.map(Indirect.init)
    self.categoryLevel3CellStyle = categoryLevel3CellStyle.map(Indirect.init)
    self.categoryLevel3TextStyle = categoryLevel3TextStyle.map(Indirect.init)
    self.categoryLevel4CellStyle = categoryLevel4CellStyle.map(Indirect.init)
    self.categoryLevel4TextStyle = categoryLevel4TextStyle.map(Indirect.init)
    self.categoryLevel5CellStyle = categoryLevel5CellStyle.map(Indirect.init)
    self.categoryLevel5TextStyle = categoryLevel5TextStyle.map(Indirect.init)
    self.labelLevel1CellStyle = labelLevel1CellStyle.map(Indirect.init)
    self.labelLevel1TextStyle = labelLevel1TextStyle.map(Indirect.init)
    self.labelLevel2CellStyle = labelLevel2CellStyle.map(Indirect.init)
    self.labelLevel2TextStyle = labelLevel2TextStyle.map(Indirect.init)
    self.labelLevel3CellStyle = labelLevel3CellStyle.map(Indirect.init)
    self.labelLevel3TextStyle = labelLevel3TextStyle.map(Indirect.init)
    self.labelLevel4CellStyle = labelLevel4CellStyle.map(Indirect.init)
    self.labelLevel4TextStyle = labelLevel4TextStyle.map(Indirect.init)
    self.labelLevel5CellStyle = labelLevel5CellStyle.map(Indirect.init)
    self.labelLevel5TextStyle = labelLevel5TextStyle.map(Indirect.init)
    self.pivotBodySummaryRowCellStyle = pivotBodySummaryRowCellStyle.map(Indirect.init)
    self.pivotBodySummaryColumnCellStyle = pivotBodySummaryColumnCellStyle.map(Indirect.init)
    self.pivotHeaderColumnSummaryCellStyle = pivotHeaderColumnSummaryCellStyle.map(Indirect.init)
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    tableNameShapeStyle = try reader.optional("table_name_shape_style")
    tableNameStyle = try reader.optional("table_name_style")
    overallStyle = try reader.required("overall_style")
    bodyCellStyle = try reader.required("body_cell_style")
    bodyTextStyle = try reader.required("body_text_style")
    bodyStrokeStyle = try reader.required("body_stroke_style")
    headerRowCellStyle = try reader.required("header_row_cell_style")
    headerRowTextStyle = try reader.required("header_row_text_style")
    headerRowStrokeStyle = try reader.required("header_row_stroke_style")
    headerColumnCellStyle = try reader.required("header_column_cell_style")
    headerColumnTextStyle = try reader.required("header_column_text_style")
    headerColumnStrokeStyle = try reader.required("header_column_stroke_style")
    footerRowCellStyle = try reader.required("footer_row_cell_style")
    footerRowTextStyle = try reader.required("footer_row_text_style")
    footerRowStrokeStyle = try reader.required("footer_row_stroke_style")
    categoryLevel1CellStyle = try reader.optional("category_level1_cell_style")
    categoryLevel1TextStyle = try reader.optional("category_level1_text_style")
    categoryLevel2CellStyle = try reader.optional("category_level2_cell_style")
    categoryLevel2TextStyle = try reader.optional("category_level2_text_style")
    categoryLevel3CellStyle = try reader.optional("category_level3_cell_style")
    categoryLevel3TextStyle = try reader.optional("category_level3_text_style")
    categoryLevel4CellStyle = try reader.optional("category_level4_cell_style")
    categoryLevel4TextStyle = try reader.optional("category_level4_text_style")
    categoryLevel5CellStyle = try reader.optional("category_level5_cell_style")
    categoryLevel5TextStyle = try reader.optional("category_level5_text_style")
    labelLevel1CellStyle = try reader.optional("label_level1_cell_style")
    labelLevel1TextStyle = try reader.optional("label_level1_text_style")
    labelLevel2CellStyle = try reader.optional("label_level2_cell_style")
    labelLevel2TextStyle = try reader.optional("label_level2_text_style")
    labelLevel3CellStyle = try reader.optional("label_level3_cell_style")
    labelLevel3TextStyle = try reader.optional("label_level3_text_style")
    labelLevel4CellStyle = try reader.optional("label_level4_cell_style")
    labelLevel4TextStyle = try reader.optional("label_level4_text_style")
    labelLevel5CellStyle = try reader.optional("label_level5_cell_style")
    labelLevel5TextStyle = try reader.optional("label_level5_text_style")
    pivotBodySummaryRowCellStyle = try reader.optional("pivot_body_summary_row_cell_style")
    pivotBodySummaryColumnCellStyle = try reader.optional("pivot_body_summary_column_cell_style")
    pivotHeaderColumnSummaryCellStyle = try reader.optional("pivot_header_column_summary_cell_style")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("table_name_shape_style", tableNameShapeStyle)
    writer.optional("table_name_style", tableNameStyle)
    writer.required("overall_style", overallStyle)
    writer.required("body_cell_style", bodyCellStyle)
    writer.required("body_text_style", bodyTextStyle)
    writer.required("body_stroke_style", bodyStrokeStyle)
    writer.required("header_row_cell_style", headerRowCellStyle)
    writer.required("header_row_text_style", headerRowTextStyle)
    writer.required("header_row_stroke_style", headerRowStrokeStyle)
    writer.required("header_column_cell_style", headerColumnCellStyle)
    writer.required("header_column_text_style", headerColumnTextStyle)
    writer.required("header_column_stroke_style", headerColumnStrokeStyle)
    writer.required("footer_row_cell_style", footerRowCellStyle)
    writer.required("footer_row_text_style", footerRowTextStyle)
    writer.required("footer_row_stroke_style", footerRowStrokeStyle)
    writer.optional("category_level1_cell_style", categoryLevel1CellStyle)
    writer.optional("category_level1_text_style", categoryLevel1TextStyle)
    writer.optional("category_level2_cell_style", categoryLevel2CellStyle)
    writer.optional("category_level2_text_style", categoryLevel2TextStyle)
    writer.optional("category_level3_cell_style", categoryLevel3CellStyle)
    writer.optional("category_level3_text_style", categoryLevel3TextStyle)
    writer.optional("category_level4_cell_style", categoryLevel4CellStyle)
    writer.optional("category_level4_text_style", categoryLevel4TextStyle)
    writer.optional("category_level5_cell_style", categoryLevel5CellStyle)
    writer.optional("category_level5_text_style", categoryLevel5TextStyle)
    writer.optional("label_level1_cell_style", labelLevel1CellStyle)
    writer.optional("label_level1_text_style", labelLevel1TextStyle)
    writer.optional("label_level2_cell_style", labelLevel2CellStyle)
    writer.optional("label_level2_text_style", labelLevel2TextStyle)
    writer.optional("label_level3_cell_style", labelLevel3CellStyle)
    writer.optional("label_level3_text_style", labelLevel3TextStyle)
    writer.optional("label_level4_cell_style", labelLevel4CellStyle)
    writer.optional("label_level4_text_style", labelLevel4TextStyle)
    writer.optional("label_level5_cell_style", labelLevel5CellStyle)
    writer.optional("label_level5_text_style", labelLevel5TextStyle)
    writer.optional("pivot_body_summary_row_cell_style", pivotBodySummaryRowCellStyle)
    writer.optional("pivot_body_summary_column_cell_style", pivotBodySummaryColumnCellStyle)
    writer.optional("pivot_header_column_summary_cell_style", pivotHeaderColumnSummaryCellStyle)
  }
}
