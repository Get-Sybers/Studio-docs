public import WireFormat

/// The type `table.cell.formula.cell-reference` of the format.
public struct CellReference: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "CellReference")

  /// The `placeholder` member.
  public var placeholder: String
  /// The `display_notation` member.
  public var displayNotation: String?
  /// The `start_row_identifier` member.
  public var startRowIdentifier: String
  /// The `start_column_identifier` member.
  public var startColumnIdentifier: String
  /// The `end_row_identifier` member.
  public var endRowIdentifier: String?
  /// The `end_column_identifier` member.
  public var endColumnIdentifier: String?
  /// The `is_row_absolute` member; false when omitted.
  public var isRowAbsolute: Bool?
  /// The `is_column_absolute` member; false when omitted.
  public var isColumnAbsolute: Bool?
  /// The `is_end_row_absolute` member; false when omitted.
  public var isEndRowAbsolute: Bool?
  /// The `is_end_column_absolute` member; false when omitted.
  public var isEndColumnAbsolute: Bool?
  /// The `table_identifier` member.
  public var tableIdentifier: String?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    placeholder: String, displayNotation: String? = nil, startRowIdentifier: String, startColumnIdentifier: String,
    endRowIdentifier: String? = nil, endColumnIdentifier: String? = nil, isRowAbsolute: Bool? = nil,
    isColumnAbsolute: Bool? = nil, isEndRowAbsolute: Bool? = nil, isEndColumnAbsolute: Bool? = nil,
    tableIdentifier: String? = nil
  ) {
    self.placeholder = placeholder
    self.displayNotation = displayNotation
    self.startRowIdentifier = startRowIdentifier
    self.startColumnIdentifier = startColumnIdentifier
    self.endRowIdentifier = endRowIdentifier
    self.endColumnIdentifier = endColumnIdentifier
    self.isRowAbsolute = isRowAbsolute
    self.isColumnAbsolute = isColumnAbsolute
    self.isEndRowAbsolute = isEndRowAbsolute
    self.isEndColumnAbsolute = isEndColumnAbsolute
    self.tableIdentifier = tableIdentifier
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    placeholder = try reader.required("placeholder")
    displayNotation = try reader.optional("display_notation")
    startRowIdentifier = try reader.required("start_row_identifier")
    startColumnIdentifier = try reader.required("start_column_identifier")
    endRowIdentifier = try reader.optional("end_row_identifier")
    endColumnIdentifier = try reader.optional("end_column_identifier")
    isRowAbsolute = try reader.optional("is_row_absolute")
    isColumnAbsolute = try reader.optional("is_column_absolute")
    isEndRowAbsolute = try reader.optional("is_end_row_absolute")
    isEndColumnAbsolute = try reader.optional("is_end_column_absolute")
    tableIdentifier = try reader.optional("table_identifier")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("placeholder", placeholder)
    writer.optional("display_notation", displayNotation)
    writer.required("start_row_identifier", startRowIdentifier)
    writer.required("start_column_identifier", startColumnIdentifier)
    writer.optional("end_row_identifier", endRowIdentifier)
    writer.optional("end_column_identifier", endColumnIdentifier)
    writer.optional("is_row_absolute", isRowAbsolute)
    writer.optional("is_column_absolute", isColumnAbsolute)
    writer.optional("is_end_row_absolute", isEndRowAbsolute)
    writer.optional("is_end_column_absolute", isEndColumnAbsolute)
    writer.optional("table_identifier", tableIdentifier)
  }
}
