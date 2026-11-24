public import WireFormat

/// The type `table.pivot-rules` of the format.
public struct PivotRules: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "PivotRules")

  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init() {
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
  }
}
