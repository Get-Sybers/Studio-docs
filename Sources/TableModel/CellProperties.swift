public import Appearance
public import TextModel
public import WireFormat

/// The type `table.cell-properties` of the format.
public struct CellProperties: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "CellProperties")

  /// The `text_wrap` member.
  public var textWrap: Bool?
  /// The `vertical_alignment` member.
  public var verticalAlignment: VerticalTextAlignment?
  /// The `padding` member.
  public var padding: Insets?
  /// The `fill` member; omitted, it is inherited, and `.cleared` writes `null`.
  public var fill: Inheritable<Fill>
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    textWrap: Bool? = nil, verticalAlignment: VerticalTextAlignment? = nil, padding: Insets? = nil,
    fill: Inheritable<Fill> = .inherited
  ) {
    self.textWrap = textWrap
    self.verticalAlignment = verticalAlignment
    self.padding = padding
    self.fill = fill
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    textWrap = try reader.optional("text_wrap")
    verticalAlignment = try reader.optional("vertical_alignment")
    padding = try reader.optional("padding")
    fill = try reader.inheritable("fill")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("text_wrap", textWrap)
    writer.optional("vertical_alignment", verticalAlignment)
    writer.optional("padding", padding)
    writer.inheritable("fill", fill)
  }
}
