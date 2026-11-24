public import TextModel
public import WireFormat

/// The type `table.conditional-style-set.rule` of the format.
public struct ConditionalStyleRule: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "ConditionalStyleRule")

  /// The `predicate` member.
  public var predicate: TablePredicate
  /// The `cell_style` member.
  public var cellStyle: CellProperties?
  /// The `text_style` member; kept out of line, so the value stays small.
  public var textStyle: Indirect<ParagraphProperties>?
  /// The `preset_kind` member.
  public var presetKind: ConditionalStylePreset?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    predicate: TablePredicate, cellStyle: CellProperties? = nil, textStyle: ParagraphProperties? = nil,
    presetKind: ConditionalStylePreset? = nil
  ) {
    self.predicate = predicate
    self.cellStyle = cellStyle
    self.textStyle = textStyle.map(Indirect.init)
    self.presetKind = presetKind
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    predicate = try reader.required("predicate")
    cellStyle = try reader.optional("cell_style")
    textStyle = try reader.optional("text_style")
    presetKind = try reader.optional("preset_kind")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("predicate", predicate)
    writer.optional("cell_style", cellStyle)
    writer.optional("text_style", textStyle)
    writer.optional("preset_kind", presetKind)
  }
}
