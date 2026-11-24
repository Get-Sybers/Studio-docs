public import WireFormat

/// The type `keynote-theme` of the format.
public struct KeynoteTheme: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = PresentationModelFormat.table.object(named: "KeynoteTheme")

  /// The `name` member.
  public var name: String?
  /// The `locale` member.
  public var locale: String?
  /// The `slide_layouts` member.
  public var slideLayouts: [SlideLayout]?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(name: String? = nil, locale: String? = nil, slideLayouts: [SlideLayout]? = nil) {
    self.name = name
    self.locale = locale
    self.slideLayouts = slideLayouts
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    name = try reader.optional("name")
    locale = try reader.optional("locale")
    slideLayouts = try reader.optional("slide_layouts")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("name", name)
    writer.optional("locale", locale)
    writer.optional("slide_layouts", slideLayouts)
  }
}
