public import WireFormat

/// The enumeration `SlideObjectPlaceholderInfoPlaceholderDefinitionKind` of the format.
public struct PlaceholderKind: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The value `body`.
  public static let body = PlaceholderKind(rawValue: "body")
  /// The value `object`.
  public static let object = PlaceholderKind(rawValue: "object")
  /// The value `slide_number`.
  public static let slideNumber = PlaceholderKind(rawValue: "slide_number")
  /// The value `title`.
  public static let title = PlaceholderKind(rawValue: "title")

  /// The values that the library knows, from the format table.
  public static let modelled = PresentationModelFormat.table.values(of: "PlaceholderKind").map(
    PlaceholderKind.init(rawValue:))
}
