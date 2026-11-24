public import WireFormat

/// The break that ends a paragraph.
///
/// A reader that keeps text as one string ends every paragraph but the last with a break of some kind.
public struct ParagraphBreak: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The text resumes in the next column.
  public static let column = ParagraphBreak(rawValue: "column")
  /// No break; only the last paragraph of a text may lack one.
  public static let unterminated = ParagraphBreak(rawValue: "none")
  /// A paragraph break that keeps the next paragraph from being a topic or a list item.
  public static let nontopic = ParagraphBreak(rawValue: "nontopic")
  /// The text resumes on the next page.
  public static let page = ParagraphBreak(rawValue: "page")
  /// An ordinary paragraph break, the default before the last paragraph.
  public static let paragraph = ParagraphBreak(rawValue: "para")
  /// The text resumes in the next section.
  public static let section = ParagraphBreak(rawValue: "section")

  /// The values that the library knows, from the format table.
  public static let modelled = TextFormat.table.values(of: "ParagraphBreak").map(ParagraphBreak.init(rawValue:))
}
