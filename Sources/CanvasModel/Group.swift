public import CanvasCommon
public import WireFormat

/// The type `group` of the format.
public struct Group: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = CanvasModelFormat.table.object(named: "Group")

  /// The `geometry` member.
  public var geometry: Geometry?
  /// The `aspect_ratio_locked` member; true when omitted.
  public var aspectRatioLocked: Bool?
  /// The `description` member.
  public var description: String?
  /// The `title` member; kept out of line, so the value stays small.
  public var title: Indirect<Label>?
  /// The `title_is_positioned_on_top` member; true when omitted.
  public var titleIsPositionedOnTop: Bool?
  /// The `caption` member; kept out of line, so the value stays small.
  public var caption: Indirect<Label>?
  /// The `children` member.
  public var children: [CanvasObject]
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    geometry: Geometry? = nil, aspectRatioLocked: Bool? = nil, description: String? = nil, title: Label? = nil,
    titleIsPositionedOnTop: Bool? = nil, caption: Label? = nil, children: [CanvasObject]
  ) {
    self.geometry = geometry
    self.aspectRatioLocked = aspectRatioLocked
    self.description = description
    self.title = title.map(Indirect.init)
    self.titleIsPositionedOnTop = titleIsPositionedOnTop
    self.caption = caption.map(Indirect.init)
    self.children = children
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    geometry = try reader.optional("geometry")
    aspectRatioLocked = try reader.optional("aspect_ratio_locked")
    description = try reader.optional("description")
    title = try reader.optional("title")
    titleIsPositionedOnTop = try reader.optional("title_is_positioned_on_top")
    caption = try reader.optional("caption")
    children = try reader.required("children")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("geometry", geometry)
    writer.optional("aspect_ratio_locked", aspectRatioLocked)
    writer.optional("description", description)
    writer.optional("title", title)
    writer.optional("title_is_positioned_on_top", titleIsPositionedOnTop)
    writer.optional("caption", caption)
    writer.required("children", children)
  }
}
