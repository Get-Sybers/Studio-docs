public import Appearance
public import WireFormat

/// The type `geometry` of the format.
public struct Geometry: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = CanvasCommonFormat.table.object(named: "Geometry")

  /// The `position` member.
  public var position: PositionValue
  /// The `size` member.
  public var size: SizeValue
  /// The `angle` member; 0 when omitted.
  public var angle: Double?
  /// The `flip_horizontally` member; false when omitted.
  public var flipHorizontally: Bool?
  /// The `width_valid` member; true when omitted.
  public var widthValid: Bool?
  /// The `height_valid` member; true when omitted.
  public var heightValid: Bool?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    position: PositionValue, size: SizeValue, angle: Double? = nil, flipHorizontally: Bool? = nil,
    widthValid: Bool? = nil, heightValid: Bool? = nil
  ) {
    self.position = position
    self.size = size
    self.angle = angle
    self.flipHorizontally = flipHorizontally
    self.widthValid = widthValid
    self.heightValid = heightValid
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    position = try reader.required("position")
    size = try reader.required("size")
    angle = try reader.optional("angle")
    flipHorizontally = try reader.optional("flip_horizontally")
    widthValid = try reader.optional("width_valid")
    heightValid = try reader.optional("height_valid")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("position", position)
    writer.required("size", size)
    writer.optional("angle", angle)
    writer.optional("flip_horizontally", flipHorizontally)
    writer.optional("width_valid", widthValid)
    writer.optional("height_valid", heightValid)
  }
}
