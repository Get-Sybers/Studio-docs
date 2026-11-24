public import WireFormat

/// Where text sits between the top and the bottom of its container.
public struct VerticalTextAlignment: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// At the bottom.
  public static let bottom = VerticalTextAlignment(rawValue: "bottom")
  /// In the middle.
  public static let center = VerticalTextAlignment(rawValue: "center")
  /// At the top.
  public static let top = VerticalTextAlignment(rawValue: "top")

  /// The values that the library knows, from the format table.
  public static let modelled = TextFormat.table.values(of: "VerticalTextAlignment").map(
    VerticalTextAlignment.init(rawValue:))
}
