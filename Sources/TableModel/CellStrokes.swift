public import Appearance
public import WireFormat

/// The type `table.cell.strokes` of the format.
public struct CellStrokes: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "CellStrokes")

  /// The `top` member.
  public var top: Stroke?
  /// The `bottom` member.
  public var bottom: Stroke?
  /// The `left` member.
  public var left: Stroke?
  /// The `right` member.
  public var right: Stroke?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(top: Stroke? = nil, bottom: Stroke? = nil, left: Stroke? = nil, right: Stroke? = nil) {
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
