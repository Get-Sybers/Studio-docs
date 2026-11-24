public import ResourceReferences
public import WireFormat

/// An image that fills an area.
public struct ImageFill: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = AppearanceFormat.table.object(named: "ImageFill")

  /// The bytes of the image.
  public var resource: ResourceReference
  /// How the image covers the area.
  public var technique: ImageFillTechnique
  /// The scale of the image, from 10 to 200 per cent, for the techniques that keep its own size; 100 when omitted.
  public var scalePercent: Double?
  /// A colour laid over the image.
  public var tintColor: ColorValue?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates an image fill; a member left out is absent from the JSON.
  public init(
    resource: ResourceReference, technique: ImageFillTechnique, scalePercent: Double? = nil,
    tintColor: ColorValue? = nil
  ) {
    self.resource = resource
    self.technique = technique
    self.scalePercent = scalePercent
    self.tintColor = tintColor
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    resource = try reader.required("resource")
    technique = try reader.required("technique")
    scalePercent = try reader.optional("scale_percent")
    tintColor = try reader.optional("tint_color")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("resource", resource)
    writer.required("technique", technique)
    writer.optional("scale_percent", scalePercent)
    writer.optional("tint_color", tintColor)
  }
}
