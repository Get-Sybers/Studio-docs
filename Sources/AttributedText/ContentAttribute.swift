public import Foundation
public import TextModel

/// The attribute that carries an element of a paragraph without its text: a run or a link with its style.
///
/// On U+FFFC it carries an inline object, or an element that the library does not model, whole.
public enum ContentAttribute: CodableAttributedStringKey {
  /// A run or a link whose string is empty, or an element with no text of its own.
  public typealias Value = ParagraphContent

  /// The name of the attribute.
  public static let name = "io.github.get-sybers.studio-docs.content"
}
