public import WireFormat

/// The geometry of a gradient that runs along a line.
public struct LinearFlavor: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = AppearanceFormat.table.object(named: "LinearFlavor")

  /// The direction in degrees, anticlockwise from left to right; the fallback when the three points below are given.
  public var angle: Double
  /// Where the line starts; read only together with the two members below. A member of version 1.1.
  public var startPoint: PositionValue?
  /// Where the line ends. A member of version 1.1.
  public var endPoint: PositionValue?
  /// The size of the rectangle that the two points are measured in. A member of version 1.1.
  public var baseNaturalSize: SizeValue?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates the geometry of a linear gradient; a member left out is absent from the JSON.
  public init(
    angle: Double, startPoint: PositionValue? = nil, endPoint: PositionValue? = nil, baseNaturalSize: SizeValue? = nil
  ) {
    self.angle = angle
    self.startPoint = startPoint
    self.endPoint = endPoint
    self.baseNaturalSize = baseNaturalSize
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    angle = try reader.required("angle")
    startPoint = try reader.optional("start_point")
    endPoint = try reader.optional("end_point")
    baseNaturalSize = try reader.optional("base_natural_size")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("angle", angle)
    writer.optional("start_point", startPoint)
    writer.optional("end_point", endPoint)
    writer.optional("base_natural_size", baseNaturalSize)
  }
}
