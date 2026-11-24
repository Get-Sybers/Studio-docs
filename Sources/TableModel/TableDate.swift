public import WireFormat

/// The type `table.date` of the format.
public struct TableDate: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "TableDate")

  /// The `time_interval_since1970` member.
  public var timeIntervalSince1970: Double
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(timeIntervalSince1970: Double) {
    self.timeIntervalSince1970 = timeIntervalSince1970
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    timeIntervalSince1970 = try reader.required("time_interval_since1970")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("time_interval_since1970", timeIntervalSince1970)
  }
}
