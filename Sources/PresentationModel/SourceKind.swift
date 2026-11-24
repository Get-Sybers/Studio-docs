public import WireFormat

/// The enumeration `SourceKind` of the format.
public struct SourceKind: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The value `layout`.
  public static let layout = SourceKind(rawValue: "layout")
  /// The value `placeholder`.
  public static let placeholder = SourceKind(rawValue: "placeholder")
  /// The value `user`.
  public static let user = SourceKind(rawValue: "user")

  /// The values that the library knows, from the format table.
  public static let modelled = PresentationModelFormat.table.values(of: "SourceKind").map(SourceKind.init(rawValue:))
}
