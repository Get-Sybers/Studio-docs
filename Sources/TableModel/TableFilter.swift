public import WireFormat

/// The type `table.filter-set.filter` of the format.
public struct TableFilter: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "TableFilter")

  /// The `column_identifier` member.
  public var columnIdentifier: String
  /// The `rules` member.
  public var rules: [FilterRule]
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(columnIdentifier: String, rules: [FilterRule]) {
    self.columnIdentifier = columnIdentifier
    self.rules = rules
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    columnIdentifier = try reader.required("column_identifier")
    rules = try reader.required("rules")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("column_identifier", columnIdentifier)
    writer.required("rules", rules)
  }
}
