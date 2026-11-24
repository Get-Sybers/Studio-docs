public import Appearance
public import CanvasCommon
public import WireFormat

/// The type `stylesheet.media-style.media-properties` of the format.
public struct MediaProperties: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = PresentationModelFormat.table.object(named: "MediaProperties")

  /// The `stroke` member; omitted, it is inherited, and `.cleared` writes `null`.
  public var stroke: Inheritable<Stroke>
  /// The `opacity` member; omitted, it is inherited, and `.cleared` writes `null`.
  public var opacity: Inheritable<Double>
  /// The `reflection` member; omitted, it is inherited, and `.cleared` writes `null`.
  public var reflection: Inheritable<Reflection>
  /// The `shadow` member; omitted, it is inherited, and `.cleared` writes `null`.
  public var shadow: Inheritable<Shadow>
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    stroke: Inheritable<Stroke> = .inherited, opacity: Inheritable<Double> = .inherited,
    reflection: Inheritable<Reflection> = .inherited, shadow: Inheritable<Shadow> = .inherited
  ) {
    self.stroke = stroke
    self.opacity = opacity
    self.reflection = reflection
    self.shadow = shadow
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    stroke = try reader.inheritable("stroke")
    opacity = try reader.inheritable("opacity")
    reflection = try reader.inheritable("reflection")
    shadow = try reader.inheritable("shadow")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.inheritable("stroke", stroke)
    writer.inheritable("opacity", opacity)
    writer.inheritable("reflection", reflection)
    writer.inheritable("shadow", shadow)
  }
}
