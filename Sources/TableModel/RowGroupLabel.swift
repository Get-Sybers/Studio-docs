public import WireFormat

/// The type `table.row.group-label` of the format.
public struct RowGroupLabel: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "RowGroupLabel")

  /// The `grouping_column_identifier` member.
  public var groupingColumnIdentifier: String
  /// The `group_value` member.
  public var groupValue: String
  /// The `is_collapsed` member; false when omitted.
  public var isCollapsed: Bool?
  /// The `nesting_level` member; 0 when omitted.
  public var nestingLevel: Int?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(groupingColumnIdentifier: String, groupValue: String, isCollapsed: Bool? = nil, nestingLevel: Int? = nil)
  {
    self.groupingColumnIdentifier = groupingColumnIdentifier
    self.groupValue = groupValue
    self.isCollapsed = isCollapsed
    self.nestingLevel = nestingLevel
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    groupingColumnIdentifier = try reader.required("grouping_column_identifier")
    groupValue = try reader.required("group_value")
    isCollapsed = try reader.optional("is_collapsed")
    nestingLevel = try reader.optional("nesting_level")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("grouping_column_identifier", groupingColumnIdentifier)
    writer.required("group_value", groupValue)
    writer.optional("is_collapsed", isCollapsed)
    writer.optional("nesting_level", nestingLevel)
  }
}
