public import WireFormat

/// The type `caption-owning-generic` of the format.
public struct GenericCaptionOwning: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = CanvasCommonFormat.table.object(named: "GenericCaptionOwning")

  /// The `caption` member; kept out of line, so the value stays small.
  public var caption: Indirect<Label>?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(caption: Label? = nil) {
    self.caption = caption.map(Indirect.init)
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    caption = try reader.optional("caption")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("caption", caption)
  }
}
