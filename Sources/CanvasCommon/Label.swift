public import TextModel
public import WireFormat

/// The type `label` of the format.
public struct Label: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = CanvasCommonFormat.table.object(named: "Label")

  /// The `layout_properties` member.
  public var layoutProperties: TextLayoutProperties?
  /// The `paragraph_properties` member; kept out of line, so the value stays small.
  public var paragraphProperties: Indirect<ParagraphProperties>?
  /// The `text` member.
  public var text: TextBody?
  /// The `is_visible` member; true when omitted.
  public var isVisible: Bool?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    layoutProperties: TextLayoutProperties? = nil, paragraphProperties: ParagraphProperties? = nil,
    text: TextBody? = nil, isVisible: Bool? = nil
  ) {
    self.layoutProperties = layoutProperties
    self.paragraphProperties = paragraphProperties.map(Indirect.init)
    self.text = text
    self.isVisible = isVisible
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    layoutProperties = try reader.optional("layout_properties")
    paragraphProperties = try reader.optional("paragraph_properties")
    text = try reader.optional("text")
    isVisible = try reader.optional("is_visible")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("layout_properties", layoutProperties)
    writer.optional("paragraph_properties", paragraphProperties)
    writer.optional("text", text)
    writer.optional("is_visible", isVisible)
  }
}
