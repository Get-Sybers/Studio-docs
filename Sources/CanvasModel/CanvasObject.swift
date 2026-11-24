public import ChartModel
public import JSONTree
public import TableModel
public import WireFormat

/// The union `canvas-object` of the format.
public struct CanvasObject: WireUnion {
  /// The forms that the library models; each is kept out of line, so the value stays small.
  public indirect enum Form: Sendable, Hashable {
    /// The `audio` form.
    case audio(Audio)
    /// The `chart` form.
    case chart(Chart)
    /// The `connectionLine` form.
    case connectionLine(ConnectionLine)
    /// The `genericCanvasObject` form.
    case genericCanvasObject(GenericCanvasObject)
    /// The `group` form.
    case group(Group)
    /// The `image` form.
    case image(Image)
    /// The `movie` form.
    case movie(Movie)
    /// The `shape` form.
    case shape(Shape)
    /// The `table` form.
    case table(Table)
    /// The `textbox` form.
    case textbox(Textbox)
  }

  /// The facts of the type, from the format table.
  public static let schema = CanvasModelFormat.table.union(named: "CanvasObject")

  /// The form the value takes; nil when a preset supplies it or the library does not model it.
  public var form: Form?
  /// The version and preset of the value, and its members beside the form.
  public var envelope: ObjectEnvelope

  /// Creates a value from its parts.
  public init(form: Form?, envelope: ObjectEnvelope = ObjectEnvelope()) {
    self.form = form
    self.envelope = envelope
  }

  /// Makes the `audio` form.
  public static func audio(_ value: Audio) -> CanvasObject {
    CanvasObject(.audio(value))
  }

  /// Makes the `chart` form.
  public static func chart(_ value: Chart) -> CanvasObject {
    CanvasObject(.chart(value))
  }

  /// Makes the `connectionLine` form.
  public static func connectionLine(_ value: ConnectionLine) -> CanvasObject {
    CanvasObject(.connectionLine(value))
  }

  /// Makes the `genericCanvasObject` form.
  public static func genericCanvasObject(_ value: GenericCanvasObject) -> CanvasObject {
    CanvasObject(.genericCanvasObject(value))
  }

  /// Makes the `group` form.
  public static func group(_ value: Group) -> CanvasObject {
    CanvasObject(.group(value))
  }

  /// Makes the `image` form.
  public static func image(_ value: Image) -> CanvasObject {
    CanvasObject(.image(value))
  }

  /// Makes the `movie` form.
  public static func movie(_ value: Movie) -> CanvasObject {
    CanvasObject(.movie(value))
  }

  /// Makes the `shape` form.
  public static func shape(_ value: Shape) -> CanvasObject {
    CanvasObject(.shape(value))
  }

  /// Makes the `table` form.
  public static func table(_ value: Table) -> CanvasObject {
    CanvasObject(.table(value))
  }

  /// Makes the `textbox` form.
  public static func textbox(_ value: Textbox) -> CanvasObject {
    CanvasObject(.textbox(value))
  }

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "audio": .audio(try Audio(wire: contents))
    case "chart": .chart(try Chart(wire: contents))
    case "connectionLine": .connectionLine(try ConnectionLine(wire: contents))
    case "genericCanvasObject": .genericCanvasObject(try GenericCanvasObject(wire: contents))
    case "group": .group(try Group(wire: contents))
    case "image": .image(try Image(wire: contents))
    case "movie": .movie(try Movie(wire: contents))
    case "shape": .shape(try Shape(wire: contents))
    case "table": .table(try Table(wire: contents))
    case "textbox": .textbox(try Textbox(wire: contents))
    default: nil
    }
  }

  /// Names the case of a form, with its contents, or nil for a form that has none.
  public static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .audio(let value): ("audio", value.wireValue)
    case .chart(let value): ("chart", value.wireValue)
    case .connectionLine(let value): ("connectionLine", value.wireValue)
    case .genericCanvasObject(let value): ("genericCanvasObject", value.wireValue)
    case .group(let value): ("group", value.wireValue)
    case .image(let value): ("image", value.wireValue)
    case .movie(let value): ("movie", value.wireValue)
    case .shape(let value): ("shape", value.wireValue)
    case .table(let value): ("table", value.wireValue)
    case .textbox(let value): ("textbox", value.wireValue)
    }
  }
}
