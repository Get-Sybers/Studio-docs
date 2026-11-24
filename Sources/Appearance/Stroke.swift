public import JSONTree
public import WireFormat

/// What is drawn along an outline: a line, a picture frame, or nothing.
public struct Stroke: WireUnion {
  /// The forms that the library models; each is kept out of line, so the value stays small.
  public indirect enum Form: Sendable, Hashable {
    /// Nothing.
    case empty
    /// A picture frame.
    case frame(PictureFrame)
    /// A line.
    case line(LineStroke)
  }

  /// The facts of the type, from the format table.
  public static let schema = AppearanceFormat.table.union(named: "Stroke")

  /// The form the value takes; nil when a preset supplies it or the library does not model it.
  public var form: Form?
  /// The version and preset of the value, and its members beside the form.
  public var envelope: ObjectEnvelope

  /// Creates a value from its parts.
  public init(form: Form?, envelope: ObjectEnvelope = ObjectEnvelope()) {
    self.form = form
    self.envelope = envelope
  }

  /// The `empty` form.
  public static let empty = Stroke(.empty)

  /// Makes the `frame` form.
  public static func frame(_ value: PictureFrame) -> Stroke {
    Stroke(.frame(value))
  }

  /// Makes the `line` form.
  public static func line(_ value: LineStroke) -> Stroke {
    Stroke(.line(value))
  }

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "empty": .empty
    case "frame": .frame(try PictureFrame(wire: contents))
    case "line": .line(try LineStroke(wire: contents))
    default: nil
    }
  }

  /// Names the case of a form, with its contents, or nil for a form that has none.
  public static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .empty: ("empty", nil)
    case .frame(let value): ("frame", value.wireValue)
    case .line(let value): ("line", value.wireValue)
    }
  }
}
