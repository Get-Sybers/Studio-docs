public import JSONTree
public import WireFormat

/// What fills an area: a colour, a gradient or an image.
public struct Fill: WireUnion {
  /// The forms that the library models.
  public enum Form: Sendable, Hashable {
    /// One colour.
    case color(ColorValue)
    /// A gradient between two or more colours.
    case gradient(GradientFill)
    /// An image.
    case image(ImageFill)
  }

  /// The facts of the type, from the format table.
  public static let schema = AppearanceFormat.table.union(named: "Fill")

  /// The form the value takes; nil when a preset supplies it or the library does not model it.
  public var form: Form?
  /// The version and preset of the value, and its members beside the form.
  public var envelope: ObjectEnvelope

  /// Creates a value from its parts.
  public init(form: Form?, envelope: ObjectEnvelope = ObjectEnvelope()) {
    self.form = form
    self.envelope = envelope
  }

  /// Makes the `color` form.
  public static func color(_ value: ColorValue) -> Fill {
    Fill(.color(value))
  }

  /// Makes the `gradient` form.
  public static func gradient(_ value: GradientFill) -> Fill {
    Fill(.gradient(value))
  }

  /// Makes the `image` form.
  public static func image(_ value: ImageFill) -> Fill {
    Fill(.image(value))
  }

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "color": .color(try ColorValue(wire: contents))
    case "gradient": .gradient(try GradientFill(wire: contents))
    case "image": .image(try ImageFill(wire: contents))
    default: nil
    }
  }

  /// Names the case of a form, with its contents, or nil for a form that has none.
  public static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .color(let value): ("color", value.wireValue)
    case .gradient(let value): ("gradient", value.wireValue)
    case .image(let value): ("image", value.wireValue)
    }
  }
}
