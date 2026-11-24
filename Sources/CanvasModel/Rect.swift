public import Appearance
public import WireFormat

/// The type `rect` of the format.
public struct Rect: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = CanvasModelFormat.table.object(named: "Rect")

  /// The `position` member.
  public var position: PositionValue
  /// The `size` member.
  public var size: SizeValue
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(position: PositionValue, size: SizeValue) {
    self.position = position
    self.size = size
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    position = try reader.required("position")
    size = try reader.required("size")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("position", position)
    writer.required("size", size)
  }
}
