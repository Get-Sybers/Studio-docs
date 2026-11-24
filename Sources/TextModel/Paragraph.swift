public import WireFormat

/// A paragraph: its properties, its place in a list, and its contents in order.
public struct Paragraph: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TextFormat.table.object(named: "Paragraph")

  /// The paragraph properties, written here or adopted from a preset.
  public var style: ParagraphProperties?
  /// The list properties; when nil, the list style in effect before this paragraph goes on.
  public var listStyle: ListProperties?
  /// The number at which the numbering restarts; nil or 0 goes on from the item before.
  public var listStart: Int?
  /// The level in the list, from 0 at the top to 8; 0 when omitted.
  public var listLevel: Int?
  /// The direction, used when the paragraph style leaves it natural.
  public var writingDirection: WritingDirection?
  /// The runs, links and inline objects, in order; omitted for an empty paragraph.
  public var contents: [ParagraphContent]?
  /// The break that ends the paragraph; an ordinary one when omitted.
  public var breakType: ParagraphBreak?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a paragraph; a member left out is absent from the JSON.
  public init(
    style: ParagraphProperties? = nil, listStyle: ListProperties? = nil, listStart: Int? = nil, listLevel: Int? = nil,
    writingDirection: WritingDirection? = nil, contents: [ParagraphContent]? = nil, breakType: ParagraphBreak? = nil
  ) {
    self.style = style
    self.listStyle = listStyle
    self.listStart = listStart
    self.listLevel = listLevel
    self.writingDirection = writingDirection
    self.contents = contents
    self.breakType = breakType
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    style = try reader.optional("style")
    listStyle = try reader.optional("list_style")
    listStart = try reader.optional("list_start")
    listLevel = try reader.optional("list_level")
    writingDirection = try reader.optional("writing_direction")
    contents = try reader.optional("contents")
    breakType = try reader.optional("break_type")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("style", style)
    writer.optional("list_style", listStyle)
    writer.optional("list_start", listStart)
    writer.optional("list_level", listLevel)
    writer.optional("writing_direction", writingDirection)
    writer.optional("contents", contents)
    writer.optional("break_type", breakType)
  }
}
