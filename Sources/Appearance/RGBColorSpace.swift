public import WireFormat

/// The colour space in which the components of a colour are read.
public struct RGBColorSpace: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// Display P3.
  public static let p3 = RGBColorSpace(rawValue: "p3")
  /// sRGB, the default.
  public static let srgb = RGBColorSpace(rawValue: "srgb")

  /// The values that the library knows, from the format table.
  public static let modelled = AppearanceFormat.table.values(of: "RGBColorSpace").map(RGBColorSpace.init(rawValue:))
}
