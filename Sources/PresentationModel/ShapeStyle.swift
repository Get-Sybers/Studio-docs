public import WireFormat

/// The type `stylesheet.shape-style` of the format.
public struct ShapeStyle: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = PresentationModelFormat.table.object(named: "ShapeStyle")

  /// The `name` member.
  public var name: String?
  /// The `properties` member; kept out of line, so the value stays small.
  public var properties: Indirect<ShapeProperties>
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(name: String? = nil, properties: ShapeProperties) {
    self.name = name
    self.properties = Indirect(properties)
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    name = try reader.optional("name")
    properties = try reader.required("properties")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("name", name)
    writer.required("properties", properties)
  }
}
