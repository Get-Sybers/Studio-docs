public import WireFormat

/// The pattern of a line stroke.
public struct StrokePattern: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// As if drawn with a calligraphy pen.
  public static let calligraphy = StrokePattern(rawValue: "calligraphy")
  /// As if drawn with chalk.
  public static let chalk = StrokePattern(rawValue: "chalk")
  /// As if painted with a dry brush.
  public static let dryBrush = StrokePattern(rawValue: "dry_brush")
  /// As if painted with a feathered brush.
  public static let featheredBrush = StrokePattern(rawValue: "feathered_brush")
  /// Long dashes.
  public static let longDash = StrokePattern(rawValue: "long_dash")
  /// Dashes of middle length.
  public static let mediumDash = StrokePattern(rawValue: "medium_dash")
  /// As if drawn with a pen of uneven flow.
  public static let pen = StrokePattern(rawValue: "pen")
  /// Round dots.
  public static let roundDash = StrokePattern(rawValue: "round_dash")
  /// Short dashes.
  public static let shortDash = StrokePattern(rawValue: "short_dash")
  /// An unbroken line, the default.
  public static let solid = StrokePattern(rawValue: "solid")

  /// The values that the library knows, from the format table.
  public static let modelled = AppearanceFormat.table.values(of: "StrokePattern").map(StrokePattern.init(rawValue:))
}
