public import WireFormat

/// A run of text in one style.
public struct TextRun: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TextFormat.table.object(named: "TextRun")

  /// The text; it may be empty.
  public var string: String
  /// The character properties, written here or adopted from a preset.
  public var style: CharacterProperties?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a run; a member left out is absent from the JSON.
  public init(string: String, style: CharacterProperties? = nil) {
    self.string = string
    self.style = style
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    string = try reader.required("string")
    style = try reader.optional("style")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("string", string)
    writer.optional("style", style)
  }
}
