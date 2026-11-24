public import Appearance
public import JSONTree
public import WireFormat

/// The union `connection-line.line-type` of the format.
public struct ConnectionLineKind: WireUnion {
  /// The forms that the library models; each is kept out of line, so the value stays small.
  public indirect enum Form: Sendable, Hashable {
    /// The `corner` form.
    case corner(PositionValue)
    /// The `curved` form.
    case curved(PositionValue)
    /// The `straight` form.
    case straight
  }

  /// The facts of the type, from the format table.
  public static let schema = CanvasModelFormat.table.union(named: "ConnectionLineKind")

  /// The form the value takes; nil when a preset supplies it or the library does not model it.
  public var form: Form?
  /// The version and preset of the value, and its members beside the form.
  public var envelope: ObjectEnvelope

  /// Creates a value from its parts.
  public init(form: Form?, envelope: ObjectEnvelope = ObjectEnvelope()) {
    self.form = form
    self.envelope = envelope
  }

  /// Makes the `corner` form.
  public static func corner(_ value: PositionValue) -> ConnectionLineKind {
    ConnectionLineKind(.corner(value))
  }

  /// Makes the `curved` form.
  public static func curved(_ value: PositionValue) -> ConnectionLineKind {
    ConnectionLineKind(.curved(value))
  }

  /// The `straight` form.
  public static let straight = ConnectionLineKind(.straight)

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "corner": .corner(try PositionValue(wire: contents))
    case "curved": .curved(try PositionValue(wire: contents))
    case "straight": .straight
    default: nil
    }
  }

  /// Names the case of a form, with its contents, or nil for a form that has none.
  public static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .corner(let value): ("corner", value.wireValue)
    case .curved(let value): ("curved", value.wireValue)
    case .straight: ("straight", nil)
    }
  }
}
