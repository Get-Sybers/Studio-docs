public import JSONTree
public import WireFormat

/// The outline of characters, or of a paragraph's borders: a stroke, or none.
public struct TextStroke: WireUnion {
  /// The forms that the library models.
  public enum Form: Sendable, Hashable {
    /// No outline.
    case unstroked
    /// An outline.
    case stroke(Stroke)
  }

  /// The facts of the type, from the format table.
  public static let schema = AppearanceFormat.table.union(named: "TextStroke")

  /// The form the value takes; nil when a preset supplies it or the library does not model it.
  public var form: Form?
  /// The version and preset of the value, and its members beside the form.
  public var envelope: ObjectEnvelope

  /// Creates a value from its parts.
  public init(form: Form?, envelope: ObjectEnvelope = ObjectEnvelope()) {
    self.form = form
    self.envelope = envelope
  }

  /// The `none` form.
  public static let unstroked = TextStroke(.unstroked)

  /// Makes the `stroke` form.
  public static func stroke(_ value: Stroke) -> TextStroke {
    TextStroke(.stroke(value))
  }

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "none": .unstroked
    case "stroke": .stroke(try Stroke(wire: contents))
    default: nil
    }
  }

  /// Names the case of a form, with its contents, or nil for a form that has none.
  public static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .unstroked: ("none", nil)
    case .stroke(let value): ("stroke", value.wireValue)
    }
  }
}
