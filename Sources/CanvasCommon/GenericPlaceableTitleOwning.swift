public import WireFormat

/// The type `placeable-title-owning-generic` of the format.
public struct GenericPlaceableTitleOwning: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = CanvasCommonFormat.table.object(named: "GenericPlaceableTitleOwning")

  /// The `title` member; kept out of line, so the value stays small.
  public var title: Indirect<Label>?
  /// The `title_is_positioned_on_top` member; true when omitted.
  public var titleIsPositionedOnTop: Bool?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(title: Label? = nil, titleIsPositionedOnTop: Bool? = nil) {
    self.title = title.map(Indirect.init)
    self.titleIsPositionedOnTop = titleIsPositionedOnTop
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    title = try reader.optional("title")
    titleIsPositionedOnTop = try reader.optional("title_is_positioned_on_top")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("title", title)
    writer.optional("title_is_positioned_on_top", titleIsPositionedOnTop)
  }
}
