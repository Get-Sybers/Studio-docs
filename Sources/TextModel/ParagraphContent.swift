public import JSONTree
public import WireFormat

/// One element of a paragraph: a run of text, a link, or an object set in the line.
public struct ParagraphContent: WireUnion {
  /// The forms that the library models.
  public enum Form: Sendable, Hashable {
    /// A link with its text.
    case hyperlink(HyperlinkField)
    /// An object set in the line; the library keeps it as JSON and does not model it.
    case inlineObject(JSONValue)
    /// A run of text in one style.
    case run(TextRun)
  }

  /// The facts of the type, from the format table.
  public static let schema = TextFormat.table.union(named: "ParagraphContent")

  /// The form the value takes; nil when a preset supplies it or the library does not model it.
  public var form: Form?
  /// The version and preset of the value, and its members beside the form.
  public var envelope: ObjectEnvelope

  /// Creates a value from its parts.
  public init(form: Form?, envelope: ObjectEnvelope = ObjectEnvelope()) {
    self.form = form
    self.envelope = envelope
  }

  /// Makes the `hyperlink` form.
  public static func hyperlink(_ value: HyperlinkField) -> ParagraphContent {
    ParagraphContent(.hyperlink(value))
  }

  /// Makes the `inline_object` form.
  public static func inlineObject(_ value: JSONValue) -> ParagraphContent {
    ParagraphContent(.inlineObject(value))
  }

  /// Makes the `run` form.
  public static func run(_ value: TextRun) -> ParagraphContent {
    ParagraphContent(.run(value))
  }

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "hyperlink": .hyperlink(try HyperlinkField(wire: contents))
    case "inline_object": .inlineObject(try JSONValue(wire: contents))
    case "run": .run(try TextRun(wire: contents))
    default: nil
    }
  }

  /// Names the case of a form, with its contents, or nil for a form that has none.
  public static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .hyperlink(let value): ("hyperlink", value.wireValue)
    case .inlineObject(let value): ("inline_object", value.wireValue)
    case .run(let value): ("run", value.wireValue)
    }
  }
}
