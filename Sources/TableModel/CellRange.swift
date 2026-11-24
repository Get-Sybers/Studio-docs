public import JSONTree
public import WireFormat

/// The union `table.cell-range` of the format.
public struct CellRange: WireUnion {
  /// The forms that the library models; each is kept out of line, so the value stays small.
  public indirect enum Form: Sendable, Hashable {
    /// The `row_column_id_range` form.
    case rowColumnIdRange(RowColumnIdRange)
  }

  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.union(named: "CellRange")

  /// The form the value takes; nil when a preset supplies it or the library does not model it.
  public var form: Form?
  /// The version and preset of the value, and its members beside the form.
  public var envelope: ObjectEnvelope

  /// Creates a value from its parts.
  public init(form: Form?, envelope: ObjectEnvelope = ObjectEnvelope()) {
    self.form = form
    self.envelope = envelope
  }

  /// Makes the `row_column_id_range` form.
  public static func rowColumnIdRange(_ value: RowColumnIdRange) -> CellRange {
    CellRange(.rowColumnIdRange(value))
  }

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "row_column_id_range": .rowColumnIdRange(try RowColumnIdRange(wire: contents))
    default: nil
    }
  }

  /// Names the case of a form, with its contents, or nil for a form that has none.
  public static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .rowColumnIdRange(let value): ("row_column_id_range", value.wireValue)
    }
  }
}
