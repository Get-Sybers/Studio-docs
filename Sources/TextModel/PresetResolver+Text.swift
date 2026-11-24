public import PresetStyles
import WireFormat

extension PresetResolver {
  /// Creates a resolver for text: it knows the format's defaults, and looks in a stylesheet before the library.
  public init(_ library: PresetLibrary, stylesheet: Stylesheet?) {
    self.init(library, schemas: .text, styles: stylesheet?.namedProperties ?? [:])
  }

  /// The paragraph properties in effect for a paragraph: its own, then those of its presets.
  public func paragraphProperties(of paragraph: Paragraph) throws(PresetError) -> ParagraphProperties {
    try effective(paragraph.style ?? ParagraphProperties())
  }

  /// The character properties in effect for a run: its own and its presets', then those its paragraph gives.
  public func characterProperties(of run: TextRun, in paragraph: Paragraph) throws(PresetError) -> CharacterProperties {
    let given = try paragraph.style.map { style throws(PresetError) in
      try effective(style, applyingDefaults: false).characterProperties
    }
    return try effective(run.style ?? CharacterProperties(), over: [given ?? nil].compactMap { $0 })
  }
}
