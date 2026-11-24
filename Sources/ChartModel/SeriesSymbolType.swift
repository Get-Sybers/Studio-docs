public import WireFormat

/// The enumeration `SeriesSymbolType` of the format.
public struct SeriesSymbolType: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The value `circle`.
  public static let circle = SeriesSymbolType(rawValue: "circle")
  /// The value `diamond`.
  public static let diamond = SeriesSymbolType(rawValue: "diamond")
  /// The value `none`.
  public static let off = SeriesSymbolType(rawValue: "none")
  /// The value `plus`.
  public static let plus = SeriesSymbolType(rawValue: "plus")
  /// The value `square`.
  public static let square = SeriesSymbolType(rawValue: "square")
  /// The value `triangle`.
  public static let triangle = SeriesSymbolType(rawValue: "triangle")
  /// The value `x`.
  public static let x = SeriesSymbolType(rawValue: "x")
  /// The value `yield`.
  public static let yield = SeriesSymbolType(rawValue: "yield")

  /// The values that the library knows, from the format table.
  public static let modelled = ChartModelFormat.table.values(of: "SeriesSymbolType").map(
    SeriesSymbolType.init(rawValue:))
}
