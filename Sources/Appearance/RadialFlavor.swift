public import WireFormat

/// The geometry of a gradient that spreads from a centre.
public struct RadialFlavor: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = AppearanceFormat.table.object(named: "RadialFlavor")

  /// The centre.
  public var startPoint: PositionValue
  /// A point on the outer edge, which fixes the radius.
  public var endPoint: PositionValue
  /// The size of the rectangle that the two points are measured in.
  public var baseNaturalSize: SizeValue
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates the geometry of a radial gradient; a member left out is absent from the JSON.
  public init(startPoint: PositionValue, endPoint: PositionValue, baseNaturalSize: SizeValue) {
    self.startPoint = startPoint
    self.endPoint = endPoint
    self.baseNaturalSize = baseNaturalSize
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    startPoint = try reader.required("start_point")
    endPoint = try reader.required("end_point")
    baseNaturalSize = try reader.required("base_natural_size")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("start_point", startPoint)
    writer.required("end_point", endPoint)
    writer.required("base_natural_size", baseNaturalSize)
  }
}
