public import Appearance
public import WireFormat

/// The properties of characters: font, weight, lines, colour and the rest.
///
/// A member left `.inherited` comes from the preset, then from the paragraph; `.cleared` writes `null`.
public struct CharacterProperties: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TextFormat.table.object(named: "CharacterProperties")

  /// The colour behind the text.
  public var backgroundColor: Inheritable<ColorValue>
  /// Whether the text is a subscript or a superscript.
  public var baseline: Inheritable<Baseline>
  /// How far the baseline moves, in points; upward when positive.
  public var baselineShift: Inheritable<Double>
  /// Whether the text is bold.
  public var bold: Inheritable<Bool>
  /// How the capitals of the text are changed when it is shown.
  public var capitalization: Inheritable<Capitalization>
  /// What fills the characters: a colour, a gradient or an image.
  public var characterFill: Inheritable<Fill>
  /// Whether a gradient fill is measured across the whole container.
  public var characterFillShouldFillContainer: Inheritable<Bool>
  /// The name of the font that was replaced when the text came from another format.
  public var compatibilityFontName: Inheritable<String>
  /// The mark set beside characters for emphasis in Japanese text.
  public var emphasisMark: Inheritable<String>
  /// The typographic features of the font that are in use.
  public var fontFeatures: Inheritable<[FontFeature]>
  /// The PostScript name of the font.
  public var fontName: Inheritable<String>
  /// The size of the font, in points.
  public var fontSize: Inheritable<Double>
  /// Whether the size is one of the named Chinese font sizes.
  public var isNamedPointSize: Inheritable<Bool>
  /// Whether the text is italic.
  public var italic: Inheritable<Bool>
  /// The language of the text, as a tag such as `en-GB`.
  public var language: Inheritable<String>
  /// Which ligatures are used.
  public var ligatures: Inheritable<Ligatures>
  /// The shadow of the characters.
  public var shadow: Inheritable<Shadow>
  /// The line through the text, which alone decides whether one shows.
  public var strikethrough: Inheritable<StrikethroughStyle>
  /// The colour of the line through the text; cleared, it takes the colour of the text.
  public var strikethroughColor: Inheritable<ColorValue>
  /// The thickness of the line through the text, as a multiple of the font's own.
  public var strikethroughWidth: Inheritable<Double>
  /// The outline of the characters.
  public var stroke: Inheritable<TextStroke>
  /// The space added between characters, as a fraction of the font's em.
  public var tracking: Inheritable<Double>
  /// The line under the text, which alone decides whether one shows.
  public var underline: Inheritable<UnderlineStyle>
  /// The colour of the line under the text; cleared, it takes the colour of the text.
  public var underlineColor: Inheritable<ColorValue>
  /// Whether the line through the text skips white space.
  public var wordStrikethrough: Inheritable<Bool>
  /// Whether the line under the text skips white space.
  public var wordUnderline: Inheritable<Bool>
  /// The direction of the text.
  public var writingDirection: Inheritable<WritingDirection>
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates character properties; a member left out is absent from the JSON.
  public init(
    backgroundColor: Inheritable<ColorValue> = .inherited, baseline: Inheritable<Baseline> = .inherited,
    baselineShift: Inheritable<Double> = .inherited, bold: Inheritable<Bool> = .inherited,
    capitalization: Inheritable<Capitalization> = .inherited, characterFill: Inheritable<Fill> = .inherited,
    characterFillShouldFillContainer: Inheritable<Bool> = .inherited,
    compatibilityFontName: Inheritable<String> = .inherited, emphasisMark: Inheritable<String> = .inherited,
    fontFeatures: Inheritable<[FontFeature]> = .inherited, fontName: Inheritable<String> = .inherited,
    fontSize: Inheritable<Double> = .inherited, isNamedPointSize: Inheritable<Bool> = .inherited,
    italic: Inheritable<Bool> = .inherited, language: Inheritable<String> = .inherited,
    ligatures: Inheritable<Ligatures> = .inherited, shadow: Inheritable<Shadow> = .inherited,
    strikethrough: Inheritable<StrikethroughStyle> = .inherited,
    strikethroughColor: Inheritable<ColorValue> = .inherited, strikethroughWidth: Inheritable<Double> = .inherited,
    stroke: Inheritable<TextStroke> = .inherited, tracking: Inheritable<Double> = .inherited,
    underline: Inheritable<UnderlineStyle> = .inherited, underlineColor: Inheritable<ColorValue> = .inherited,
    wordStrikethrough: Inheritable<Bool> = .inherited, wordUnderline: Inheritable<Bool> = .inherited,
    writingDirection: Inheritable<WritingDirection> = .inherited
  ) {
    self.backgroundColor = backgroundColor
    self.baseline = baseline
    self.baselineShift = baselineShift
    self.bold = bold
    self.capitalization = capitalization
    self.characterFill = characterFill
    self.characterFillShouldFillContainer = characterFillShouldFillContainer
    self.compatibilityFontName = compatibilityFontName
    self.emphasisMark = emphasisMark
    self.fontFeatures = fontFeatures
    self.fontName = fontName
    self.fontSize = fontSize
    self.isNamedPointSize = isNamedPointSize
    self.italic = italic
    self.language = language
    self.ligatures = ligatures
    self.shadow = shadow
    self.strikethrough = strikethrough
    self.strikethroughColor = strikethroughColor
    self.strikethroughWidth = strikethroughWidth
    self.stroke = stroke
    self.tracking = tracking
    self.underline = underline
    self.underlineColor = underlineColor
    self.wordStrikethrough = wordStrikethrough
    self.wordUnderline = wordUnderline
    self.writingDirection = writingDirection
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    backgroundColor = try reader.inheritable("background_color")
    baseline = try reader.inheritable("baseline")
    baselineShift = try reader.inheritable("baseline_shift")
    bold = try reader.inheritable("bold")
    capitalization = try reader.inheritable("capitalization")
    characterFill = try reader.inheritable("character_fill")
    characterFillShouldFillContainer = try reader.inheritable("character_fill_should_fill_container")
    compatibilityFontName = try reader.inheritable("compatibility_font_name")
    emphasisMark = try reader.inheritable("emphasis_mark")
    fontFeatures = try reader.inheritable("font_features")
    fontName = try reader.inheritable("font_name")
    fontSize = try reader.inheritable("font_size")
    isNamedPointSize = try reader.inheritable("is_named_point_size")
    italic = try reader.inheritable("italic")
    language = try reader.inheritable("language")
    ligatures = try reader.inheritable("ligatures")
    shadow = try reader.inheritable("shadow")
    strikethrough = try reader.inheritable("strikethrough")
    strikethroughColor = try reader.inheritable("strikethrough_color")
    strikethroughWidth = try reader.inheritable("strikethrough_width")
    stroke = try reader.inheritable("stroke")
    tracking = try reader.inheritable("tracking")
    underline = try reader.inheritable("underline")
    underlineColor = try reader.inheritable("underline_color")
    wordStrikethrough = try reader.inheritable("word_strikethrough")
    wordUnderline = try reader.inheritable("word_underline")
    writingDirection = try reader.inheritable("writing_direction")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.inheritable("background_color", backgroundColor)
    writer.inheritable("baseline", baseline)
    writer.inheritable("baseline_shift", baselineShift)
    writer.inheritable("bold", bold)
    writer.inheritable("capitalization", capitalization)
    writer.inheritable("character_fill", characterFill)
    writer.inheritable("character_fill_should_fill_container", characterFillShouldFillContainer)
    writer.inheritable("compatibility_font_name", compatibilityFontName)
    writer.inheritable("emphasis_mark", emphasisMark)
    writer.inheritable("font_features", fontFeatures)
    writer.inheritable("font_name", fontName)
    writer.inheritable("font_size", fontSize)
    writer.inheritable("is_named_point_size", isNamedPointSize)
    writer.inheritable("italic", italic)
    writer.inheritable("language", language)
    writer.inheritable("ligatures", ligatures)
    writer.inheritable("shadow", shadow)
    writer.inheritable("strikethrough", strikethrough)
    writer.inheritable("strikethrough_color", strikethroughColor)
    writer.inheritable("strikethrough_width", strikethroughWidth)
    writer.inheritable("stroke", stroke)
    writer.inheritable("tracking", tracking)
    writer.inheritable("underline", underline)
    writer.inheritable("underline_color", underlineColor)
    writer.inheritable("word_strikethrough", wordStrikethrough)
    writer.inheritable("word_underline", wordUnderline)
    writer.inheritable("writing_direction", writingDirection)
  }
}
