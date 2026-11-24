public import WireFormat

/// A paragraph style of a stylesheet; its preset identifier is the name that text refers to it by.
public struct NamedParagraphStyle: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TextFormat.table.object(named: "NamedParagraphStyle")

  /// The name shown for the style.
  public var name: String?
  /// The properties of the style.
  public var properties: ParagraphProperties
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a paragraph style; a member left out is absent from the JSON.
  public init(properties: ParagraphProperties, name: String? = nil) {
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
