public import WireFormat

/// A colour as red, green, blue and alpha, each from 0 to 1.
public struct RGBAColor: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = AppearanceFormat.table.object(named: "RGBAColor")

  /// The red component; 0 when omitted.
  public var red: Double?
  /// The green component; 0 when omitted.
  public var green: Double?
  /// The blue component; 0 when omitted.
  public var blue: Double?
  /// The opacity; 1 when omitted.
  public var alpha: Double?
  /// The colour space of the components; sRGB when omitted.
  public var colorSpace: RGBColorSpace?
  /// How many times brighter than standard white the colour reaches, from 1 to 16; a member of version 1.1.
  public var headroom: Double?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a colour; a member left out is absent from the JSON.
  public init(
    red: Double? = nil, green: Double? = nil, blue: Double? = nil, alpha: Double? = nil,
    colorSpace: RGBColorSpace? = nil, headroom: Double? = nil
  ) {
    self.red = red
    self.green = green
    self.blue = blue
    self.alpha = alpha
    self.colorSpace = colorSpace
    self.headroom = headroom
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    red = try reader.optional("red")
    green = try reader.optional("green")
    blue = try reader.optional("blue")
    alpha = try reader.optional("alpha")
    colorSpace = try reader.optional("color_space")
    headroom = try reader.optional("headroom")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("red", red)
    writer.optional("green", green)
    writer.optional("blue", blue)
    writer.optional("alpha", alpha)
    writer.optional("color_space", colorSpace)
    writer.optional("headroom", headroom)
  }
}
