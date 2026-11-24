public import WireFormat

/// The space kept free along each edge of an area, in points.
public struct Insets: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = AppearanceFormat.table.object(named: "Insets")

  /// The space at the top; 0 when omitted.
  public var top: Double?
  /// The space at the bottom; 0 when omitted.
  public var bottom: Double?
  /// The space on the left; 0 when omitted.
  public var left: Double?
  /// The space on the right; 0 when omitted.
  public var right: Double?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates insets; a member left out is absent from the JSON.
  public init(top: Double? = nil, bottom: Double? = nil, left: Double? = nil, right: Double? = nil) {
    self.top = top
    self.bottom = bottom
    self.left = left
    self.right = right
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    top = try reader.optional("top")
    bottom = try reader.optional("bottom")
    left = try reader.optional("left")
    right = try reader.optional("right")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("top", top)
    writer.optional("bottom", bottom)
    writer.optional("left", left)
    writer.optional("right", right)
  }
}
