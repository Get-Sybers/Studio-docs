public import WireFormat

/// One colour of a gradient and its place along it.
public struct GradientStop: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = AppearanceFormat.table.object(named: "GradientStop")

  /// The colour.
  public var color: ColorValue
  /// The place of the stop, from 0 at the start to 1 at the end.
  public var fraction: Double
  /// Where between this stop and the next the two colours blend evenly; 0.5 when omitted.
  public var inflection: Double?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a stop; a member left out is absent from the JSON.
  public init(color: ColorValue, fraction: Double, inflection: Double? = nil) {
    self.color = color
    self.fraction = fraction
    self.inflection = inflection
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    color = try reader.required("color")
    fraction = try reader.required("fraction")
    inflection = try reader.optional("inflection")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("color", color)
    writer.required("fraction", fraction)
    writer.optional("inflection", inflection)
  }
}
