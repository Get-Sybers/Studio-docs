public import WireFormat

/// The enumeration `PresetKind` of the format.
public struct ConditionalStylePreset: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The value `blue_fill`.
  public static let blueFill = ConditionalStylePreset(rawValue: "blue_fill")
  /// The value `blue_text`.
  public static let blueText = ConditionalStylePreset(rawValue: "blue_text")
  /// The value `bold`.
  public static let bold = ConditionalStylePreset(rawValue: "bold")
  /// The value `custom`.
  public static let custom = ConditionalStylePreset(rawValue: "custom")
  /// The value `gray_text`.
  public static let grayText = ConditionalStylePreset(rawValue: "gray_text")
  /// The value `green_fill`.
  public static let greenFill = ConditionalStylePreset(rawValue: "green_fill")
  /// The value `green_text`.
  public static let greenText = ConditionalStylePreset(rawValue: "green_text")
  /// The value `italics`.
  public static let italics = ConditionalStylePreset(rawValue: "italics")
  /// The value `orange_fill`.
  public static let orangeFill = ConditionalStylePreset(rawValue: "orange_fill")
  /// The value `red_fill`.
  public static let redFill = ConditionalStylePreset(rawValue: "red_fill")
  /// The value `red_text`.
  public static let redText = ConditionalStylePreset(rawValue: "red_text")
  /// The value `teal_fill`.
  public static let tealFill = ConditionalStylePreset(rawValue: "teal_fill")
  /// The value `yellow_fill`.
  public static let yellowFill = ConditionalStylePreset(rawValue: "yellow_fill")

  /// The values that the library knows, from the format table.
  public static let modelled = TableModelFormat.table.values(of: "ConditionalStylePreset").map(
    ConditionalStylePreset.init(rawValue:))
}
