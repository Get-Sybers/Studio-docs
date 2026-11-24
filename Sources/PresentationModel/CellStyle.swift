public import TableModel
public import WireFormat

/// The type `stylesheet.table-style-collection.cell-style` of the format.
public struct CellStyle: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = PresentationModelFormat.table.object(named: "CellStyle")

  /// The `name` member.
  public var name: String?
  /// The `properties` member.
  public var properties: CellProperties
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(name: String? = nil, properties: CellProperties) {
    self.name = name
    self.properties = properties
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
