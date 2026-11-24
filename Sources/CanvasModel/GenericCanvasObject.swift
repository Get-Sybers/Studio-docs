public import CanvasCommon
public import WireFormat

/// The type `canvas-object-generic` of the format.
public struct GenericCanvasObject: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = CanvasModelFormat.table.object(named: "GenericCanvasObject")

  /// The `geometry` member.
  public var geometry: Geometry?
  /// The `aspect_ratio_locked` member; false when omitted.
  public var aspectRatioLocked: Bool?
  /// The `description` member.
  public var description: String?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(geometry: Geometry? = nil, aspectRatioLocked: Bool? = nil, description: String? = nil) {
    self.geometry = geometry
    self.aspectRatioLocked = aspectRatioLocked
    self.description = description
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    geometry = try reader.optional("geometry")
    aspectRatioLocked = try reader.optional("aspect_ratio_locked")
    description = try reader.optional("description")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("geometry", geometry)
    writer.optional("aspect_ratio_locked", aspectRatioLocked)
    writer.optional("description", description)
  }
}
