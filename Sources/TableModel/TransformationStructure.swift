public import JSONTree
public import WireFormat

/// The union `table.transformation-info.structure` of the format.
public struct TransformationStructure: WireUnion {
  /// The forms that the library models; each is kept out of line, so the value stays small.
  public indirect enum Form: Sendable, Hashable {
    /// The `categorized` form.
    case categorized(CategoryRules)
    /// The `pivot` form.
    case pivot(PivotRules)
  }

  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.union(named: "TransformationStructure")

  /// The form the value takes; nil when a preset supplies it or the library does not model it.
  public var form: Form?
  /// The version and preset of the value, and its members beside the form.
  public var envelope: ObjectEnvelope

  /// Creates a value from its parts.
  public init(form: Form?, envelope: ObjectEnvelope = ObjectEnvelope()) {
    self.form = form
    self.envelope = envelope
  }

  /// Makes the `categorized` form.
  public static func categorized(_ value: CategoryRules) -> TransformationStructure {
    TransformationStructure(.categorized(value))
  }

  /// Makes the `pivot` form.
  public static func pivot(_ value: PivotRules) -> TransformationStructure {
    TransformationStructure(.pivot(value))
  }

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "categorized": .categorized(try CategoryRules(wire: contents))
    case "pivot": .pivot(try PivotRules(wire: contents))
    default: nil
    }
  }

  /// Names the case of a form, with its contents, or nil for a form that has none.
  public static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .categorized(let value): ("categorized", value.wireValue)
    case .pivot(let value): ("pivot", value.wireValue)
    }
  }
}
