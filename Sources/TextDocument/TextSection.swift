public import TextModel
public import WireFormat

/// One section of a text document: a heading and a body of text.
public struct TextSection: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TextDocumentFormat.table.object(named: "TextSection")

  /// The heading; nil for a section that has none.
  public var heading: TextBody?
  /// The text of the section.
  public var text: TextBody
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a section.
  public init(heading: TextBody? = nil, text: TextBody) {
    self.heading = heading
    self.text = text
  }

  /// Creates a section from plain text: a heading and one run for each paragraph.
  public init(heading: String, paragraphs: [String]) {
    self.init(heading: .string(heading), text: TextBody(paragraphs: paragraphs))
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    heading = try reader.optional("heading")
    text = try reader.required("text")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("heading", heading)
    writer.required("text", text)
  }
}
