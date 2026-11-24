public import TextModel
public import WireFormat

/// The type `table.column-header` of the format.
public struct ColumnHeader: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "ColumnHeader")

  /// The `column_identifier` member.
  public var columnIdentifier: String?
  /// The `title` member.
  public var title: String?
  /// The `cell_format` member; kept out of line, so the value stays small.
  public var cellFormat: Indirect<CellFormat>?
  /// The `column_width` member.
  public var columnWidth: Double?
  /// The `cell_properties` member.
  public var cellProperties: CellProperties?
  /// The `text_properties` member; kept out of line, so the value stays small.
  public var textProperties: Indirect<ParagraphProperties>?
  /// The `visibility_state` member; "visible" when omitted.
  public var visibilityState: ColumnVisibility?
  /// The `kind` member.
  public var kind: ColumnHeaderKind?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    columnIdentifier: String? = nil, title: String? = nil, cellFormat: CellFormat? = nil, columnWidth: Double? = nil,
    cellProperties: CellProperties? = nil, textProperties: ParagraphProperties? = nil,
    visibilityState: ColumnVisibility? = nil, kind: ColumnHeaderKind? = nil
  ) {
    self.columnIdentifier = columnIdentifier
    self.title = title
    self.cellFormat = cellFormat.map(Indirect.init)
    self.columnWidth = columnWidth
    self.cellProperties = cellProperties
    self.textProperties = textProperties.map(Indirect.init)
    self.visibilityState = visibilityState
    self.kind = kind
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    columnIdentifier = try reader.optional("column_identifier")
    title = try reader.optional("title")
    cellFormat = try reader.optional("cell_format")
    columnWidth = try reader.optional("column_width")
    cellProperties = try reader.optional("cell_properties")
    textProperties = try reader.optional("text_properties")
    visibilityState = try reader.optional("visibility_state")
    kind = try reader.optional("kind")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("column_identifier", columnIdentifier)
    writer.optional("title", title)
    writer.optional("cell_format", cellFormat)
    writer.optional("column_width", columnWidth)
    writer.optional("cell_properties", cellProperties)
    writer.optional("text_properties", textProperties)
    writer.optional("visibility_state", visibilityState)
    writer.optional("kind", kind)
  }
}
