public import WireFormat

/// The type `table.predicate.reference` of the format.
public struct PredicateReference: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "PredicateReference")

  /// The `row_identifier` member.
  public var rowIdentifier: String
  /// The `column_identifier` member.
  public var columnIdentifier: String
  /// The `is_row_absolute` member; false when omitted.
  public var isRowAbsolute: Bool?
  /// The `is_column_absolute` member; false when omitted.
  public var isColumnAbsolute: Bool?
  /// The `table_identifier` member.
  public var tableIdentifier: String?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    rowIdentifier: String, columnIdentifier: String, isRowAbsolute: Bool? = nil, isColumnAbsolute: Bool? = nil,
    tableIdentifier: String? = nil
  ) {
    self.rowIdentifier = rowIdentifier
    self.columnIdentifier = columnIdentifier
    self.isRowAbsolute = isRowAbsolute
    self.isColumnAbsolute = isColumnAbsolute
    self.tableIdentifier = tableIdentifier
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    rowIdentifier = try reader.required("row_identifier")
    columnIdentifier = try reader.required("column_identifier")
    isRowAbsolute = try reader.optional("is_row_absolute")
    isColumnAbsolute = try reader.optional("is_column_absolute")
    tableIdentifier = try reader.optional("table_identifier")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("row_identifier", rowIdentifier)
    writer.required("column_identifier", columnIdentifier)
    writer.optional("is_row_absolute", isRowAbsolute)
    writer.optional("is_column_absolute", isColumnAbsolute)
    writer.optional("table_identifier", tableIdentifier)
  }
}
