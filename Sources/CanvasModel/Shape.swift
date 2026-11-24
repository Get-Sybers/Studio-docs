public import Appearance
public import CanvasCommon
public import TextModel
public import WireFormat

/// The type `shape` of the format.
public struct Shape: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = CanvasModelFormat.table.object(named: "Shape")

  /// The `geometry` member; kept out of line, so the value stays small.
  public var geometry: Indirect<Geometry>?
  /// The `aspect_ratio_locked` member; false when omitted.
  public var aspectRatioLocked: Bool?
  /// The `description` member.
  public var description: String?
  /// The `title` member; kept out of line, so the value stays small.
  public var title: Indirect<Label>?
  /// The `title_is_positioned_on_top` member; true when omitted.
  public var titleIsPositionedOnTop: Bool?
  /// The `caption` member; kept out of line, so the value stays small.
  public var caption: Indirect<Label>?
  /// The `path` member.
  public var path: Path?
  /// The `tail` member; "none" when omitted.
  public var tail: LineEnd?
  /// The `head` member; "none" when omitted.
  public var head: LineEnd?
  /// The `fill` member.
  public var fill: Fill?
  /// The `stroke` member.
  public var stroke: Stroke?
  /// The `opacity` member; 1 when omitted.
  public var opacity: Double?
  /// The `shadow` member; omitted, it is inherited, and `.cleared` writes `null`.
  public var shadow: Inheritable<Shadow>
  /// The `reflection` member; kept out of line, so the value stays small.
  public var reflection: Indirect<Reflection>?
  /// The `layout_properties` member; kept out of line, so the value stays small.
  public var layoutProperties: Indirect<TextLayoutProperties>?
  /// The `paragraph_properties` member; kept out of line, so the value stays small.
  public var paragraphProperties: Indirect<ParagraphProperties>?
  /// The `text` member.
  public var text: TextBody?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    geometry: Geometry? = nil, aspectRatioLocked: Bool? = nil, description: String? = nil, title: Label? = nil,
    titleIsPositionedOnTop: Bool? = nil, caption: Label? = nil, path: Path? = nil, tail: LineEnd? = nil,
    head: LineEnd? = nil, fill: Fill? = nil, stroke: Stroke? = nil, opacity: Double? = nil,
    shadow: Inheritable<Shadow> = .inherited, reflection: Reflection? = nil,
    layoutProperties: TextLayoutProperties? = nil, paragraphProperties: ParagraphProperties? = nil,
    text: TextBody? = nil
  ) {
    self.geometry = geometry.map(Indirect.init)
    self.aspectRatioLocked = aspectRatioLocked
    self.description = description
    self.title = title.map(Indirect.init)
    self.titleIsPositionedOnTop = titleIsPositionedOnTop
    self.caption = caption.map(Indirect.init)
    self.path = path
    self.tail = tail
    self.head = head
    self.fill = fill
    self.stroke = stroke
    self.opacity = opacity
    self.shadow = shadow
    self.reflection = reflection.map(Indirect.init)
    self.layoutProperties = layoutProperties.map(Indirect.init)
    self.paragraphProperties = paragraphProperties.map(Indirect.init)
    self.text = text
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    geometry = try reader.optional("geometry")
    aspectRatioLocked = try reader.optional("aspect_ratio_locked")
    description = try reader.optional("description")
    title = try reader.optional("title")
    titleIsPositionedOnTop = try reader.optional("title_is_positioned_on_top")
    caption = try reader.optional("caption")
    path = try reader.optional("path")
    tail = try reader.optional("tail")
    head = try reader.optional("head")
    fill = try reader.optional("fill")
    stroke = try reader.optional("stroke")
    opacity = try reader.optional("opacity")
    shadow = try reader.inheritable("shadow")
    reflection = try reader.optional("reflection")
    layoutProperties = try reader.optional("layout_properties")
    paragraphProperties = try reader.optional("paragraph_properties")
    text = try reader.optional("text")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("geometry", geometry)
    writer.optional("aspect_ratio_locked", aspectRatioLocked)
    writer.optional("description", description)
    writer.optional("title", title)
    writer.optional("title_is_positioned_on_top", titleIsPositionedOnTop)
    writer.optional("caption", caption)
    writer.optional("path", path)
    writer.optional("tail", tail)
    writer.optional("head", head)
    writer.optional("fill", fill)
    writer.optional("stroke", stroke)
    writer.optional("opacity", opacity)
    writer.inheritable("shadow", shadow)
    writer.optional("reflection", reflection)
    writer.optional("layout_properties", layoutProperties)
    writer.optional("paragraph_properties", paragraphProperties)
    writer.optional("text", text)
  }
}
