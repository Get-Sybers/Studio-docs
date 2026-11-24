public import WireFormat

/// The type `table.cell-format.bool-format` of the format.
public struct BoolFormat: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "BoolFormat")

  /// The `true_string` member.
  public var trueString: String
  /// The `false_string` member.
  public var falseString: String
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(trueString: String, falseString: String) {
    self.trueString = trueString
    self.falseString = falseString
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    trueString = try reader.required("true_string")
    falseString = try reader.required("false_string")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("true_string", trueString)
    writer.required("false_string", falseString)
  }
}
