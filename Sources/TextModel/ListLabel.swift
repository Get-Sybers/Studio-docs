public import JSONTree
public import WireFormat

/// The label of a list level: a bullet, a number, an image, or none.
public struct ListLabel: WireUnion {
  /// The forms that the library models; each is kept out of line, so the value stays small.
  public indirect enum Form: Sendable, Hashable {
    /// An image.
    case image(ListImageLabel)
    /// No label.
    case unlabelled
    /// An image label whose image is absent; nothing is drawn.
    case missingImage
    /// A number.
    case number(ListNumberLabel)
    /// A bullet or other short text.
    case string(ListStringLabel)
  }

  /// The facts of the type, from the format table.
  public static let schema = TextFormat.table.union(named: "ListLabel")

  /// The form the value takes; nil when a preset supplies it or the library does not model it.
  public var form: Form?
  /// The version and preset of the value, and its members beside the form.
  public var envelope: ObjectEnvelope

  /// Creates a value from its parts.
  public init(form: Form?, envelope: ObjectEnvelope = ObjectEnvelope()) {
    self.form = form
    self.envelope = envelope
  }

  /// Makes the `image` form.
  public static func image(_ value: ListImageLabel) -> ListLabel {
    ListLabel(.image(value))
  }

  /// The `none` form.
  public static let unlabelled = ListLabel(.unlabelled)

  /// The `null_image` form.
  public static let missingImage = ListLabel(.missingImage)

  /// Makes the `number` form.
  public static func number(_ value: ListNumberLabel) -> ListLabel {
    ListLabel(.number(value))
  }

  /// Makes the `string` form.
  public static func string(_ value: ListStringLabel) -> ListLabel {
    ListLabel(.string(value))
  }

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "image": .image(try ListImageLabel(wire: contents))
    case "none": .unlabelled
    case "null_image": .missingImage
    case "number": .number(try ListNumberLabel(wire: contents))
    case "string": .string(try ListStringLabel(wire: contents))
    default: nil
    }
  }

  /// Names the case of a form, with its contents, or nil for a form that has none.
  public static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .image(let value): ("image", value.wireValue)
    case .unlabelled: ("none", nil)
    case .missingImage: ("null_image", nil)
    case .number(let value): ("number", value.wireValue)
    case .string(let value): ("string", value.wireValue)
    }
  }
}
