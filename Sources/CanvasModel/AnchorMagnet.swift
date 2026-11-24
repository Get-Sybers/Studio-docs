public import Appearance
public import JSONTree
public import WireFormat

/// The union `connection-line.end.anchor.magnet` of the format.
public struct AnchorMagnet: WireUnion {
  /// The forms that the library models; each is kept out of line, so the value stays small.
  public indirect enum Form: Sendable, Hashable {
    /// The `center` form.
    case center
    /// The `east` form.
    case east
    /// The `edge` form.
    case edge(PositionValue)
    /// The `floating` form.
    case floating(PositionValue)
    /// The `north` form.
    case north
    /// The `south` form.
    case south
    /// The `west` form.
    case west
  }

  /// The facts of the type, from the format table.
  public static let schema = CanvasModelFormat.table.union(named: "AnchorMagnet")

  /// The form the value takes; nil when a preset supplies it or the library does not model it.
  public var form: Form?
  /// The version and preset of the value, and its members beside the form.
  public var envelope: ObjectEnvelope

  /// Creates a value from its parts.
  public init(form: Form?, envelope: ObjectEnvelope = ObjectEnvelope()) {
    self.form = form
    self.envelope = envelope
  }

  /// The `center` form.
  public static let center = AnchorMagnet(.center)

  /// The `east` form.
  public static let east = AnchorMagnet(.east)

  /// Makes the `edge` form.
  public static func edge(_ value: PositionValue) -> AnchorMagnet {
    AnchorMagnet(.edge(value))
  }

  /// Makes the `floating` form.
  public static func floating(_ value: PositionValue) -> AnchorMagnet {
    AnchorMagnet(.floating(value))
  }

  /// The `north` form.
  public static let north = AnchorMagnet(.north)

  /// The `south` form.
  public static let south = AnchorMagnet(.south)

  /// The `west` form.
  public static let west = AnchorMagnet(.west)

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "center": .center
    case "east": .east
    case "edge": .edge(try PositionValue(wire: contents))
    case "floating": .floating(try PositionValue(wire: contents))
    case "north": .north
    case "south": .south
    case "west": .west
    default: nil
    }
  }

  /// Names the case of a form, with its contents, or nil for a form that has none.
  public static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .center: ("center", nil)
    case .east: ("east", nil)
    case .edge(let value): ("edge", value.wireValue)
    case .floating(let value): ("floating", value.wireValue)
    case .north: ("north", nil)
    case .south: ("south", nil)
    case .west: ("west", nil)
    }
  }
}
