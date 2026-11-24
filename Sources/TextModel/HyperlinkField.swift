public import WireFormat

/// A link: where it leads and the run of text that shows it.
public struct HyperlinkField: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TextFormat.table.object(named: "HyperlinkField")

  /// Where the link leads.
  public var target: Hyperlink
  /// The text shown as the link.
  public var run: TextRun
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a link; a member left out is absent from the JSON.
  public init(target: Hyperlink, run: TextRun) {
    self.target = target
    self.run = run
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    target = try reader.required("target")
    run = try reader.required("run")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("target", target)
    writer.required("run", run)
  }
}
