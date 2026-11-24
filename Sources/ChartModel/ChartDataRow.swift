public import WireFormat

/// The type `chart-data.chart-data-row` of the format.
public struct ChartDataRow: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = ChartModelFormat.table.object(named: "ChartDataRow")

  /// The `values` member.
  public var values: [ChartDataValue]
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(values: [ChartDataValue]) {
    self.values = values
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    values = try reader.required("values")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("values", values)
  }
}
