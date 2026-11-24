public import JSONTree
public import WireFormat

/// The union `chart-category-axis.label-spacing` of the format.
public struct LabelSpacing: WireUnion {
  /// The forms that the library models; each is kept out of line, so the value stays small.
  public indirect enum Form: Sendable, Hashable {
    /// The `auto_fit` form.
    case autoFit
    /// The `custom` form.
    case custom(Int)
    /// The `none` form.
    case absent
    /// The `show_all` form.
    case showAll
  }

  /// The facts of the type, from the format table.
  public static let schema = ChartModelFormat.table.union(named: "LabelSpacing")

  /// The form the value takes; nil when a preset supplies it or the library does not model it.
  public var form: Form?
  /// The version and preset of the value, and its members beside the form.
  public var envelope: ObjectEnvelope

  /// Creates a value from its parts.
  public init(form: Form?, envelope: ObjectEnvelope = ObjectEnvelope()) {
    self.form = form
    self.envelope = envelope
  }

  /// The `auto_fit` form.
  public static let autoFit = LabelSpacing(.autoFit)

  /// Makes the `custom` form.
  public static func custom(_ value: Int) -> LabelSpacing {
    LabelSpacing(.custom(value))
  }

  /// The `none` form.
  public static let absent = LabelSpacing(.absent)

  /// The `show_all` form.
  public static let showAll = LabelSpacing(.showAll)

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "auto_fit": .autoFit
    case "custom": .custom(try Int(wire: contents))
    case "none": .absent
    case "show_all": .showAll
    default: nil
    }
  }

  /// Names the case of a form, with its contents, or nil for a form that has none.
  public static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .autoFit: ("auto_fit", nil)
    case .custom(let value): ("custom", value.wireValue)
    case .absent: ("none", nil)
    case .showAll: ("show_all", nil)
    }
  }
}
