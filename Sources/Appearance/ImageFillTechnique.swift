public import WireFormat

/// How an image covers the area it fills.
public struct ImageFillTechnique: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// Once, at its own size, centred and clipped.
  public static let naturalSize = ImageFillTechnique(rawValue: "natural_size")
  /// Scaled in proportion until it covers the area.
  public static let scaleToFill = ImageFillTechnique(rawValue: "scale_to_fill")
  /// Scaled in proportion until it fits inside the area.
  public static let scaleToFit = ImageFillTechnique(rawValue: "scale_to_fit")
  /// Stretched to the area, out of proportion if need be.
  public static let stretch = ImageFillTechnique(rawValue: "stretch")
  /// Repeated at its own size from the top left corner.
  public static let tile = ImageFillTechnique(rawValue: "tile")

  /// The values that the library knows, from the format table.
  public static let modelled = AppearanceFormat.table.values(of: "ImageFillTechnique").map(
    ImageFillTechnique.init(rawValue:))
}
