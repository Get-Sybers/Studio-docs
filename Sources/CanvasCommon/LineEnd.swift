public import WireFormat

/// The enumeration `LineEnd` of the format.
public struct LineEnd: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The value `filled_arrow`.
  public static let filledArrow = LineEnd(rawValue: "filled_arrow")
  /// The value `filled_circle`.
  public static let filledCircle = LineEnd(rawValue: "filled_circle")
  /// The value `filled_diamond`.
  public static let filledDiamond = LineEnd(rawValue: "filled_diamond")
  /// The value `filled_square`.
  public static let filledSquare = LineEnd(rawValue: "filled_square")
  /// The value `inverted_arrow`.
  public static let invertedArrow = LineEnd(rawValue: "inverted_arrow")
  /// The value `line`.
  public static let line = LineEnd(rawValue: "line")
  /// The value `none`.
  public static let off = LineEnd(rawValue: "none")
  /// The value `open_arrow`.
  public static let openArrow = LineEnd(rawValue: "open_arrow")
  /// The value `open_circle`.
  public static let openCircle = LineEnd(rawValue: "open_circle")
  /// The value `open_square`.
  public static let openSquare = LineEnd(rawValue: "open_square")
  /// The value `simple_arrow`.
  public static let simpleArrow = LineEnd(rawValue: "simple_arrow")

  /// The values that the library knows, from the format table.
  public static let modelled = CanvasCommonFormat.table.values(of: "LineEnd").map(LineEnd.init(rawValue:))
}
