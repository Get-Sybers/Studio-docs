public import TextModel
public import WireFormat

/// The type `slide` of the format.
public struct Slide: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = PresentationModelFormat.table.object(named: "Slide")

  /// The `layout` member.
  public var layout: String?
  /// The `contents` member.
  public var contents: [SlideObject]?
  /// The `background` member; omitted, it is inherited, and `.cleared` writes `null`.
  public var background: Inheritable<SlideBackground>
  /// The `depth` member.
  public var depth: Int?
  /// The `note` member.
  public var note: TextBody?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    layout: String? = nil, contents: [SlideObject]? = nil, background: Inheritable<SlideBackground> = .inherited,
    depth: Int? = nil, note: TextBody? = nil
  ) {
    self.layout = layout
    self.contents = contents
    self.background = background
    self.depth = depth
    self.note = note
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    layout = try reader.optional("layout")
    contents = try reader.optional("contents")
    background = try reader.inheritable("background")
    depth = try reader.optional("depth")
    note = try reader.optional("note")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("layout", layout)
    writer.optional("contents", contents)
    writer.inheritable("background", background)
    writer.optional("depth", depth)
    writer.optional("note", note)
  }
}
