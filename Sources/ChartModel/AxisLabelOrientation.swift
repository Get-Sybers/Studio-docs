public import JSONTree
public import WireFormat

/// The union `chart-axis-common.axis-label-orientation` of the format.
public struct AxisLabelOrientation: WireUnion {
  /// The forms that the library models; each is kept out of line, so the value stays small.
  public indirect enum Form: Sendable, Hashable {
    /// The `custom` form.
    case custom(Double)
    /// The `horizontal` form.
    case horizontal
    /// The `left_diagonal` form.
    case leftDiagonal
    /// The `left_vertical` form.
    case leftVertical
    /// The `parallel` form.
    case parallel
    /// The `perpendicular` form.
    case perpendicular
    /// The `right_diagonal` form.
    case rightDiagonal
    /// The `right_vertical` form.
    case rightVertical
  }

  /// The facts of the type, from the format table.
  public static let schema = ChartModelFormat.table.union(named: "AxisLabelOrientation")

  /// The form the value takes; nil when a preset supplies it or the library does not model it.
  public var form: Form?
  /// The version and preset of the value, and its members beside the form.
  public var envelope: ObjectEnvelope

  /// Creates a value from its parts.
  public init(form: Form?, envelope: ObjectEnvelope = ObjectEnvelope()) {
    self.form = form
    self.envelope = envelope
  }

  /// Makes the `custom` form.
  public static func custom(_ value: Double) -> AxisLabelOrientation {
    AxisLabelOrientation(.custom(value))
  }

  /// The `horizontal` form.
  public static let horizontal = AxisLabelOrientation(.horizontal)

  /// The `left_diagonal` form.
  public static let leftDiagonal = AxisLabelOrientation(.leftDiagonal)

  /// The `left_vertical` form.
  public static let leftVertical = AxisLabelOrientation(.leftVertical)

  /// The `parallel` form.
  public static let parallel = AxisLabelOrientation(.parallel)

  /// The `perpendicular` form.
  public static let perpendicular = AxisLabelOrientation(.perpendicular)

  /// The `right_diagonal` form.
  public static let rightDiagonal = AxisLabelOrientation(.rightDiagonal)

  /// The `right_vertical` form.
  public static let rightVertical = AxisLabelOrientation(.rightVertical)

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "custom": .custom(try Double(wire: contents))
    case "horizontal": .horizontal
    case "left_diagonal": .leftDiagonal
    case "left_vertical": .leftVertical
    case "parallel": .parallel
    case "perpendicular": .perpendicular
    case "right_diagonal": .rightDiagonal
    case "right_vertical": .rightVertical
    default: nil
    }
  }

  /// Names the case of a form, with its contents, or nil for a form that has none.
  public static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .custom(let value): ("custom", value.wireValue)
    case .horizontal: ("horizontal", nil)
    case .leftDiagonal: ("left_diagonal", nil)
    case .leftVertical: ("left_vertical", nil)
    case .parallel: ("parallel", nil)
    case .perpendicular: ("perpendicular", nil)
    case .rightDiagonal: ("right_diagonal", nil)
    case .rightVertical: ("right_vertical", nil)
    }
  }
}
