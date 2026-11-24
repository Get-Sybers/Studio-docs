public import Foundation
public import TextModel

/// The attribute that says a run is underlined, and how; Foundation has none of its own.
public enum UnderlineAttribute: CodableAttributedStringKey {
  /// The style of the line; never `off`.
  public typealias Value = UnderlineStyle

  /// The name of the attribute.
  public static let name = "io.github.get-sybers.studio-docs.underline"
}
