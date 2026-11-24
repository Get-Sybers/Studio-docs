public import WireFormat

/// A displacement, in points.
public struct OffsetValue: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = AppearanceFormat.table.object(named: "OffsetValue")

  /// The displacement to the right; 0 when omitted.
  public var dx: Double?
  /// The displacement downward; 0 when omitted.
  public var dy: Double?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a displacement; a member left out is absent from the JSON.
  public init(dx: Double? = nil, dy: Double? = nil) {
    self.dx = dx
    self.dy = dy
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    dx = try reader.optional("dx")
    dy = try reader.optional("dy")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("dx", dx)
    writer.optional("dy", dy)
  }
}
