public import WireFormat

/// The numerals or letters of a numbered list.
public struct NumberingSystem: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// Latin letters.
  public static let alpha = NumberingSystem(rawValue: "alpha")
  /// Arabic-Indic digits.
  public static let arabian = NumberingSystem(rawValue: "arabian")
  /// Abjad numerals.
  public static let arabianAbjad = NumberingSystem(rawValue: "arabian_abjad")
  /// Arabic letters in alphabetical order.
  public static let arabianAlpha = NumberingSystem(rawValue: "arabian_alpha")
  /// Hebrew letters in alphabetical order.
  public static let hebrew = NumberingSystem(rawValue: "hebrew")
  /// Hebrew numerals.
  public static let hebrewBiblical = NumberingSystem(rawValue: "hebrew_biblical")
  /// Hiragana in a-i-u-e-o order.
  public static let hiragana = NumberingSystem(rawValue: "hiragana")
  /// Hiragana in iroha order.
  public static let hiraganaIroha = NumberingSystem(rawValue: "hiragana_iroha")
  /// Japanese ideographic numerals.
  public static let japanese = NumberingSystem(rawValue: "japanese")
  /// Katakana in a-i-u-e-o order.
  public static let katakana = NumberingSystem(rawValue: "katakana")
  /// Katakana in iroha order.
  public static let katakanaIroha = NumberingSystem(rawValue: "katakana_iroha")
  /// Korean syllables.
  public static let korean = NumberingSystem(rawValue: "korean")
  /// Western digits, the default.
  public static let numeric = NumberingSystem(rawValue: "numeric")
  /// Roman numerals.
  public static let roman = NumberingSystem(rawValue: "roman")
  /// Simplified Chinese ideographic numerals.
  public static let simplifiedChinese = NumberingSystem(rawValue: "simplified_chinese")
  /// Traditional Chinese ideographic numerals.
  public static let traditionalChinese = NumberingSystem(rawValue: "traditional_chinese")

  /// The values that the library knows, from the format table.
  public static let modelled = TextFormat.table.values(of: "NumberingSystem").map(NumberingSystem.init(rawValue:))
}
