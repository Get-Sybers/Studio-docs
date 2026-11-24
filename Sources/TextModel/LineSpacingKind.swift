public import WireFormat

/// How the amount of a line spacing is read.
public struct LineSpacingKind: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// Points added between lines.
  public static let between = LineSpacingKind(rawValue: "between")
  /// The distance from line to line, in points.
  public static let exact = LineSpacingKind(rawValue: "exact")
  /// The greatest distance from line to line, in points.
  public static let maximum = LineSpacingKind(rawValue: "maximum")
  /// The least distance from line to line, in points.
  public static let minimum = LineSpacingKind(rawValue: "minimum")
  /// A multiple of the natural line height, the default.
  public static let relative = LineSpacingKind(rawValue: "relative")

  /// The values that the library knows, from the format table.
  public static let modelled = TextFormat.table.values(of: "LineSpacingKind").map(LineSpacingKind.init(rawValue:))
}
