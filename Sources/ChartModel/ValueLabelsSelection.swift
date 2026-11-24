public import WireFormat

/// The enumeration `ValueLabelsSelection` of the format.
public struct ValueLabelsSelection: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The value `none`.
  public static let off = ValueLabelsSelection(rawValue: "none")
  /// The value `size`.
  public static let size = ValueLabelsSelection(rawValue: "size")
  /// The value `x`.
  public static let x = ValueLabelsSelection(rawValue: "x")
  /// The value `x_and_y`.
  public static let xAndY = ValueLabelsSelection(rawValue: "x_and_y")
  /// The value `y`.
  public static let y = ValueLabelsSelection(rawValue: "y")

  /// The values that the library knows, from the format table.
  public static let modelled = ChartModelFormat.table.values(of: "ValueLabelsSelection").map(
    ValueLabelsSelection.init(rawValue:))
}
