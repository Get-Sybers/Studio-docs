public import CanvasCommon
public import WireFormat

/// The type `image.mask` of the format.
public struct ImageMask: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = CanvasModelFormat.table.object(named: "ImageMask")

  /// The `geometry` member.
  public var geometry: Geometry?
  /// The `path` member.
  public var path: Path?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(geometry: Geometry? = nil, path: Path? = nil) {
    self.geometry = geometry
    self.path = path
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    geometry = try reader.optional("geometry")
    path = try reader.optional("path")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("geometry", geometry)
    writer.optional("path", path)
  }
}
