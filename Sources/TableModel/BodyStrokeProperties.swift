public import Appearance
public import WireFormat

/// The type `table.visual-properties.body-stroke-properties` of the format.
public struct BodyStrokeProperties: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "BodyStrokeProperties")

  /// The `horizontal_border_stroke` member.
  public var horizontalBorderStroke: Stroke?
  /// The `vertical_border_stroke` member.
  public var verticalBorderStroke: Stroke?
  /// The `horizontal_stroke` member.
  public var horizontalStroke: Stroke?
  /// The `vertical_stroke` member.
  public var verticalStroke: Stroke?
  /// The `border_strokes_visible` member.
  public var borderStrokesVisible: Bool?
  /// The `horizontal_strokes_visible` member.
  public var horizontalStrokesVisible: Bool?
  /// The `vertical_strokes_visible` member.
  public var verticalStrokesVisible: Bool?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    horizontalBorderStroke: Stroke? = nil, verticalBorderStroke: Stroke? = nil, horizontalStroke: Stroke? = nil,
    verticalStroke: Stroke? = nil, borderStrokesVisible: Bool? = nil, horizontalStrokesVisible: Bool? = nil,
    verticalStrokesVisible: Bool? = nil
  ) {
    self.horizontalBorderStroke = horizontalBorderStroke
    self.verticalBorderStroke = verticalBorderStroke
    self.horizontalStroke = horizontalStroke
    self.verticalStroke = verticalStroke
    self.borderStrokesVisible = borderStrokesVisible
    self.horizontalStrokesVisible = horizontalStrokesVisible
    self.verticalStrokesVisible = verticalStrokesVisible
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    horizontalBorderStroke = try reader.optional("horizontal_border_stroke")
    verticalBorderStroke = try reader.optional("vertical_border_stroke")
    horizontalStroke = try reader.optional("horizontal_stroke")
    verticalStroke = try reader.optional("vertical_stroke")
    borderStrokesVisible = try reader.optional("border_strokes_visible")
    horizontalStrokesVisible = try reader.optional("horizontal_strokes_visible")
    verticalStrokesVisible = try reader.optional("vertical_strokes_visible")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("horizontal_border_stroke", horizontalBorderStroke)
    writer.optional("vertical_border_stroke", verticalBorderStroke)
    writer.optional("horizontal_stroke", horizontalStroke)
    writer.optional("vertical_stroke", verticalStroke)
    writer.optional("border_strokes_visible", borderStrokesVisible)
    writer.optional("horizontal_strokes_visible", horizontalStrokesVisible)
    writer.optional("vertical_strokes_visible", verticalStrokesVisible)
  }
}
