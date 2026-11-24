public import Appearance
public import WireFormat

/// The type `image.instant-alpha-path` of the format.
public struct InstantAlphaPath: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = CanvasModelFormat.table.object(named: "InstantAlphaPath")

  /// The `path` member.
  public var path: String
  /// The `size` member.
  public var size: SizeValue?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(path: String, size: SizeValue? = nil) {
    self.path = path
    self.size = size
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    path = try reader.required("path")
    size = try reader.optional("size")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("path", path)
    writer.optional("size", size)
  }
}
