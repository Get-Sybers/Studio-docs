public import WireFormat

/// A shadow that pools under the lower edge of an object, as if it stood on the ground.
public struct ContactShadow: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = AppearanceFormat.table.object(named: "ContactShadow")

  /// The opacity, from 0 to 1; 1 when omitted.
  public var opacity: Double?
  /// The colour; black when omitted.
  public var color: ColorValue?
  /// The distance from the lower edge to the ground, from -75 to 75 points; 0 when omitted.
  public var offset: Double?
  /// The size of the blur, from 10 to 100; 28 when omitted.
  public var radius: Double?
  /// The sine of the angle of view, which foreshortens the shadow.
  public var height: Double?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a contact shadow; a member left out is absent from the JSON.
  public init(
    opacity: Double? = nil, color: ColorValue? = nil, offset: Double? = nil, radius: Double? = nil,
    height: Double? = nil
  ) {
    self.opacity = opacity
    self.color = color
    self.offset = offset
    self.radius = radius
    self.height = height
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    opacity = try reader.optional("opacity")
    color = try reader.optional("color")
    offset = try reader.optional("offset")
    radius = try reader.optional("radius")
    height = try reader.optional("height")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("opacity", opacity)
    writer.optional("color", color)
    writer.optional("offset", offset)
    writer.optional("radius", radius)
    writer.optional("height", height)
  }
}
