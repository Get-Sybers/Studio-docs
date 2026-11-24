public import WireFormat

/// The type `table.cell-range.row-column-id-range` of the format.
public struct RowColumnIdRange: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "RowColumnIdRange")

  /// The `top_left_row_identifier` member.
  public var topLeftRowIdentifier: String
  /// The `top_left_column_identifier` member.
  public var topLeftColumnIdentifier: String
  /// The `bottom_right_row_identifier` member.
  public var bottomRightRowIdentifier: String
  /// The `bottom_right_column_identifier` member.
  public var bottomRightColumnIdentifier: String
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    topLeftRowIdentifier: String, topLeftColumnIdentifier: String, bottomRightRowIdentifier: String,
    bottomRightColumnIdentifier: String
  ) {
    self.topLeftRowIdentifier = topLeftRowIdentifier
    self.topLeftColumnIdentifier = topLeftColumnIdentifier
    self.bottomRightRowIdentifier = bottomRightRowIdentifier
    self.bottomRightColumnIdentifier = bottomRightColumnIdentifier
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    topLeftRowIdentifier = try reader.required("top_left_row_identifier")
    topLeftColumnIdentifier = try reader.required("top_left_column_identifier")
    bottomRightRowIdentifier = try reader.required("bottom_right_row_identifier")
    bottomRightColumnIdentifier = try reader.required("bottom_right_column_identifier")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("top_left_row_identifier", topLeftRowIdentifier)
    writer.required("top_left_column_identifier", topLeftColumnIdentifier)
    writer.required("bottom_right_row_identifier", bottomRightRowIdentifier)
    writer.required("bottom_right_column_identifier", bottomRightColumnIdentifier)
  }
}
