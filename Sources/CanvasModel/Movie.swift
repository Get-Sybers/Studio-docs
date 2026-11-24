public import Appearance
public import CanvasCommon
public import ResourceReferences
public import WireFormat

/// The type `movie` of the format.
public struct Movie: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = CanvasModelFormat.table.object(named: "Movie")

  /// The `geometry` member; kept out of line, so the value stays small.
  public var geometry: Indirect<Geometry>?
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
  /// The `poster_image` member.
  public var posterImage: ResourceReference?
  /// The `poster_time` member.
  public var posterTime: DurationValue?
  /// The `playback_options` member; kept out of line, so the value stays small.
  public var playbackOptions: Indirect<PlaybackOptions>
  /// The `stroke` member.
  public var stroke: Stroke?
  /// The `opacity` member; 1 when omitted.
  public var opacity: Double?
  /// The `shadow` member; omitted, it is inherited, and `.cleared` writes `null`.
  public var shadow: Inheritable<Shadow>
  /// The `reflection` member; kept out of line, so the value stays small.
  public var reflection: Indirect<Reflection>?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    geometry: Geometry? = nil, aspectRatioLocked: Bool? = nil, description: String? = nil, title: Label? = nil,
    titleIsPositionedOnTop: Bool? = nil, caption: Label? = nil, resource: ResourceReference,
    posterImage: ResourceReference? = nil, posterTime: DurationValue? = nil, playbackOptions: PlaybackOptions,
    stroke: Stroke? = nil, opacity: Double? = nil, shadow: Inheritable<Shadow> = .inherited,
    reflection: Reflection? = nil
  ) {
    self.geometry = geometry.map(Indirect.init)
    self.aspectRatioLocked = aspectRatioLocked
    self.description = description
    self.title = title.map(Indirect.init)
    self.titleIsPositionedOnTop = titleIsPositionedOnTop
    self.caption = caption.map(Indirect.init)
    self.resource = resource
    self.posterImage = posterImage
    self.posterTime = posterTime
    self.playbackOptions = Indirect(playbackOptions)
    self.stroke = stroke
    self.opacity = opacity
    self.shadow = shadow
    self.reflection = reflection.map(Indirect.init)
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
    posterImage = try reader.optional("poster_image")
    posterTime = try reader.optional("poster_time")
    playbackOptions = try reader.required("playback_options")
    stroke = try reader.optional("stroke")
    opacity = try reader.optional("opacity")
    shadow = try reader.inheritable("shadow")
    reflection = try reader.optional("reflection")
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
    writer.optional("poster_image", posterImage)
    writer.optional("poster_time", posterTime)
    writer.required("playback_options", playbackOptions)
    writer.optional("stroke", stroke)
    writer.optional("opacity", opacity)
    writer.inheritable("shadow", shadow)
    writer.optional("reflection", reflection)
  }
}
