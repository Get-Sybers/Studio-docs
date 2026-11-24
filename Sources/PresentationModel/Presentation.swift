public import Appearance
public import TextModel
public import WireFormat

/// The type `presentation` of the format.
public struct Presentation: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = PresentationModelFormat.table.object(named: "Presentation")

  /// The `theme` member.
  public var theme: KeynoteTheme?
  /// The `slide_size` member.
  public var slideSize: SizeValue?
  /// The `slides` member.
  public var slides: [Slide]
  /// The `stylesheet` member.
  public var stylesheet: Stylesheet?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(theme: KeynoteTheme? = nil, slideSize: SizeValue? = nil, slides: [Slide], stylesheet: Stylesheet? = nil) {
    self.theme = theme
    self.slideSize = slideSize
    self.slides = slides
    self.stylesheet = stylesheet
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    theme = try reader.optional("theme")
    slideSize = try reader.optional("slide_size")
    slides = try reader.required("slides")
    stylesheet = try reader.optional("stylesheet")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("theme", theme)
    writer.optional("slide_size", slideSize)
    writer.required("slides", slides)
    writer.optional("stylesheet", stylesheet)
  }
}
