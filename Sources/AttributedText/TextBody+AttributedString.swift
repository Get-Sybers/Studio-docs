public import Foundation
public import TextModel
import WireFormat

extension TextBody {
  /// Reads an attributed string back into a body of paragraphs.
  public init(_ text: AttributedString) {
    self.init(.paragraphs([Paragraph](text)))
  }
}
