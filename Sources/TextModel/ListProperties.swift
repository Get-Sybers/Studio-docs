public import Appearance
public import WireFormat

/// The properties of a list: its levels and the look of its labels.
public struct ListProperties: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TextFormat.table.object(named: "ListProperties")

  /// The colour of the labels.
  public var fontColor: Inheritable<ColorValue>
  /// The PostScript name of the font of the labels.
  public var fontName: Inheritable<String>
  /// The direction of the list.
  public var writingDirection: Inheritable<WritingDirection>
  /// The shadow of the labels.
  public var shadow: Inheritable<Shadow>
  /// The levels, the top one first; a reader uses nine at most and repeats the last.
  public var levels: Inheritable<[ListLevel]>
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates list properties; a member left out is absent from the JSON.
  public init(
    fontColor: Inheritable<ColorValue> = .inherited, fontName: Inheritable<String> = .inherited,
    writingDirection: Inheritable<WritingDirection> = .inherited, shadow: Inheritable<Shadow> = .inherited,
    levels: Inheritable<[ListLevel]> = .inherited
  ) {
    self.fontColor = fontColor
    self.fontName = fontName
    self.writingDirection = writingDirection
    self.shadow = shadow
    self.levels = levels
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    fontColor = try reader.inheritable("font_color")
    fontName = try reader.inheritable("font_name")
    writingDirection = try reader.inheritable("writing_direction")
    shadow = try reader.inheritable("shadow")
    levels = try reader.inheritable("levels")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.inheritable("font_color", fontColor)
    writer.inheritable("font_name", fontName)
    writer.inheritable("writing_direction", writingDirection)
    writer.inheritable("shadow", shadow)
    writer.inheritable("levels", levels)
  }
}
