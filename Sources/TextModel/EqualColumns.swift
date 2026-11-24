public import WireFormat

/// Columns of one width.
public struct EqualColumns: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TextFormat.table.object(named: "EqualColumns")

  /// The number of columns, from 1 to 10.
  public var count: Int
  /// The gap between columns, as a percentage of the text width; 5 when omitted.
  public var gutterWidth: Double?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates equal columns; a member left out is absent from the JSON.
  public init(count: Int, gutterWidth: Double? = nil) {
    self.count = count
    self.gutterWidth = gutterWidth
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    count = try reader.required("count")
    gutterWidth = try reader.optional("gutter_width")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("count", count)
    writer.optional("gutter_width", gutterWidth)
  }
}
