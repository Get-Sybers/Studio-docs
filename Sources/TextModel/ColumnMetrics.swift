public import JSONTree
public import WireFormat

/// How a text area is divided into columns.
public struct ColumnMetrics: WireUnion {
  /// The forms that the library models.
  public enum Form: Sendable, Hashable {
    /// Columns of one width.
    case equal(EqualColumns)
    /// One column.
    case single
    /// Columns of given widths.
    case unequal(UnequalColumns)
  }

  /// The facts of the type, from the format table.
  public static let schema = TextFormat.table.union(named: "ColumnMetrics")

  /// The form the value takes; nil when a preset supplies it or the library does not model it.
  public var form: Form?
  /// The version and preset of the value, and its members beside the form.
  public var envelope: ObjectEnvelope

  /// Creates a value from its parts.
  public init(form: Form?, envelope: ObjectEnvelope = ObjectEnvelope()) {
    self.form = form
    self.envelope = envelope
  }

  /// Makes the `equal` form.
  public static func equal(_ value: EqualColumns) -> ColumnMetrics {
    ColumnMetrics(.equal(value))
  }

  /// The `single` form.
  public static let single = ColumnMetrics(.single)

  /// Makes the `unequal` form.
  public static func unequal(_ value: UnequalColumns) -> ColumnMetrics {
    ColumnMetrics(.unequal(value))
  }

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "equal": .equal(try EqualColumns(wire: contents))
    case "single": .single
    case "unequal": .unequal(try UnequalColumns(wire: contents))
    default: nil
    }
  }

  /// Names the case of a form, with its contents, or nil for a form that has none.
  public static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .equal(let value): ("equal", value.wireValue)
    case .single: ("single", nil)
    case .unequal(let value): ("unequal", value.wireValue)
    }
  }
}
