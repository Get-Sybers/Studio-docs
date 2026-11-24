public import JSONTree
public import WireFormat

/// A colour, in one of the forms the format gives it.
public struct ColorValue: WireUnion {
  /// The forms that the library models.
  public enum Form: Sendable, Hashable {
    /// Red, green, blue and alpha in a named colour space.
    case rgba(RGBAColor)
  }

  /// The facts of the type, from the format table.
  public static let schema = AppearanceFormat.table.union(named: "ColorValue")

  /// The form the value takes; nil when a preset supplies it or the library does not model it.
  public var form: Form?
  /// The version and preset of the value, and its members beside the form.
  public var envelope: ObjectEnvelope

  /// Creates a value from its parts.
  public init(form: Form?, envelope: ObjectEnvelope = ObjectEnvelope()) {
    self.form = form
    self.envelope = envelope
  }

  /// Makes the `rgba` form.
  public static func rgba(_ value: RGBAColor) -> ColorValue {
    ColorValue(.rgba(value))
  }

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "rgba": .rgba(try RGBAColor(wire: contents))
    default: nil
    }
  }

  /// Names the case of a form, with its contents, or nil for a form that has none.
  public static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .rgba(let value): ("rgba", value.wireValue)
    }
  }
}
