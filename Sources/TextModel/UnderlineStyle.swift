public import WireFormat

/// The line under a run of text.
public struct UnderlineStyle: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// Two lines.
  public static let double = UnderlineStyle(rawValue: "double")
  /// No line.
  public static let off = UnderlineStyle(rawValue: "none")
  /// One line.
  public static let single = UnderlineStyle(rawValue: "single")
  /// A wavy line.
  public static let wavy = UnderlineStyle(rawValue: "wavy")

  /// The values that the library knows, from the format table.
  public static let modelled = TextFormat.table.values(of: "UnderlineStyle").map(UnderlineStyle.init(rawValue:))
}
