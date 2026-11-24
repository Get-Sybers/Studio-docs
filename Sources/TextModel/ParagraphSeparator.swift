/// The characters that end a paragraph in text kept as one string, as Foundation and TextKit read it.
///
/// U+2028, the line separator, is none of them: it breaks a line inside a paragraph.
public enum ParagraphSeparator {
  /// U+000A, U+000D and U+2029; a carriage return with a line feed after it counts once.
  public static let scalars: [Unicode.Scalar] = ["\u{000A}", "\u{000D}", "\u{2029}"]

  /// Whether a character ends a paragraph.
  public static func ends(_ character: Character) -> Bool {
    character.unicodeScalars.contains { scalars.contains($0) }
  }

  /// The first separator in a text, if it holds one.
  public static func first(in text: String) -> Unicode.Scalar? {
    text.unicodeScalars.first { scalars.contains($0) }
  }

  /// Splits a text where a paragraph ends; a text with no separator comes back whole.
  public static func split(_ text: String) -> [Substring] {
    text.split(omittingEmptySubsequences: false, whereSeparator: ends)
  }
}
