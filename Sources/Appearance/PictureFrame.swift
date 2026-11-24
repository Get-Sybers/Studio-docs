public import WireFormat

/// A picture frame drawn around an object.
public struct PictureFrame: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = AppearanceFormat.table.object(named: "PictureFrame")

  /// Which frame.
  public var name: PictureFrameName
  /// The scale of the frame's artwork, from 10 to 100 per cent; 100 when omitted.
  public var scalePercent: Double?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a picture frame; a member left out is absent from the JSON.
  public init(name: PictureFrameName, scalePercent: Double? = nil) {
    self.name = name
    self.scalePercent = scalePercent
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    name = try reader.required("name")
    scalePercent = try reader.optional("scale_percent")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("name", name)
    writer.optional("scale_percent", scalePercent)
  }
}
