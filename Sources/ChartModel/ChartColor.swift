public import Appearance
public import WireFormat

/// The type `chart-common.chart-color` of the format.
public struct ChartColor: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = ChartModelFormat.table.object(named: "ChartColor")

  /// The `fill` member.
  public var fill: Fill?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(fill: Fill? = nil) {
    self.fill = fill
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    fill = try reader.optional("fill")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("fill", fill)
  }
}
