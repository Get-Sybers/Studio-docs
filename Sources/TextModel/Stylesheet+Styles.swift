public import JSONTree
public import WireFormat

extension Stylesheet {
  /// The text styles by type and by the preset identifier that names each, in the form a preset resolver takes.
  ///
  /// A style with no preset identifier has no name that text can refer to, and is left out.
  public var namedProperties: [TypeIdentifier: [String: JSONObject]] {
    var named: [TypeIdentifier: [String: JSONObject]] = [:]
    func add(_ type: TypeIdentifier, _ name: String?, _ properties: JSONValue) {
      guard let name, var members = properties.objectValue else { return }
      members.removeValue(forKey: "type_identifier")
      named[type, default: [:]][name] = members
    }
    for style in characterStyles ?? [] {
      add(CharacterProperties.typeIdentifier, style.presetIdentifier, style.properties.wireValue)
    }
    for style in paragraphStyles ?? [] {
      add(ParagraphProperties.typeIdentifier, style.presetIdentifier, style.properties.wireValue)
    }
    for style in listStyles ?? [] {
      add(ListProperties.typeIdentifier, style.presetIdentifier, style.properties.wireValue)
    }
    return named
  }
}
