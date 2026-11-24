public import WireFormat

/// The spacing between the lines of a paragraph.
public struct LineSpacing: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TextFormat.table.object(named: "LineSpacing")

  /// How the amount is read; relative when omitted.
  public var kind: LineSpacingKind?
  /// The amount: a multiple for relative spacing, or else points.
  public var value: Double
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a line spacing; a member left out is absent from the JSON.
  public init(value: Double, kind: LineSpacingKind? = nil) {
    self.kind = kind
    self.value = value
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    kind = try reader.optional("kind")
    value = try reader.required("value")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("kind", kind)
    writer.required("value", value)
  }
}
