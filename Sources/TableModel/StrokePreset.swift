public import Appearance
public import WireFormat

/// The type `table.visual-properties.stroke-preset` of the format.
public struct StrokePreset: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "StrokePreset")

  /// The `horizontal_stroke` member.
  public var horizontalStroke: Stroke?
  /// The `vertical_stroke` member.
  public var verticalStroke: Stroke?
  /// The `exterior_stroke` member.
  public var exteriorStroke: Stroke?
  /// The `visible_edges` member.
  public var visibleEdges: [StrokeEdge]?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    horizontalStroke: Stroke? = nil, verticalStroke: Stroke? = nil, exteriorStroke: Stroke? = nil,
    visibleEdges: [StrokeEdge]? = nil
  ) {
    self.horizontalStroke = horizontalStroke
    self.verticalStroke = verticalStroke
    self.exteriorStroke = exteriorStroke
    self.visibleEdges = visibleEdges
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    horizontalStroke = try reader.optional("horizontal_stroke")
    verticalStroke = try reader.optional("vertical_stroke")
    exteriorStroke = try reader.optional("exterior_stroke")
    visibleEdges = try reader.optional("visible_edges")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("horizontal_stroke", horizontalStroke)
    writer.optional("vertical_stroke", verticalStroke)
    writer.optional("exterior_stroke", exteriorStroke)
    writer.optional("visible_edges", visibleEdges)
  }
}
