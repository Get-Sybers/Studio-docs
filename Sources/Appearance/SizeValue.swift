public import WireFormat

/// A width and a height, in points.
public struct SizeValue: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = AppearanceFormat.table.object(named: "SizeValue")

  /// The width.
  public var width: Double
  /// The height.
  public var height: Double
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a size; a member left out is absent from the JSON.
  public init(width: Double, height: Double) {
    self.width = width
    self.height = height
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    width = try reader.required("width")
    height = try reader.required("height")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("width", width)
    writer.required("height", height)
  }
}
