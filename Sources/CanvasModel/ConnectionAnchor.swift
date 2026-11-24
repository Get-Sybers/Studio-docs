public import WireFormat

/// The type `connection-line.end.anchor` of the format.
public struct ConnectionAnchor: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = CanvasModelFormat.table.object(named: "ConnectionAnchor")

  /// The `object_id` member.
  public var objectId: String
  /// The `magnet` member.
  public var magnet: AnchorMagnet?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(objectId: String, magnet: AnchorMagnet? = nil) {
    self.objectId = objectId
    self.magnet = magnet
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    objectId = try reader.required("object_id")
    magnet = try reader.optional("magnet")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("object_id", objectId)
    writer.optional("magnet", magnet)
  }
}
