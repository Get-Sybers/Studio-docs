public import WireFormat

/// The horizontal alignment of a paragraph.
public struct ParagraphAlignment: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// Centred.
  public static let center = ParagraphAlignment(rawValue: "center")
  /// Flush on both sides.
  public static let justified = ParagraphAlignment(rawValue: "justified")
  /// Flush left.
  public static let left = ParagraphAlignment(rawValue: "left")
  /// Decided by the content: in a table cell, words sit at the leading side and numbers at the trailing side.
  public static let natural = ParagraphAlignment(rawValue: "natural")
  /// Flush right.
  public static let right = ParagraphAlignment(rawValue: "right")

  /// The values that the library knows, from the format table.
  public static let modelled = TextFormat.table.values(of: "ParagraphAlignment").map(ParagraphAlignment.init(rawValue:))
}
