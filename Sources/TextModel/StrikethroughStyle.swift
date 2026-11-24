public import WireFormat

/// The line through a run of text.
public struct StrikethroughStyle: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// Two lines.
  public static let double = StrikethroughStyle(rawValue: "double")
  /// No line.
  public static let off = StrikethroughStyle(rawValue: "none")
  /// One line.
  public static let single = StrikethroughStyle(rawValue: "single")

  /// The values that the library knows, from the format table.
  public static let modelled = TextFormat.table.values(of: "StrikethroughStyle").map(StrikethroughStyle.init(rawValue:))
}
