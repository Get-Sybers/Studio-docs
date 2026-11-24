public import JSONTree
public import TextModel
public import WireFormat

/// The union `table.cell.unformatted-value` of the format.
public struct UnformattedValue: WireUnion {
  /// The forms that the library models; each is kept out of line, so the value stays small.
  public indirect enum Form: Sendable, Hashable {
    /// The `boolean` form.
    case boolean(Bool)
    /// The `date` form.
    case date(TableDate)
    /// The `number` form.
    case number(Double)
    /// The `rich_text` form.
    case richText(TextBody)
    /// The `text` form.
    case text(String)
  }

  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.union(named: "UnformattedValue")

  /// The form the value takes; nil when a preset supplies it or the library does not model it.
  public var form: Form?
  /// The version and preset of the value, and its members beside the form.
  public var envelope: ObjectEnvelope

  /// Creates a value from its parts.
  public init(form: Form?, envelope: ObjectEnvelope = ObjectEnvelope()) {
    self.form = form
    self.envelope = envelope
  }

  /// Makes the `boolean` form.
  public static func boolean(_ value: Bool) -> UnformattedValue {
    UnformattedValue(.boolean(value))
  }

  /// Makes the `date` form.
  public static func date(_ value: TableDate) -> UnformattedValue {
    UnformattedValue(.date(value))
  }

  /// Makes the `number` form.
  public static func number(_ value: Double) -> UnformattedValue {
    UnformattedValue(.number(value))
  }

  /// Makes the `rich_text` form.
  public static func richText(_ value: TextBody) -> UnformattedValue {
    UnformattedValue(.richText(value))
  }

  /// Makes the `text` form.
  public static func text(_ value: String) -> UnformattedValue {
    UnformattedValue(.text(value))
  }

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "boolean": .boolean(try Bool(wire: contents))
    case "date": .date(try TableDate(wire: contents))
    case "number": .number(try Double(wire: contents))
    case "rich_text": .richText(try TextBody(wire: contents))
    case "text": .text(try String(wire: contents))
    default: nil
    }
  }

  /// Names the case of a form, with its contents, or nil for a form that has none.
  public static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .boolean(let value): ("boolean", value.wireValue)
    case .date(let value): ("date", value.wireValue)
    case .number(let value): ("number", value.wireValue)
    case .richText(let value): ("rich_text", value.wireValue)
    case .text(let value): ("text", value.wireValue)
    }
  }
}
