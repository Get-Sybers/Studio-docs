public import Appearance
public import CanvasCommon
public import WireFormat

/// The type `connection-line` of the format.
public struct ConnectionLine: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = CanvasModelFormat.table.object(named: "ConnectionLine")

  /// The `geometry` member; kept out of line, so the value stays small.
  public var geometry: Indirect<Geometry>?
  /// The `aspect_ratio_locked` member; false when omitted.
  public var aspectRatioLocked: Bool?
  /// The `description` member.
  public var description: String?
  /// The `line_type` member.
  public var lineType: ConnectionLineKind?
  /// The `tail` member; kept out of line, so the value stays small.
  public var tail: Indirect<ConnectionEnd>
  /// The `head` member; kept out of line, so the value stays small.
  public var head: Indirect<ConnectionEnd>
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
    geometry: Geometry? = nil, aspectRatioLocked: Bool? = nil, description: String? = nil,
    lineType: ConnectionLineKind? = nil, tail: ConnectionEnd, head: ConnectionEnd, stroke: Stroke? = nil,
    opacity: Double? = nil, shadow: Inheritable<Shadow> = .inherited, reflection: Reflection? = nil
  ) {
    self.geometry = geometry.map(Indirect.init)
    self.aspectRatioLocked = aspectRatioLocked
    self.description = description
    self.lineType = lineType
    self.tail = Indirect(tail)
    self.head = Indirect(head)
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
    lineType = try reader.optional("line_type")
    tail = try reader.required("tail")
    head = try reader.required("head")
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
    writer.optional("line_type", lineType)
    writer.required("tail", tail)
    writer.required("head", head)
    writer.optional("stroke", stroke)
    writer.optional("opacity", opacity)
    writer.inheritable("shadow", shadow)
    writer.optional("reflection", reflection)
  }
}
