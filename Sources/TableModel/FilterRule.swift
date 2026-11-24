public import WireFormat

/// The type `table.filter-set.filter.rule` of the format.
public struct FilterRule: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "FilterRule")

  /// The `predicate` member.
  public var predicate: TablePredicate
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(predicate: TablePredicate) {
    self.predicate = predicate
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    predicate = try reader.required("predicate")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("predicate", predicate)
  }
}
