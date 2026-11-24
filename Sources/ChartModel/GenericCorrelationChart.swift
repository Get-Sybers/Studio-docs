public import WireFormat

/// The type `correlation-chart-generic` of the format.
public struct GenericCorrelationChart: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = ChartModelFormat.table.object(named: "GenericCorrelationChart")

  /// The `value_axis_x` member; kept out of line, so the value stays small.
  public var valueAxisX: Indirect<ChartValueAxis>?
  /// The `value_axis_y` member; kept out of line, so the value stays small.
  public var valueAxisY: Indirect<ChartValueAxis>?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(valueAxisX: ChartValueAxis? = nil, valueAxisY: ChartValueAxis? = nil) {
    self.valueAxisX = valueAxisX.map(Indirect.init)
    self.valueAxisY = valueAxisY.map(Indirect.init)
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    valueAxisX = try reader.optional("value_axis_x")
    valueAxisY = try reader.optional("value_axis_y")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("value_axis_x", valueAxisX)
    writer.optional("value_axis_y", valueAxisY)
  }
}
