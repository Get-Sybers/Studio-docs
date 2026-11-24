public import JSONTree
public import WireFormat

/// Where a link leads.
public struct Hyperlink: WireUnion {
  /// The forms that the library models; each is kept out of line, so the value stays small.
  public indirect enum Form: Sendable, Hashable {
    /// A file: a path or a file URL.
    case file(String)
    /// An action of the reader, by its name.
    case program(String)
    /// Another slide of the same presentation.
    case slideJump(SlideTarget)
    /// An absolute URL of any scheme but `file`.
    case url(String)
  }

  /// The facts of the type, from the format table.
  public static let schema = TextFormat.table.union(named: "Hyperlink")

  /// The form the value takes; nil when a preset supplies it or the library does not model it.
  public var form: Form?
  /// The version and preset of the value, and its members beside the form.
  public var envelope: ObjectEnvelope

  /// Creates a value from its parts.
  public init(form: Form?, envelope: ObjectEnvelope = ObjectEnvelope()) {
    self.form = form
    self.envelope = envelope
  }

  /// Makes the `file` form.
  public static func file(_ value: String) -> Hyperlink {
    Hyperlink(.file(value))
  }

  /// Makes the `program` form.
  public static func program(_ value: String) -> Hyperlink {
    Hyperlink(.program(value))
  }

  /// Makes the `slide_jump` form.
  public static func slideJump(_ value: SlideTarget) -> Hyperlink {
    Hyperlink(.slideJump(value))
  }

  /// Makes the `url` form.
  public static func url(_ value: String) -> Hyperlink {
    Hyperlink(.url(value))
  }

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "file": .file(try String(wire: contents))
    case "program": .program(try String(wire: contents))
    case "slide_jump": .slideJump(try SlideTarget(wire: contents))
    case "url": .url(try String(wire: contents))
    default: nil
    }
  }

  /// Names the case of a form, with its contents, or nil for a form that has none.
  public static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .file(let value): ("file", value.wireValue)
    case .program(let value): ("program", value.wireValue)
    case .slideJump(let value): ("slide_jump", value.wireValue)
    case .url(let value): ("url", value.wireValue)
    }
  }
}
