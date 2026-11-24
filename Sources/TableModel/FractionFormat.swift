public import WireFormat

/// The type `table.cell-format.fraction-format` of the format.
public struct FractionFormat: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "FractionFormat")

  /// The `accuracy` member; "up_to_three_digits" when omitted.
  public var accuracy: FractionAccuracy?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(accuracy: FractionAccuracy? = nil) {
    self.accuracy = accuracy
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    accuracy = try reader.optional("accuracy")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("accuracy", accuracy)
  }
}
