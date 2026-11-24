public import JSONTree
public import WireFormat

/// The union `duration` of the format.
public struct DurationValue: WireUnion {
  /// The forms that the library models; each is kept out of line, so the value stays small.
  public indirect enum Form: Sendable, Hashable {
    /// The `seconds` form.
    case seconds(Double)
  }

  /// The facts of the type, from the format table.
  public static let schema = CanvasCommonFormat.table.union(named: "DurationValue")

  /// The form the value takes; nil when a preset supplies it or the library does not model it.
  public var form: Form?
  /// The version and preset of the value, and its members beside the form.
  public var envelope: ObjectEnvelope

  /// Creates a value from its parts.
  public init(form: Form?, envelope: ObjectEnvelope = ObjectEnvelope()) {
    self.form = form
    self.envelope = envelope
  }

  /// Makes the `seconds` form.
  public static func seconds(_ value: Double) -> DurationValue {
    DurationValue(.seconds(value))
  }

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "seconds": .seconds(try Double(wire: contents))
    default: nil
    }
  }

  /// Names the case of a form, with its contents, or nil for a form that has none.
  public static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .seconds(let value): ("seconds", value.wireValue)
    }
  }
}
