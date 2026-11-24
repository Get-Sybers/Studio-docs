public import CanvasCommon
public import WireFormat

/// The type `table` of the format.
public struct Table: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "Table")

  /// The `geometry` member.
  public var geometry: Geometry?
  /// The `aspect_ratio_locked` member; false when omitted.
  public var aspectRatioLocked: Bool?
  /// The `description` member.
  public var description: String?
  /// The `title` member; kept out of line, so the value stays small.
  public var title: Indirect<Label>?
  /// The `caption` member; kept out of line, so the value stays small.
  public var caption: Indirect<Label>?
  /// The `table_name_border_enabled` member; false when omitted.
  public var tableNameBorderEnabled: Bool?
  /// The `number_of_columns` member.
  public var numberOfColumns: Int
  /// The `number_of_rows` member.
  public var numberOfRows: Int
  /// The `number_of_header_rows` member; 0 when omitted.
  public var numberOfHeaderRows: Int?
  /// The `number_of_header_columns` member; 0 when omitted.
  public var numberOfHeaderColumns: Int?
  /// The `number_of_footer_rows` member; 0 when omitted.
  public var numberOfFooterRows: Int?
  /// The `default_column_width` member; 98 when omitted.
  public var defaultColumnWidth: Double?
  /// The `default_row_height` member; 20 when omitted.
  public var defaultRowHeight: Double?
  /// The `visual_properties` member.
  public var visualProperties: TableVisualProperties?
  /// The `column_headers` member.
  public var columnHeaders: [ColumnHeader]?
  /// The `content` member.
  public var content: [TableRow]?
  /// The `merges` member.
  public var merges: [CellRange]?
  /// The `conditional_style_sets` member.
  public var conditionalStyleSets: [ConditionalStyleSet]?
  /// The `custom_formats` member.
  public var customFormats: [CustomFormat]?
  /// The `transformation` member.
  public var transformation: TransformationInfo?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    geometry: Geometry? = nil, aspectRatioLocked: Bool? = nil, description: String? = nil, title: Label? = nil,
    caption: Label? = nil, tableNameBorderEnabled: Bool? = nil, numberOfColumns: Int, numberOfRows: Int,
    numberOfHeaderRows: Int? = nil, numberOfHeaderColumns: Int? = nil, numberOfFooterRows: Int? = nil,
    defaultColumnWidth: Double? = nil, defaultRowHeight: Double? = nil, visualProperties: TableVisualProperties? = nil,
    columnHeaders: [ColumnHeader]? = nil, content: [TableRow]? = nil, merges: [CellRange]? = nil,
    conditionalStyleSets: [ConditionalStyleSet]? = nil, customFormats: [CustomFormat]? = nil,
    transformation: TransformationInfo? = nil
  ) {
    self.geometry = geometry
    self.aspectRatioLocked = aspectRatioLocked
    self.description = description
    self.title = title.map(Indirect.init)
    self.caption = caption.map(Indirect.init)
    self.tableNameBorderEnabled = tableNameBorderEnabled
    self.numberOfColumns = numberOfColumns
    self.numberOfRows = numberOfRows
    self.numberOfHeaderRows = numberOfHeaderRows
    self.numberOfHeaderColumns = numberOfHeaderColumns
    self.numberOfFooterRows = numberOfFooterRows
    self.defaultColumnWidth = defaultColumnWidth
    self.defaultRowHeight = defaultRowHeight
    self.visualProperties = visualProperties
    self.columnHeaders = columnHeaders
    self.content = content
    self.merges = merges
    self.conditionalStyleSets = conditionalStyleSets
    self.customFormats = customFormats
    self.transformation = transformation
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    geometry = try reader.optional("geometry")
    aspectRatioLocked = try reader.optional("aspect_ratio_locked")
    description = try reader.optional("description")
    title = try reader.optional("title")
    caption = try reader.optional("caption")
    tableNameBorderEnabled = try reader.optional("table_name_border_enabled")
    numberOfColumns = try reader.required("number_of_columns")
    numberOfRows = try reader.required("number_of_rows")
    numberOfHeaderRows = try reader.optional("number_of_header_rows")
    numberOfHeaderColumns = try reader.optional("number_of_header_columns")
    numberOfFooterRows = try reader.optional("number_of_footer_rows")
    defaultColumnWidth = try reader.optional("default_column_width")
    defaultRowHeight = try reader.optional("default_row_height")
    visualProperties = try reader.optional("visual_properties")
    columnHeaders = try reader.optional("column_headers")
    content = try reader.optional("content")
    merges = try reader.optional("merges")
    conditionalStyleSets = try reader.optional("conditional_style_sets")
    customFormats = try reader.optional("custom_formats")
    transformation = try reader.optional("transformation")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("geometry", geometry)
    writer.optional("aspect_ratio_locked", aspectRatioLocked)
    writer.optional("description", description)
    writer.optional("title", title)
    writer.optional("caption", caption)
    writer.optional("table_name_border_enabled", tableNameBorderEnabled)
    writer.required("number_of_columns", numberOfColumns)
    writer.required("number_of_rows", numberOfRows)
    writer.optional("number_of_header_rows", numberOfHeaderRows)
    writer.optional("number_of_header_columns", numberOfHeaderColumns)
    writer.optional("number_of_footer_rows", numberOfFooterRows)
    writer.optional("default_column_width", defaultColumnWidth)
    writer.optional("default_row_height", defaultRowHeight)
    writer.optional("visual_properties", visualProperties)
    writer.optional("column_headers", columnHeaders)
    writer.optional("content", content)
    writer.optional("merges", merges)
    writer.optional("conditional_style_sets", conditionalStyleSets)
    writer.optional("custom_formats", customFormats)
    writer.optional("transformation", transformation)
  }
}
