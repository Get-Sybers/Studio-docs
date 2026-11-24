public import WireFormat

/// A stroke drawn as a line.
public struct LineStroke: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = AppearanceFormat.table.object(named: "LineStroke")

  /// The colour; black when omitted.
  public var color: ColorValue?
  /// The width, from 0.25 to 100 points; 1 when omitted.
  public var width: Double?
  /// The pattern; solid when omitted.
  public var pattern: StrokePattern?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a line stroke; a member left out is absent from the JSON.
  public init(color: ColorValue? = nil, width: Double? = nil, pattern: StrokePattern? = nil) {
    self.color = color
    self.width = width
    self.pattern = pattern
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    color = try reader.optional("color")
    width = try reader.optional("width")
    pattern = try reader.optional("pattern")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("color", color)
    writer.optional("width", width)
    writer.optional("pattern", pattern)
  }
}
