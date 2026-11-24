public import JSONTree
public import WireFormat

/// A body of text: paragraphs, one plain string, or runs.
public struct TextBody: WireUnion {
  /// The forms that the library models; each is kept out of line, so the value stays small.
  public indirect enum Form: Sendable, Hashable {
    /// Paragraphs, each with its own properties and contents.
    case paragraphs([Paragraph])
    /// Plain text in one style.
    case string(String)
    /// Runs of text, each in one style, with no paragraph properties.
    case runs([TextRun])
  }

  /// The facts of the type, from the format table.
  public static let schema = TextFormat.table.union(named: "TextBody")

  /// The form the value takes; nil when a preset supplies it or the library does not model it.
  public var form: Form?
  /// The version and preset of the value, and its members beside the form.
  public var envelope: ObjectEnvelope

  /// Creates a value from its parts.
  public init(form: Form?, envelope: ObjectEnvelope = ObjectEnvelope()) {
    self.form = form
    self.envelope = envelope
  }

  /// Makes the `paragraphs` form.
  public static func paragraphs(_ value: [Paragraph]) -> TextBody {
    TextBody(.paragraphs(value))
  }

  /// Makes the `string` form.
  public static func string(_ value: String) -> TextBody {
    TextBody(.string(value))
  }

  /// Makes the `text_runs` form.
  public static func runs(_ value: [TextRun]) -> TextBody {
    TextBody(.runs(value))
  }

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "paragraphs": .paragraphs(try [Paragraph](wire: contents))
    case "string": .string(try String(wire: contents))
    case "text_runs": .runs(try [TextRun](wire: contents))
    default: nil
    }
  }

  /// Names the case of a form, with its contents, or nil for a form that has none.
  public static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .paragraphs(let value): ("paragraphs", value.wireValue)
    case .string(let value): ("string", value.wireValue)
    case .runs(let value): ("text_runs", value.wireValue)
    }
  }
}
