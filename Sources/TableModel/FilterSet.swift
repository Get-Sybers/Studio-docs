public import WireFormat

/// The type `table.filter-set` of the format.
public struct FilterSet: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "FilterSet")

  /// The `is_enabled` member; true when omitted.
  public var isEnabled: Bool?
  /// The `combine_mode` member; "and" when omitted.
  public var combineMode: FilterCombination?
  /// The `filters` member.
  public var filters: [TableFilter]
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(isEnabled: Bool? = nil, combineMode: FilterCombination? = nil, filters: [TableFilter]) {
    self.isEnabled = isEnabled
    self.combineMode = combineMode
    self.filters = filters
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    isEnabled = try reader.optional("is_enabled")
    combineMode = try reader.optional("combine_mode")
    filters = try reader.required("filters")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("is_enabled", isEnabled)
    writer.optional("combine_mode", combineMode)
    writer.required("filters", filters)
  }
}
