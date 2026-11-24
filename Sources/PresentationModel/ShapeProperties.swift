public import Appearance
public import CanvasCommon
public import TextModel
public import WireFormat

/// The type `stylesheet.shape-style.shape-properties` of the format.
public struct ShapeProperties: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = PresentationModelFormat.table.object(named: "ShapeProperties")

  /// The `stroke` member; omitted, it is inherited, and `.cleared` writes `null`.
  public var stroke: Inheritable<Stroke>
  /// The `opacity` member; omitted, it is inherited, and `.cleared` writes `null`.
  public var opacity: Inheritable<Double>
  /// The `reflection` member; omitted, it is inherited, and `.cleared` writes `null`.
  public var reflection: Inheritable<Reflection>
  /// The `shadow` member; omitted, it is inherited, and `.cleared` writes `null`.
  public var shadow: Inheritable<Shadow>
  /// The `fill` member; omitted, it is inherited, and `.cleared` writes `null`.
  public var fill: Inheritable<Fill>
  /// The `head` member; omitted, it is inherited, and `.cleared` writes `null`.
  public var head: Inheritable<LineEnd>
  /// The `tail` member; omitted, it is inherited, and `.cleared` writes `null`.
  public var tail: Inheritable<LineEnd>
  /// The `layout_properties` member.
  public var layoutProperties: TextLayoutProperties?
  /// The `paragraph_properties` member; kept out of line, so the value stays small.
  public var paragraphProperties: Indirect<ParagraphProperties>?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    stroke: Inheritable<Stroke> = .inherited, opacity: Inheritable<Double> = .inherited,
    reflection: Inheritable<Reflection> = .inherited, shadow: Inheritable<Shadow> = .inherited,
    fill: Inheritable<Fill> = .inherited, head: Inheritable<LineEnd> = .inherited,
    tail: Inheritable<LineEnd> = .inherited, layoutProperties: TextLayoutProperties? = nil,
    paragraphProperties: ParagraphProperties? = nil
  ) {
    self.stroke = stroke
    self.opacity = opacity
    self.reflection = reflection
    self.shadow = shadow
    self.fill = fill
    self.head = head
    self.tail = tail
    self.layoutProperties = layoutProperties
    self.paragraphProperties = paragraphProperties.map(Indirect.init)
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    stroke = try reader.inheritable("stroke")
    opacity = try reader.inheritable("opacity")
    reflection = try reader.inheritable("reflection")
    shadow = try reader.inheritable("shadow")
    fill = try reader.inheritable("fill")
    head = try reader.inheritable("head")
    tail = try reader.inheritable("tail")
    layoutProperties = try reader.optional("layout_properties")
    paragraphProperties = try reader.optional("paragraph_properties")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.inheritable("stroke", stroke)
    writer.inheritable("opacity", opacity)
    writer.inheritable("reflection", reflection)
    writer.inheritable("shadow", shadow)
    writer.inheritable("fill", fill)
    writer.inheritable("head", head)
    writer.inheritable("tail", tail)
    writer.optional("layout_properties", layoutProperties)
    writer.optional("paragraph_properties", paragraphProperties)
  }
}
