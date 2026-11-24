public import Appearance
public import CanvasCommon
public import WireFormat

/// The type `connection-line.end` of the format.
public struct ConnectionEnd: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = CanvasModelFormat.table.object(named: "ConnectionEnd")

  /// The `end_point` member.
  public var endPoint: PositionValue?
  /// The `line_end` member; "none" when omitted.
  public var lineEnd: LineEnd?
  /// The `outset` member; 0 when omitted.
  public var outset: Double?
  /// The `anchor` member.
  public var anchor: ConnectionAnchor?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    endPoint: PositionValue? = nil, lineEnd: LineEnd? = nil, outset: Double? = nil, anchor: ConnectionAnchor? = nil
  ) {
    self.endPoint = endPoint
    self.lineEnd = lineEnd
    self.outset = outset
    self.anchor = anchor
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    endPoint = try reader.optional("end_point")
    lineEnd = try reader.optional("line_end")
    outset = try reader.optional("outset")
    anchor = try reader.optional("anchor")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("end_point", endPoint)
    writer.optional("line_end", lineEnd)
    writer.optional("outset", outset)
    writer.optional("anchor", anchor)
  }
}
