public import WireFormat

/// The direction in which text is laid out.
public struct WritingDirection: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// From left to right.
  public static let leftToRight = WritingDirection(rawValue: "left_to_right")
  /// As the context says: the paragraph style, then the document.
  public static let natural = WritingDirection(rawValue: "natural")
  /// From right to left.
  public static let rightToLeft = WritingDirection(rawValue: "right_to_left")

  /// The values that the library knows, from the format table.
  public static let modelled = TextFormat.table.values(of: "WritingDirection").map(WritingDirection.init(rawValue:))
}
