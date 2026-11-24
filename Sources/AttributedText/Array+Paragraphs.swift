public import Foundation
public import TextModel

extension Array where Element == Paragraph {
  /// Reads an attributed string back into paragraphs, one for each stretch that a paragraph separator ends.
  ///
  /// A paragraph takes its identifier from its first character; after a split two carry one, and the caller mints.
  public init(_ text: AttributedString) {
    self = ParagraphAssembler(text).paragraphs
  }
}
