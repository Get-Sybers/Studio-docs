public import JSONTree
public import WireFormat

/// The shadow that an object or a run of text casts.
public struct Shadow: WireUnion {
  /// The forms that the library models; each is kept out of line, so the value stays small.
  public indirect enum Form: Sendable, Hashable {
    /// A shadow that pools under the lower edge.
    case contact(ContactShadow)
    /// A shadow that curls away from the object.
    case curved(CurvedShadow)
    /// A blurred copy of the outline, set off in one direction.
    case drop(DropShadow)
    /// No shadow; a case of version 1.1.
    case unshadowed
  }

  /// The facts of the type, from the format table.
  public static let schema = AppearanceFormat.table.union(named: "Shadow")

  /// The form the value takes; nil when a preset supplies it or the library does not model it.
  public var form: Form?
  /// The version and preset of the value, and its members beside the form.
  public var envelope: ObjectEnvelope

  /// Creates a value from its parts.
  public init(form: Form?, envelope: ObjectEnvelope = ObjectEnvelope()) {
    self.form = form
    self.envelope = envelope
  }

  /// Makes the `contactShadow` form.
  public static func contact(_ value: ContactShadow) -> Shadow {
    Shadow(.contact(value))
  }

  /// Makes the `curvedShadow` form.
  public static func curved(_ value: CurvedShadow) -> Shadow {
    Shadow(.curved(value))
  }

  /// Makes the `dropShadow` form.
  public static func drop(_ value: DropShadow) -> Shadow {
    Shadow(.drop(value))
  }

  /// The `none` form.
  public static let unshadowed = Shadow(.unshadowed)

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "contactShadow": .contact(try ContactShadow(wire: contents))
    case "curvedShadow": .curved(try CurvedShadow(wire: contents))
    case "dropShadow": .drop(try DropShadow(wire: contents))
    case "none": .unshadowed
    default: nil
    }
  }

  /// Names the case of a form, with its contents, or nil for a form that has none.
  public static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .contact(let value): ("contactShadow", value.wireValue)
    case .curved(let value): ("curvedShadow", value.wireValue)
    case .drop(let value): ("dropShadow", value.wireValue)
    case .unshadowed: ("none", nil)
    }
  }
}
