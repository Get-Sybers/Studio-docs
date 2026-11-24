public import ResourceReferences
public import WireFormat

/// A label that is an image.
public struct ListImageLabel: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TextFormat.table.object(named: "ListImageLabel")

  /// The height as a fraction of the text height; 1 when omitted.
  public var scale: Double?
  /// How far the image is raised, in points; 0 when omitted.
  public var offset: Double?
  /// The bytes of the image.
  public var resource: ResourceReference
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates an image label; a member left out is absent from the JSON.
  public init(resource: ResourceReference, scale: Double? = nil, offset: Double? = nil) {
    self.scale = scale
    self.offset = offset
    self.resource = resource
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    scale = try reader.optional("scale")
    offset = try reader.optional("offset")
    resource = try reader.required("resource")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("scale", scale)
    writer.optional("offset", offset)
    writer.required("resource", resource)
  }
}
