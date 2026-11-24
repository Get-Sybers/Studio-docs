public import JSONTree
public import WireFormat

/// The union `table.predicate.value` of the format.
public struct PredicateValue: WireUnion {
  /// The forms that the library models; each is kept out of line, so the value stays small.
  public indirect enum Form: Sendable, Hashable {
    /// The `date` form.
    case date(TableDate)
    /// The `duration` form.
    case duration(Double)
    /// The `number` form.
    case number(Double)
    /// The `reference` form.
    case reference(PredicateReference)
    /// The `text` form.
    case text(String)
  }

  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.union(named: "PredicateValue")

  /// The form the value takes; nil when a preset supplies it or the library does not model it.
  public var form: Form?
  /// The version and preset of the value, and its members beside the form.
  public var envelope: ObjectEnvelope

  /// Creates a value from its parts.
  public init(form: Form?, envelope: ObjectEnvelope = ObjectEnvelope()) {
    self.form = form
    self.envelope = envelope
  }

  /// Makes the `date` form.
  public static func date(_ value: TableDate) -> PredicateValue {
    PredicateValue(.date(value))
  }

  /// Makes the `duration` form.
  public static func duration(_ value: Double) -> PredicateValue {
    PredicateValue(.duration(value))
  }

  /// Makes the `number` form.
  public static func number(_ value: Double) -> PredicateValue {
    PredicateValue(.number(value))
  }

  /// Makes the `reference` form.
  public static func reference(_ value: PredicateReference) -> PredicateValue {
    PredicateValue(.reference(value))
  }

  /// Makes the `text` form.
  public static func text(_ value: String) -> PredicateValue {
    PredicateValue(.text(value))
  }

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "date": .date(try TableDate(wire: contents))
    case "duration": .duration(try Double(wire: contents))
    case "number": .number(try Double(wire: contents))
    case "reference": .reference(try PredicateReference(wire: contents))
    case "text": .text(try String(wire: contents))
    default: nil
    }
  }

  /// Names the case of a form, with its contents, or nil for a form that has none.
  public static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .date(let value): ("date", value.wireValue)
    case .duration(let value): ("duration", value.wireValue)
    case .number(let value): ("number", value.wireValue)
    case .reference(let value): ("reference", value.wireValue)
    case .text(let value): ("text", value.wireValue)
    }
  }
}
