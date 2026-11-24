public import JSONTree
public import WireFormat

/// How a gradient lays out its stops.
public struct GradientFlavor: WireUnion {
  /// The forms that the library models; each is kept out of line, so the value stays small.
  public indirect enum Form: Sendable, Hashable {
    /// Along a straight line.
    case linear(LinearFlavor)
    /// Outward from a centre.
    case radial(RadialFlavor)
  }

  /// The facts of the type, from the format table.
  public static let schema = AppearanceFormat.table.union(named: "GradientFlavor")

  /// The form the value takes; nil when a preset supplies it or the library does not model it.
  public var form: Form?
  /// The version and preset of the value, and its members beside the form.
  public var envelope: ObjectEnvelope

  /// Creates a value from its parts.
  public init(form: Form?, envelope: ObjectEnvelope = ObjectEnvelope()) {
    self.form = form
    self.envelope = envelope
  }

  /// Makes the `linear` form.
  public static func linear(_ value: LinearFlavor) -> GradientFlavor {
    GradientFlavor(.linear(value))
  }

  /// Makes the `radial` form.
  public static func radial(_ value: RadialFlavor) -> GradientFlavor {
    GradientFlavor(.radial(value))
  }

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "linear": .linear(try LinearFlavor(wire: contents))
    case "radial": .radial(try RadialFlavor(wire: contents))
    default: nil
    }
  }

  /// Names the case of a form, with its contents, or nil for a form that has none.
  public static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .linear(let value): ("linear", value.wireValue)
    case .radial(let value): ("radial", value.wireValue)
    }
  }
}
