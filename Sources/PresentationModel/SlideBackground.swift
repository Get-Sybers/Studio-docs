public import Appearance
public import JSONTree
public import WireFormat

/// The union `slide-background` of the format.
public struct SlideBackground: WireUnion {
  /// The forms that the library models; each is kept out of line, so the value stays small.
  public indirect enum Form: Sendable, Hashable {
    /// The `standard` form.
    case standard(Fill)
  }

  /// The facts of the type, from the format table.
  public static let schema = PresentationModelFormat.table.union(named: "SlideBackground")

  /// The form the value takes; nil when a preset supplies it or the library does not model it.
  public var form: Form?
  /// The version and preset of the value, and its members beside the form.
  public var envelope: ObjectEnvelope

  /// Creates a value from its parts.
  public init(form: Form?, envelope: ObjectEnvelope = ObjectEnvelope()) {
    self.form = form
    self.envelope = envelope
  }

  /// Makes the `standard` form.
  public static func standard(_ value: Fill) -> SlideBackground {
    SlideBackground(.standard(value))
  }

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "standard": .standard(try Fill(wire: contents))
    default: nil
    }
  }

  /// Names the case of a form, with its contents, or nil for a form that has none.
  public static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .standard(let value): ("standard", value.wireValue)
    }
  }
}
