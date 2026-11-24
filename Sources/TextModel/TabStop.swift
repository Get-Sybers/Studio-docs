public import WireFormat

/// A tab stop.
public struct TabStop: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TextFormat.table.object(named: "TabStop")

  /// The place of the stop, in points; greater than 0.
  public var position: Double
  /// How text meets the stop; left when omitted.
  public var kind: TabAlignment?
  /// The text that fills the gap before the stop; a space when omitted.
  public var leader: String?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a tab stop; a member left out is absent from the JSON.
  public init(position: Double, kind: TabAlignment? = nil, leader: String? = nil) {
    self.position = position
    self.kind = kind
    self.leader = leader
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    position = try reader.required("position")
    kind = try reader.optional("kind")
    leader = try reader.optional("leader")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("position", position)
    writer.optional("kind", kind)
    writer.optional("leader", leader)
  }
}
