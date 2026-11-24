public import WireFormat

/// How text meets a tab stop.
public struct TabAlignment: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// Centred on the stop.
  public static let center = TabAlignment(rawValue: "center")
  /// With its decimal separator on the stop.
  public static let decimal = TabAlignment(rawValue: "decimal")
  /// Starting at the stop, the default.
  public static let left = TabAlignment(rawValue: "left")
  /// Ending at the stop.
  public static let right = TabAlignment(rawValue: "right")

  /// The values that the library knows, from the format table.
  public static let modelled = TextFormat.table.values(of: "TabAlignment").map(TabAlignment.init(rawValue:))
}
