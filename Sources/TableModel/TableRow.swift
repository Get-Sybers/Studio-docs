public import TextModel
public import WireFormat

/// The type `table.row` of the format.
public struct TableRow: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "TableRow")

  /// The `row_index` member.
  public var rowIndex: Int?
  /// The `row_identifier` member.
  public var rowIdentifier: String?
  /// The `row_height` member.
  public var rowHeight: Double?
  /// The `cell_properties` member.
  public var cellProperties: CellProperties?
  /// The `text_properties` member; kept out of line, so the value stays small.
  public var textProperties: Indirect<ParagraphProperties>?
  /// The `cells` member.
  public var cells: [TableCell]?
  /// The `visibility_state` member; "visible" when omitted.
  public var visibilityState: RowVisibility?
  /// The `kind` member.
  public var kind: RowKind?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    rowIndex: Int? = nil, rowIdentifier: String? = nil, rowHeight: Double? = nil, cellProperties: CellProperties? = nil,
    textProperties: ParagraphProperties? = nil, cells: [TableCell]? = nil, visibilityState: RowVisibility? = nil,
    kind: RowKind? = nil
  ) {
    self.rowIndex = rowIndex
    self.rowIdentifier = rowIdentifier
    self.rowHeight = rowHeight
    self.cellProperties = cellProperties
    self.textProperties = textProperties.map(Indirect.init)
    self.cells = cells
    self.visibilityState = visibilityState
    self.kind = kind
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    rowIndex = try reader.optional("row_index")
    rowIdentifier = try reader.optional("row_identifier")
    rowHeight = try reader.optional("row_height")
    cellProperties = try reader.optional("cell_properties")
    textProperties = try reader.optional("text_properties")
    cells = try reader.optional("cells")
    visibilityState = try reader.optional("visibility_state")
    kind = try reader.optional("kind")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("row_index", rowIndex)
    writer.optional("row_identifier", rowIdentifier)
    writer.optional("row_height", rowHeight)
    writer.optional("cell_properties", cellProperties)
    writer.optional("text_properties", textProperties)
    writer.optional("cells", cells)
    writer.optional("visibility_state", visibilityState)
    writer.optional("kind", kind)
  }
}
