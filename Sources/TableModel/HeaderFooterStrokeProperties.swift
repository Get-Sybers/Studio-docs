public import Appearance
public import WireFormat

/// The type `table.visual-properties.header-footer-stroke-properties` of the format.
public struct HeaderFooterStrokeProperties: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "HeaderFooterStrokeProperties")

  /// The `border_stroke` member.
  public var borderStroke: Stroke?
  /// The `separator_stroke` member.
  public var separatorStroke: Stroke?
  /// The `horizontal_stroke` member.
  public var horizontalStroke: Stroke?
  /// The `vertical_stroke` member.
  public var verticalStroke: Stroke?
  /// The `separator_visible` member.
  public var separatorVisible: Bool?
  /// The `across_strokes_visible` member.
  public var acrossStrokesVisible: Bool?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    borderStroke: Stroke? = nil, separatorStroke: Stroke? = nil, horizontalStroke: Stroke? = nil,
    verticalStroke: Stroke? = nil, separatorVisible: Bool? = nil, acrossStrokesVisible: Bool? = nil
  ) {
    self.borderStroke = borderStroke
    self.separatorStroke = separatorStroke
    self.horizontalStroke = horizontalStroke
    self.verticalStroke = verticalStroke
    self.separatorVisible = separatorVisible
    self.acrossStrokesVisible = acrossStrokesVisible
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    borderStroke = try reader.optional("border_stroke")
    separatorStroke = try reader.optional("separator_stroke")
    horizontalStroke = try reader.optional("horizontal_stroke")
    verticalStroke = try reader.optional("vertical_stroke")
    separatorVisible = try reader.optional("separator_visible")
    acrossStrokesVisible = try reader.optional("across_strokes_visible")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("border_stroke", borderStroke)
    writer.optional("separator_stroke", separatorStroke)
    writer.optional("horizontal_stroke", horizontalStroke)
    writer.optional("vertical_stroke", verticalStroke)
    writer.optional("separator_visible", separatorVisible)
    writer.optional("across_strokes_visible", acrossStrokesVisible)
  }
}
