public import Appearance
public import CanvasCommon
public import ResourceReferences
public import WireFormat

/// The type `image` of the format.
public struct Image: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = CanvasModelFormat.table.object(named: "Image")

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
  /// The `resource` member.
  public var resource: ResourceReference
  /// The `mask` member; kept out of line, so the value stays small.
  public var mask: Indirect<ImageMask>?
  /// The `instant_alpha_path` member.
  public var instantAlphaPath: InstantAlphaPath?
  /// The `stroke` member.
  public var stroke: Stroke?
  /// The `opacity` member; 1 when omitted.
  public var opacity: Double?
  /// The `shadow` member; omitted, it is inherited, and `.cleared` writes `null`.
  public var shadow: Inheritable<Shadow>
  /// The `reflection` member.
  public var reflection: Reflection?
  /// The `is_placeholder` member; false when omitted.
  public var isPlaceholder: Bool?
  /// The `was_media_replaced` member; false when omitted.
  public var wasMediaReplaced: Bool?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    geometry: Geometry? = nil, aspectRatioLocked: Bool? = nil, description: String? = nil, title: Label? = nil,
    titleIsPositionedOnTop: Bool? = nil, caption: Label? = nil, resource: ResourceReference, mask: ImageMask? = nil,
    instantAlphaPath: InstantAlphaPath? = nil, stroke: Stroke? = nil, opacity: Double? = nil,
    shadow: Inheritable<Shadow> = .inherited, reflection: Reflection? = nil, isPlaceholder: Bool? = nil,
    wasMediaReplaced: Bool? = nil
  ) {
    self.geometry = geometry
    self.aspectRatioLocked = aspectRatioLocked
    self.description = description
    self.title = title.map(Indirect.init)
    self.titleIsPositionedOnTop = titleIsPositionedOnTop
    self.caption = caption.map(Indirect.init)
    self.resource = resource
    self.mask = mask.map(Indirect.init)
    self.instantAlphaPath = instantAlphaPath
    self.stroke = stroke
    self.opacity = opacity
    self.shadow = shadow
    self.reflection = reflection
    self.isPlaceholder = isPlaceholder
    self.wasMediaReplaced = wasMediaReplaced
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    geometry = try reader.optional("geometry")
    aspectRatioLocked = try reader.optional("aspect_ratio_locked")
    description = try reader.optional("description")
    title = try reader.optional("title")
    titleIsPositionedOnTop = try reader.optional("title_is_positioned_on_top")
    caption = try reader.optional("caption")
    resource = try reader.required("resource")
    mask = try reader.optional("mask")
    instantAlphaPath = try reader.optional("instant_alpha_path")
    stroke = try reader.optional("stroke")
    opacity = try reader.optional("opacity")
    shadow = try reader.inheritable("shadow")
    reflection = try reader.optional("reflection")
    isPlaceholder = try reader.optional("is_placeholder")
    wasMediaReplaced = try reader.optional("was_media_replaced")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("geometry", geometry)
    writer.optional("aspect_ratio_locked", aspectRatioLocked)
    writer.optional("description", description)
    writer.optional("title", title)
    writer.optional("title_is_positioned_on_top", titleIsPositionedOnTop)
    writer.optional("caption", caption)
    writer.required("resource", resource)
    writer.optional("mask", mask)
    writer.optional("instant_alpha_path", instantAlphaPath)
    writer.optional("stroke", stroke)
    writer.optional("opacity", opacity)
    writer.inheritable("shadow", shadow)
    writer.optional("reflection", reflection)
    writer.optional("is_placeholder", isPlaceholder)
    writer.optional("was_media_replaced", wasMediaReplaced)
  }
}
