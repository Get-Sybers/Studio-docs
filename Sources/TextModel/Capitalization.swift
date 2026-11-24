public import WireFormat

/// How a reader changes the capitals of text when it shows it.
public struct Capitalization: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// Every letter as a capital.
  public static let allCaps = Capitalization(rawValue: "all_caps")
  /// No change.
  public static let asWritten = Capitalization(rawValue: "none")
  /// Every letter as a capital, the written capitals taller.
  public static let smallCaps = Capitalization(rawValue: "small_caps")
  /// The first letter of every word as a capital.
  public static let start = Capitalization(rawValue: "start")
  /// As a title, by the rules of the language.
  public static let title = Capitalization(rawValue: "title")

  /// The values that the library knows, from the format table.
  public static let modelled = TextFormat.table.values(of: "Capitalization").map(Capitalization.init(rawValue:))
}
