public import Foundation
public import TextModel

/// The attribute that carries a paragraph without its contents: its properties, its break and its identifier.
///
/// It is bound to the paragraph, so Foundation keeps one value from each paragraph's first character to its end.
public enum ParagraphAttribute: CodableAttributedStringKey {
  /// A paragraph whose `contents` are nil.
  public typealias Value = Paragraph

  /// The name of the attribute.
  public static let name = "io.github.get-sybers.studio-docs.paragraph"

  /// The attribute holds one value across a paragraph.
  public static let runBoundaries: AttributedString.AttributeRunBoundaries? = .paragraph
}
