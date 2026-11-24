public import WireFormat

/// A point, in points, measured from the top left corner of its space.
public struct PositionValue: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = AppearanceFormat.table.object(named: "PositionValue")

  /// The distance to the right.
  public var x: Double
  /// The distance downward.
  public var y: Double
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a point; a member left out is absent from the JSON.
  public init(x: Double, y: Double) {
    self.x = x
    self.y = y
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    x = try reader.required("x")
    y = try reader.required("y")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("x", x)
    writer.required("y", y)
  }
}
