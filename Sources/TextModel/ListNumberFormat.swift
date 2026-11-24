public import WireFormat

/// The numerals of a numbered list and what stands around them.
public struct ListNumberFormat: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TextFormat.table.object(named: "ListNumberFormat")

  /// The numerals or letters; Western digits when omitted.
  public var kind: NumberingSystem?
  /// Whether Roman numerals or Latin letters are capitals.
  public var upper: Bool?
  /// Whether Japanese or Chinese numerals take their formal form.
  public var formal: Bool?
  /// What stands around the number; a full stop after it when omitted.
  public var format: NumberDecoration?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a number format; a member left out is absent from the JSON.
  public init(kind: NumberingSystem? = nil, upper: Bool? = nil, formal: Bool? = nil, format: NumberDecoration? = nil) {
    self.kind = kind
    self.upper = upper
    self.formal = formal
    self.format = format
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    kind = try reader.optional("kind")
    upper = try reader.optional("upper")
    formal = try reader.optional("formal")
    format = try reader.optional("format")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("kind", kind)
    writer.optional("upper", upper)
    writer.optional("formal", formal)
    writer.optional("format", format)
  }
}
