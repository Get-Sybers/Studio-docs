public import WireFormat

/// The type `table.transformation-info` of the format.
public struct TransformationInfo: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "TransformationInfo")

  /// The `base_table` member; kept out of line, so the value stays small.
  public var baseTable: Indirect<Table>?
  /// The `structure` member.
  public var structure: TransformationStructure?
  /// The `filter_set` member.
  public var filterSet: FilterSet?
  /// The `sort` member.
  public var sort: TableSort?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    baseTable: Table? = nil, structure: TransformationStructure? = nil, filterSet: FilterSet? = nil,
    sort: TableSort? = nil
  ) {
    self.baseTable = baseTable.map(Indirect.init)
    self.structure = structure
    self.filterSet = filterSet
    self.sort = sort
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    baseTable = try reader.optional("base_table")
    structure = try reader.optional("structure")
    filterSet = try reader.optional("filter_set")
    sort = try reader.optional("sort")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("base_table", baseTable)
    writer.optional("structure", structure)
    writer.optional("filter_set", filterSet)
    writer.optional("sort", sort)
  }
}
