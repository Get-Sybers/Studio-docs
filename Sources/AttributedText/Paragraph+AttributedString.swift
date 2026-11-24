public import Foundation
public import TextModel

extension Paragraph {
  /// Replaces the contents with those that an attributed string spells; its properties and identifier stay.
  ///
  /// Where the string holds a paragraph separator, what follows it is left out.
  public mutating func replaceContents(with text: AttributedString) {
    contents = [Paragraph](text).first?.contents
  }
}
