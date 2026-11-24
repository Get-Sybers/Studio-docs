public import WireFormat

/// The type `table.cell-format.date-time-format` of the format.
public struct DateTimeFormat: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "DateTimeFormat")

  /// The `format_string` member.
  public var formatString: String
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(formatString: String) {
    self.formatString = formatString
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    formatString = try reader.required("format_string")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("format_string", formatString)
  }
}
