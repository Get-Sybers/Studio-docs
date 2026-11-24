public import Appearance
public import DocumentPackage
public import TextModel
public import WireFormat

/// A small body for a document of text: a title, the text styles, and sections in order.
///
/// It is the library's own type, not one of Apple's format; a client with other needs defines its own body.
public struct TextDocumentBody: WireObject, DocumentBody {
  /// The facts of the type, from the format table.
  public static let schema = TextDocumentFormat.table.object(named: "TextDocumentBody")

  /// The schemas of this body's two types and of the types of the format.
  public static var schemas: SchemaRegistry { .textDocument }

  /// The title of the document.
  public var title: TextBody?
  /// The named text styles that the text of the document adopts.
  public var stylesheet: Stylesheet?
  /// The sections, in reading order.
  public var sections: [TextSection]
  /// The size of a page, in points, for a document that is laid out as a book; a member of version 1.1.
  public var pageSize: SizeValue?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a body.
  public init(
    title: TextBody? = nil, stylesheet: Stylesheet? = nil, sections: [TextSection] = [], pageSize: SizeValue? = nil
  ) {
    self.title = title
    self.stylesheet = stylesheet
    self.sections = sections
    self.pageSize = pageSize
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    title = try reader.optional("title")
    stylesheet = try reader.optional("stylesheet")
    sections = try reader.required("sections")
    pageSize = try reader.optional("page_size")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("title", title)
    writer.optional("stylesheet", stylesheet)
    writer.required("sections", sections)
    writer.optional("page_size", pageSize)
  }

  /// The whole text, a line feed between paragraphs and between a heading and its section.
  public var plainText: String {
    let parts = [title?.plainText] + sections.flatMap { [$0.heading?.plainText, $0.text.plainText] }
    return parts.compactMap { $0 }.joined(separator: "\n")
  }
}
