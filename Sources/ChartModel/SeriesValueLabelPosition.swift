public import WireFormat

/// The enumeration `SeriesValueLabelPosition` of the format.
public struct SeriesValueLabelPosition: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The value `auto`.
  public static let auto = SeriesValueLabelPosition(rawValue: "auto")
  /// The value `bottom`.
  public static let bottom = SeriesValueLabelPosition(rawValue: "bottom")
  /// The value `bottom_left`.
  public static let bottomLeft = SeriesValueLabelPosition(rawValue: "bottom_left")
  /// The value `bottom_right`.
  public static let bottomRight = SeriesValueLabelPosition(rawValue: "bottom_right")
  /// The value `center`.
  public static let center = SeriesValueLabelPosition(rawValue: "center")
  /// The value `inside`.
  public static let inside = SeriesValueLabelPosition(rawValue: "inside")
  /// The value `inside_bottom`.
  public static let insideBottom = SeriesValueLabelPosition(rawValue: "inside_bottom")
  /// The value `inside_left`.
  public static let insideLeft = SeriesValueLabelPosition(rawValue: "inside_left")
  /// The value `inside_right`.
  public static let insideRight = SeriesValueLabelPosition(rawValue: "inside_right")
  /// The value `inside_top`.
  public static let insideTop = SeriesValueLabelPosition(rawValue: "inside_top")
  /// The value `left`.
  public static let left = SeriesValueLabelPosition(rawValue: "left")
  /// The value `outside`.
  public static let outside = SeriesValueLabelPosition(rawValue: "outside")
  /// The value `outside_top`.
  public static let outsideTop = SeriesValueLabelPosition(rawValue: "outside_top")
  /// The value `right`.
  public static let right = SeriesValueLabelPosition(rawValue: "right")
  /// The value `top`.
  public static let top = SeriesValueLabelPosition(rawValue: "top")
  /// The value `top_left`.
  public static let topLeft = SeriesValueLabelPosition(rawValue: "top_left")
  /// The value `top_right`.
  public static let topRight = SeriesValueLabelPosition(rawValue: "top_right")

  /// The values that the library knows, from the format table.
  public static let modelled = ChartModelFormat.table.values(of: "SeriesValueLabelPosition").map(
    SeriesValueLabelPosition.init(rawValue:))
}
