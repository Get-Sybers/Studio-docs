public import JSONTree
public import WireFormat

/// The union `table.cell.formula` of the format.
public struct CellFormula: WireUnion {
  /// The forms that the library models; each is kept out of line, so the value stays small.
  public indirect enum Form: Sendable, Hashable {
    /// The `display_string` form.
    case displayString(String)
    /// The `id_based` form.
    case idBased(IdBasedFormula)
  }

  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.union(named: "CellFormula")

  /// The form the value takes; nil when a preset supplies it or the library does not model it.
  public var form: Form?
  /// The version and preset of the value, and its members beside the form.
  public var envelope: ObjectEnvelope

  /// Creates a value from its parts.
  public init(form: Form?, envelope: ObjectEnvelope = ObjectEnvelope()) {
    self.form = form
    self.envelope = envelope
  }

  /// Makes the `display_string` form.
  public static func displayString(_ value: String) -> CellFormula {
    CellFormula(.displayString(value))
  }

  /// Makes the `id_based` form.
  public static func idBased(_ value: IdBasedFormula) -> CellFormula {
    CellFormula(.idBased(value))
  }

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "display_string": .displayString(try String(wire: contents))
    case "id_based": .idBased(try IdBasedFormula(wire: contents))
    default: nil
    }
  }

  /// Names the case of a form, with its contents, or nil for a form that has none.
  public static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .displayString(let value): ("display_string", value.wireValue)
    case .idBased(let value): ("id_based", value.wireValue)
    }
  }
}
