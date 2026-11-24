public import WireFormat

/// The named styles of a document; the library models those of text and keeps the rest.
public struct Stylesheet: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TextFormat.table.object(named: "Stylesheet")

  /// The character styles.
  public var characterStyles: [NamedCharacterStyle]?
  /// The paragraph styles.
  public var paragraphStyles: [NamedParagraphStyle]?
  /// The list styles.
  public var listStyles: [NamedListStyle]?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a stylesheet; a member left out is absent from the JSON.
  public init(
    characterStyles: [NamedCharacterStyle]? = nil, paragraphStyles: [NamedParagraphStyle]? = nil,
    listStyles: [NamedListStyle]? = nil
  ) {
    self.characterStyles = characterStyles
    self.paragraphStyles = paragraphStyles
    self.listStyles = listStyles
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    characterStyles = try reader.optional("character_styles")
    paragraphStyles = try reader.optional("paragraph_styles")
    listStyles = try reader.optional("list_styles")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("character_styles", characterStyles)
    writer.optional("paragraph_styles", paragraphStyles)
    writer.optional("list_styles", listStyles)
  }
}
