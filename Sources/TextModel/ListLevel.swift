public import WireFormat

/// One level of a list.
public struct ListLevel: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TextFormat.table.object(named: "ListLevel")

  /// The indent of the label from the leading edge, in points.
  public var labelIndent: Double
  /// The indent of the text from the label, as a multiple of the font size.
  public var textIndent: Double
  /// The bullet or number of the level.
  public var label: ListLabel
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a level; a member left out is absent from the JSON.
  public init(labelIndent: Double, textIndent: Double, label: ListLabel) {
    self.labelIndent = labelIndent
    self.textIndent = textIndent
    self.label = label
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    labelIndent = try reader.required("label_indent")
    textIndent = try reader.required("text_indent")
    label = try reader.required("label")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("label_indent", labelIndent)
    writer.required("text_indent", textIndent)
    writer.required("label", label)
  }
}
