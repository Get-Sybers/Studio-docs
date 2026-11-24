public import CanvasCommon
public import TextModel
public import WireFormat

/// The type `chart-legend` of the format.
public struct ChartLegend: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = ChartModelFormat.table.object(named: "ChartLegend")

  /// The `geometry` member.
  public var geometry: Geometry?
  /// The `label_text_style` member; kept out of line, so the value stays small.
  public var labelTextStyle: Indirect<ParagraphProperties>?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(geometry: Geometry? = nil, labelTextStyle: ParagraphProperties? = nil) {
    self.geometry = geometry
    self.labelTextStyle = labelTextStyle.map(Indirect.init)
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    geometry = try reader.optional("geometry")
    labelTextStyle = try reader.optional("label_text_style")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("geometry", geometry)
    writer.optional("label_text_style", labelTextStyle)
  }
}
