public import Foundation

extension AttributeScopes {
  /// The attributes by which the library carries its text model in an attributed string, with Foundation's own.
  public struct StudioTextAttributes: AttributeScope {
    /// The paragraph that a character belongs to, without its contents.
    public let paragraph: ParagraphAttribute
    /// The run or link that a character belongs to, without its text.
    public let content: ContentAttribute
    /// The underline of a character.
    public let underline: UnderlineAttribute
    /// Foundation's attributes, of which the library uses the inline presentation intent and the link.
    public let foundation: FoundationAttributes
  }

  /// The scope of the library's attributes.
  public var studioText: StudioTextAttributes.Type { StudioTextAttributes.self }
}
