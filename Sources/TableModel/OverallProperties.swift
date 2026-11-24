public import Appearance
public import TextModel
public import WireFormat

/// The type `table.visual-properties.overall-properties` of the format.
public struct OverallProperties: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "OverallProperties")

  /// The `behaves_like_spreadsheet` member.
  public var behavesLikeSpreadsheet: Bool?
  /// The `auto_resize` member.
  public var autoResize: Bool?
  /// The `writing_direction` member.
  public var writingDirection: WritingDirection?
  /// The `has_alternating_rows` member.
  public var hasAlternatingRows: Bool?
  /// The `alternating_rows_fill` member; omitted, it is inherited, and `.cleared` writes `null`.
  public var alternatingRowsFill: Inheritable<Fill>
  /// The `rounded_corners` member.
  public var roundedCorners: Bool?
  /// The `stroke_presets` member.
  public var strokePresets: [StrokePreset]?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    behavesLikeSpreadsheet: Bool? = nil, autoResize: Bool? = nil, writingDirection: WritingDirection? = nil,
    hasAlternatingRows: Bool? = nil, alternatingRowsFill: Inheritable<Fill> = .inherited, roundedCorners: Bool? = nil,
    strokePresets: [StrokePreset]? = nil
  ) {
    self.behavesLikeSpreadsheet = behavesLikeSpreadsheet
    self.autoResize = autoResize
    self.writingDirection = writingDirection
    self.hasAlternatingRows = hasAlternatingRows
    self.alternatingRowsFill = alternatingRowsFill
    self.roundedCorners = roundedCorners
    self.strokePresets = strokePresets
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    behavesLikeSpreadsheet = try reader.optional("behaves_like_spreadsheet")
    autoResize = try reader.optional("auto_resize")
    writingDirection = try reader.optional("writing_direction")
    hasAlternatingRows = try reader.optional("has_alternating_rows")
    alternatingRowsFill = try reader.inheritable("alternating_rows_fill")
    roundedCorners = try reader.optional("rounded_corners")
    strokePresets = try reader.optional("stroke_presets")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("behaves_like_spreadsheet", behavesLikeSpreadsheet)
    writer.optional("auto_resize", autoResize)
    writer.optional("writing_direction", writingDirection)
    writer.optional("has_alternating_rows", hasAlternatingRows)
    writer.inheritable("alternating_rows_fill", alternatingRowsFill)
    writer.optional("rounded_corners", roundedCorners)
    writer.optional("stroke_presets", strokePresets)
  }
}
