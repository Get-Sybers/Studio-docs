public import WireFormat

/// The type `table.sort` of the format.
public struct TableSort: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "TableSort")

  /// The `scope` member; "entire_table" when omitted.
  public var scope: SortScope?
  /// The `rules` member.
  public var rules: [SortRule]
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(scope: SortScope? = nil, rules: [SortRule]) {
    self.scope = scope
    self.rules = rules
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    scope = try reader.optional("scope")
    rules = try reader.required("rules")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("scope", scope)
    writer.required("rules", rules)
  }
}
