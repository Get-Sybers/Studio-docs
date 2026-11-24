import Foundation
import TextModel
import WireFormat

extension CharacterProperties {
  /// Italic, bold and strikethrough as Foundation's semantic attribute, where each is switched on.
  var presentationIntent: InlinePresentationIntent {
    var intent: InlinePresentationIntent = []
    if italic == .value(true) { intent.insert(.emphasized) }
    if bold == .value(true) { intent.insert(.stronglyEmphasized) }
    if let line = strikethrough.value, line != .off { intent.insert(.strikethrough) }
    return intent
  }

  /// The underline, where one is switched on.
  var underlineMark: UnderlineStyle? {
    guard let line = underline.value, line != .off else { return nil }
    return line
  }

  /// The properties with the four switches set as the attributes of a run say.
  ///
  /// A switch that the attributes turn off goes back to inheriting; one that was already off stays as it was.
  func applying(intent: InlinePresentationIntent, underline mark: UnderlineStyle?) -> CharacterProperties {
    var properties = self
    if intent.contains(.emphasized) {
      properties.italic = .value(true)
    } else if italic == .value(true) {
      properties.italic = .inherited
    }
    if intent.contains(.stronglyEmphasized) {
      properties.bold = .value(true)
    } else if bold == .value(true) {
      properties.bold = .inherited
    }
    let struck = strikethrough.value.map { $0 != .off } ?? false
    if intent.contains(.strikethrough), !struck {
      properties.strikethrough = .value(.single)
    } else if !intent.contains(.strikethrough), struck {
      properties.strikethrough = .inherited
    }
    if let mark {
      properties.underline = .value(mark)
    } else if underlineMark != nil {
      properties.underline = .inherited
    }
    return properties
  }
}
