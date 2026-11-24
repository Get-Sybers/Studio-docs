public import WireFormat

/// The enumeration `ConnectionLineType` of the format.
public struct ConnectionLineType: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The value `curved`.
  public static let curved = ConnectionLineType(rawValue: "curved")
  /// The value `none`.
  public static let off = ConnectionLineType(rawValue: "none")
  /// The value `straight`.
  public static let straight = ConnectionLineType(rawValue: "straight")

  /// The values that the library knows, from the format table.
  public static let modelled = ChartModelFormat.table.values(of: "ConnectionLineType").map(
    ConnectionLineType.init(rawValue:))
}
