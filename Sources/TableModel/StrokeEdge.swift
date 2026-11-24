public import WireFormat

/// The enumeration `Edge` of the format.
public struct StrokeEdge: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The value `bottom`.
  public static let bottom = StrokeEdge(rawValue: "bottom")
  /// The value `horizontal`.
  public static let horizontal = StrokeEdge(rawValue: "horizontal")
  /// The value `left`.
  public static let left = StrokeEdge(rawValue: "left")
  /// The value `right`.
  public static let right = StrokeEdge(rawValue: "right")
  /// The value `top`.
  public static let top = StrokeEdge(rawValue: "top")
  /// The value `vertical`.
  public static let vertical = StrokeEdge(rawValue: "vertical")

  /// The values that the library knows, from the format table.
  public static let modelled = TableModelFormat.table.values(of: "StrokeEdge").map(StrokeEdge.init(rawValue:))
}
