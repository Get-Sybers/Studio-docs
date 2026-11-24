public import WireFormat

/// Columns of given widths.
public struct UnequalColumns: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TextFormat.table.object(named: "UnequalColumns")

  /// The width of each column, as a percentage of the text width; with the gaps they total 100.
  public var columnWidths: [Double]
  /// The gap after each column but the last, as a percentage of the text width.
  public var gutterWidths: [Double]?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates unequal columns; a member left out is absent from the JSON.
  public init(columnWidths: [Double], gutterWidths: [Double]? = nil) {
    self.columnWidths = columnWidths
    self.gutterWidths = gutterWidths
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    columnWidths = try reader.required("column_widths")
    gutterWidths = try reader.optional("gutter_widths")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("column_widths", columnWidths)
    writer.optional("gutter_widths", gutterWidths)
  }
}
