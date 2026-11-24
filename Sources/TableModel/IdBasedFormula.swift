public import WireFormat

/// The type `table.cell.formula.id-based-formula` of the format.
public struct IdBasedFormula: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "IdBasedFormula")

  /// The `expression` member.
  public var expression: String
  /// The `references` member.
  public var references: [CellReference]?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(expression: String, references: [CellReference]? = nil) {
    self.expression = expression
    self.references = references
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    expression = try reader.required("expression")
    references = try reader.optional("references")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("expression", expression)
    writer.optional("references", references)
  }
}
