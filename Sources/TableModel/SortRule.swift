public import WireFormat

/// The type `table.sort.rule` of the format.
public struct SortRule: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "SortRule")

  /// The `column_identifier` member.
  public var columnIdentifier: String
  /// The `direction` member; "ascending" when omitted.
  public var direction: SortDirection?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(columnIdentifier: String, direction: SortDirection? = nil) {
    self.columnIdentifier = columnIdentifier
    self.direction = direction
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    columnIdentifier = try reader.required("column_identifier")
    direction = try reader.optional("direction")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("column_identifier", columnIdentifier)
    writer.optional("direction", direction)
  }
}
