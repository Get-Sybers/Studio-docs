public import WireFormat

/// The type `path.bezier-path` of the format.
public struct BezierPath: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = CanvasModelFormat.table.object(named: "BezierPath")

  /// The `path` member.
  public var path: String
  /// The `space` member.
  public var space: Rect?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(path: String, space: Rect? = nil) {
    self.path = path
    self.space = space
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    path = try reader.required("path")
    space = try reader.optional("space")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("path", path)
    writer.optional("space", space)
  }
}
