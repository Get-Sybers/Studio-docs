public import WireFormat

/// A label of text, such as a bullet.
public struct ListStringLabel: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TextFormat.table.object(named: "ListStringLabel")

  /// The text.
  public var string: String
  /// The size as a multiple of the text size; 1 when omitted.
  public var scale: Double?
  /// How far the label is raised, in points; 0 when omitted.
  public var offset: Double?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a text label; a member left out is absent from the JSON.
  public init(string: String, scale: Double? = nil, offset: Double? = nil) {
    self.string = string
    self.scale = scale
    self.offset = offset
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    string = try reader.required("string")
    scale = try reader.optional("scale")
    offset = try reader.optional("offset")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("string", string)
    writer.optional("scale", scale)
    writer.optional("offset", offset)
  }
}
