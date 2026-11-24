public import WireFormat

/// A numbered label.
public struct ListNumberLabel: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TextFormat.table.object(named: "ListNumberLabel")

  /// The numerals and what stands around them; a Western number and a full stop when omitted.
  public var numberFormat: ListNumberFormat?
  /// The size as a multiple of the text size; 1 when omitted.
  public var scale: Double?
  /// Whether the number shows its parents, as in 1.2; false when omitted.
  public var tiered: Bool?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a numbered label; a member left out is absent from the JSON.
  public init(numberFormat: ListNumberFormat? = nil, scale: Double? = nil, tiered: Bool? = nil) {
    self.numberFormat = numberFormat
    self.scale = scale
    self.tiered = tiered
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    numberFormat = try reader.optional("number_format")
    scale = try reader.optional("scale")
    tiered = try reader.optional("tiered")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("number_format", numberFormat)
    writer.optional("scale", scale)
    writer.optional("tiered", tiered)
  }
}
