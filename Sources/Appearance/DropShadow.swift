public import WireFormat

/// A blurred copy of an object's outline, set off in one direction.
public struct DropShadow: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = AppearanceFormat.table.object(named: "DropShadow")

  /// The direction of the offset in degrees, anticlockwise; 270 when omitted.
  public var angle: Double?
  /// The opacity, from 0 to 1; 1 when omitted.
  public var opacity: Double?
  /// The colour; black when omitted.
  public var color: ColorValue?
  /// The distance of the offset, from 0 to 50 points; 2 when omitted.
  public var offset: Double?
  /// The size of the blur, from 0 to 100; 5 when omitted.
  public var radius: Double?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a drop shadow; a member left out is absent from the JSON.
  public init(
    angle: Double? = nil, opacity: Double? = nil, color: ColorValue? = nil, offset: Double? = nil, radius: Double? = nil
  ) {
    self.angle = angle
    self.opacity = opacity
    self.color = color
    self.offset = offset
    self.radius = radius
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    angle = try reader.optional("angle")
    opacity = try reader.optional("opacity")
    color = try reader.optional("color")
    offset = try reader.optional("offset")
    radius = try reader.optional("radius")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("angle", angle)
    writer.optional("opacity", opacity)
    writer.optional("color", color)
    writer.optional("offset", offset)
    writer.optional("radius", radius)
  }
}
