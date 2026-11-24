public import JSONTree
public import WireFormat

/// The union `table.column-header.kind` of the format.
public struct ColumnHeaderKind: WireUnion {
  /// The forms that the library models; each is kept out of line, so the value stays small.
  public indirect enum Form: Sendable, Hashable {
    /// The `body` form.
    case body
    /// The `grand_total` form.
    case grandTotal
    /// The `group_label` form.
    case groupLabel(ColumnGroupLabel)
    /// The `group_subtotal` form.
    case groupSubtotal
  }

  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.union(named: "ColumnHeaderKind")

  /// The form the value takes; nil when a preset supplies it or the library does not model it.
  public var form: Form?
  /// The version and preset of the value, and its members beside the form.
  public var envelope: ObjectEnvelope

  /// Creates a value from its parts.
  public init(form: Form?, envelope: ObjectEnvelope = ObjectEnvelope()) {
    self.form = form
    self.envelope = envelope
  }

  /// The `body` form.
  public static let body = ColumnHeaderKind(.body)

  /// The `grand_total` form.
  public static let grandTotal = ColumnHeaderKind(.grandTotal)

  /// Makes the `group_label` form.
  public static func groupLabel(_ value: ColumnGroupLabel) -> ColumnHeaderKind {
    ColumnHeaderKind(.groupLabel(value))
  }

  /// The `group_subtotal` form.
  public static let groupSubtotal = ColumnHeaderKind(.groupSubtotal)

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "body": .body
    case "grand_total": .grandTotal
    case "group_label": .groupLabel(try ColumnGroupLabel(wire: contents))
    case "group_subtotal": .groupSubtotal
    default: nil
    }
  }

  /// Names the case of a form, with its contents, or nil for a form that has none.
  public static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .body: ("body", nil)
    case .grandTotal: ("grand_total", nil)
    case .groupLabel(let value): ("group_label", value.wireValue)
    case .groupSubtotal: ("group_subtotal", nil)
    }
  }
}
