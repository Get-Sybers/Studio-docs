public import WireFormat

/// The type `title-owning-generic` of the format.
public struct GenericTitleOwning: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = CanvasCommonFormat.table.object(named: "GenericTitleOwning")

  /// The `title` member; kept out of line, so the value stays small.
  public var title: Indirect<Label>?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(title: Label? = nil) {
    self.title = title.map(Indirect.init)
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    title = try reader.optional("title")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("title", title)
  }
}
