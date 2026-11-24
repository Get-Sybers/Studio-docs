public import WireFormat

/// Whether a run sits on the line, below it or above it.
public struct Baseline: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// On the line.
  public static let normal = Baseline(rawValue: "default")
  /// Below the line, at a reduced size.
  public static let subscripted = Baseline(rawValue: "subscript")
  /// Above the line, at a reduced size.
  public static let superscripted = Baseline(rawValue: "superscript")

  /// The values that the library knows, from the format table.
  public static let modelled = TextFormat.table.values(of: "Baseline").map(Baseline.init(rawValue:))
}
