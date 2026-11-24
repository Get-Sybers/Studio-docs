public import TextModel
public import WireFormat

/// The type `table.cell` of the format.
public struct TableCell: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "TableCell")

  /// The `value` member; "" when omitted.
  public var value: String?
  /// The `unformatted_value` member.
  public var unformattedValue: UnformattedValue?
  /// The `cell_format` member; kept out of line, so the value stays small.
  public var cellFormat: Indirect<CellFormat>?
  /// The `cell_properties` member.
  public var cellProperties: CellProperties?
  /// The `text_properties` member; kept out of line, so the value stays small.
  public var textProperties: Indirect<ParagraphProperties>?
  /// The `strokes` member; kept out of line, so the value stays small.
  public var strokes: Indirect<CellStrokes>?
  /// The `anchored_objects` member.
  public var anchoredObjects: [String]?
  /// The `column_index` member.
  public var columnIndex: Int?
  /// The `formula` member.
  public var formula: CellFormula?
  /// The `spill_range` member.
  public var spillRange: RowColumnIdRange?
  /// The `conditional_style_set_identifier` member.
  public var conditionalStyleSetIdentifier: String?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    value: String? = nil, unformattedValue: UnformattedValue? = nil, cellFormat: CellFormat? = nil,
    cellProperties: CellProperties? = nil, textProperties: ParagraphProperties? = nil, strokes: CellStrokes? = nil,
    anchoredObjects: [String]? = nil, columnIndex: Int? = nil, formula: CellFormula? = nil,
    spillRange: RowColumnIdRange? = nil, conditionalStyleSetIdentifier: String? = nil
  ) {
    self.value = value
    self.unformattedValue = unformattedValue
    self.cellFormat = cellFormat.map(Indirect.init)
    self.cellProperties = cellProperties
    self.textProperties = textProperties.map(Indirect.init)
    self.strokes = strokes.map(Indirect.init)
    self.anchoredObjects = anchoredObjects
    self.columnIndex = columnIndex
    self.formula = formula
    self.spillRange = spillRange
    self.conditionalStyleSetIdentifier = conditionalStyleSetIdentifier
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    value = try reader.optional("value")
    unformattedValue = try reader.optional("unformatted_value")
    cellFormat = try reader.optional("cell_format")
    cellProperties = try reader.optional("cell_properties")
    textProperties = try reader.optional("text_properties")
    strokes = try reader.optional("strokes")
    anchoredObjects = try reader.optional("anchored_objects")
    columnIndex = try reader.optional("column_index")
    formula = try reader.optional("formula")
    spillRange = try reader.optional("spill_range")
    conditionalStyleSetIdentifier = try reader.optional("conditional_style_set_identifier")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("value", value)
    writer.optional("unformatted_value", unformattedValue)
    writer.optional("cell_format", cellFormat)
    writer.optional("cell_properties", cellProperties)
    writer.optional("text_properties", textProperties)
    writer.optional("strokes", strokes)
    writer.optional("anchored_objects", anchoredObjects)
    writer.optional("column_index", columnIndex)
    writer.optional("formula", formula)
    writer.optional("spill_range", spillRange)
    writer.optional("conditional_style_set_identifier", conditionalStyleSetIdentifier)
  }
}
