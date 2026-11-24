import BitCollections
import JSONTree

extension ObjectEnvelope {
  /// Checks the type that an object names, and returns the version it declares, marking both as taken.
  static func header(
    of object: JSONObject, type: TypeIdentifier, modelled: FormatVersion, taken: inout BitSet
  ) throws(WireError) -> FormatVersion? {
    if let position = object.position(of: EnvelopeMember.typeIdentifier) {
      let found = object.member(at: position).value
      guard found.stringValue == type.rawValue else {
        throw .typeMismatch(expected: type, found: found.stringValue ?? found.kind.rawValue, at: .root)
      }
      taken.insert(position)
    }
    // A version that does not parse stays among the unmodelled members, and is written back as it was.
    guard let position = object.position(of: EnvelopeMember.version),
      let declared = object.member(at: position).value.stringValue.flatMap(FormatVersion.init)
    else { return nil }
    guard declared.major <= modelled.major else {
      throw .unsupportedVersion(type: type, declared: declared, modelled: modelled, at: .root)
    }
    taken.insert(position)
    return declared
  }

  /// Gathers the envelope from the members that the type did not take.
  init(of object: JSONObject, declared: FormatVersion?, taken: BitSet) {
    self.init(version: declared)
    for position in 0..<object.count where !taken.contains(position) {
      let (name, value) = object.member(at: position)
      switch (name, value) {
      case (EnvelopeMember.presetIdentifier, .string(let preset)): presetIdentifier = preset
      case (EnvelopeMember.identifier, .string(let text)): identifier = ObjectID(rawValue: text)
      default: unmodelled[name] = value
      }
    }
  }

  /// Adds the envelope to the members that a type has written, which keep their place over unmodelled ones.
  func write(
    into members: inout JSONObject, type: TypeIdentifier, needed: FormatVersion, modelsIdentifier: Bool = false
  ) {
    for (name, value) in unmodelled where !members.contains(name) {
      members[name] = value
    }
    members[EnvelopeMember.typeIdentifier] = .string(type.rawValue)
    if let version {
      members[EnvelopeMember.version] = .string(max(version, needed).description)
    } else if needed.major > FormatVersion.initial.major {
      // A reader of major 1 reads an object that declares nothing; a member of a later major forbids that.
      members[EnvelopeMember.version] = .string(needed.description)
    }
    if let presetIdentifier {
      members[EnvelopeMember.presetIdentifier] = .string(presetIdentifier)
    }
    if let identifier, !modelsIdentifier {
      members[EnvelopeMember.identifier] = .string(identifier.rawValue)
    }
  }
}
