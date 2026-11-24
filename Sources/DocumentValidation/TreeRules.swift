import JSONTree
import PresetStyles
import ResourceReferences
import TextModel
import WireFormat

/// The rules that hold for any object that names its type: what its schema requires, permits and bounds.
enum TreeRules {
  private static let envelope: Set<String> = [
    "type_identifier", "version", "preset_identifier", "identifier", "primary_case",
  ]
  private static let styleTypes: Set<String> = [
    NamedCharacterStyle.typeIdentifier.rawValue, NamedParagraphStyle.typeIdentifier.rawValue,
    NamedListStyle.typeIdentifier.rawValue,
  ]

  static func walk(
    _ tree: JSONValue, below prefix: JSONPath, input: ValidationInput, resolver: PresetResolver,
    into collector: inout FindingCollector
  ) {
    tree.walk(from: prefix) { value, steps in
      switch value {
      case .number(let number):
        if !number.isFinite { collector.report(.nonFiniteNumber, at: JSONPath(steps)) }
      case .object(let object):
        check(object, at: JSONPath(steps), input: input, resolver: resolver, into: &collector)
      case .null, .bool, .string, .array:
        break
      }
    }
  }

  private static func check(
    _ object: JSONObject, at path: JSONPath, input: ValidationInput, resolver: PresetResolver,
    into collector: inout FindingCollector
  ) {
    let adopted = object["preset_identifier"]?.stringValue
    guard let name = object["type_identifier"]?.stringValue else {
      if let adopted { collector.adoptions.append((adopted, collector.part, path)) }
      return
    }
    // A named style's preset identifier is the name of the style, which other objects adopt.
    if let adopted {
      if styleTypes.contains(name) {
        collector.styleNames.insert(adopted)
      } else {
        collector.adoptions.append((adopted, collector.part, path))
      }
    }
    let type = TypeIdentifier(rawValue: name)
    if let schema = input.schemas.object(type) {
      checkVersion(of: object, type: type, modelled: schema.version, at: path, into: &collector)
      for member in schema.members {
        check(member, of: object, type: type, isAdopting: adopted != nil, at: path, into: &collector)
      }
    } else if let schema = input.schemas.union(type) {
      checkVersion(of: object, type: type, modelled: schema.version, at: path, into: &collector)
      let cases = Set(schema.cases.map(\.name))
      let others = object.keys.filter { !envelope.contains($0) && !cases.contains($0) }
      if adopted == nil, others.isEmpty, !object.keys.contains(where: cases.contains) {
        collector.report(.unionWithoutForm(type: type), at: path)
      }
      if let primary = object["primary_case"]?.stringValue, !cases.contains(primary) {
        collector.report(.unmodelledPrimaryCase(type: type, name: primary), at: path.member("primary_case"))
      }
    }
    if type == IndirectResource.typeIdentifier {
      checkStoredName(of: object, at: path, input: input, resolver: resolver, into: &collector)
    }
    ModelledChecks.registry[type]?(.object(object), path, &collector)
  }

  private static func checkVersion(
    of object: JSONObject, type: TypeIdentifier, modelled: FormatVersion, at path: JSONPath,
    into collector: inout FindingCollector
  ) {
    guard let version = object["version"] else { return }
    guard let declared = version.stringValue.flatMap(FormatVersion.init) else {
      collector.report(.malformedVersion(version.stringValue ?? version.kind.rawValue), at: path.member("version"))
      return
    }
    // A later major version fails to read, and is reported as that.
    if declared > modelled, declared.major == modelled.major {
      collector.report(.newerVersion(type: type, declared: declared, modelled: modelled), at: path.member("version"))
    }
  }

  private static func check(
    _ member: ObjectSchema.Member, of object: JSONObject, type: TypeIdentifier, isAdopting: Bool, at path: JSONPath,
    into collector: inout FindingCollector
  ) {
    guard let value = object[member.name] else {
      // A preset may supply what the object leaves out.
      if member.kind == .required, !isAdopting {
        collector.report(.missingMember(type: type, member: member.name), at: path)
      }
      return
    }
    let place = path.member(member.name)
    switch value {
    case .null:
      if member.kind != .inheritable {
        collector.report(.nullNotPermitted(type: type, member: member.name), at: place)
      }
    case .number(let number):
      let amount = number.doubleValue
      if amount < member.minimum ?? amount || amount > member.maximum ?? amount {
        collector.report(.numberOutOfRange(type: type, member: member.name, value: amount), at: place)
      }
    case .array(let elements):
      if elements.count < member.minimumCount ?? 0 || elements.count > member.maximumCount ?? elements.count {
        collector.report(.countOutOfRange(type: type, member: member.name, count: elements.count), at: place)
      }
    case .bool, .string, .object:
      break
    }
  }

  private static func checkStoredName(
    of object: JSONObject, at path: JSONPath, input: ValidationInput, resolver: PresetResolver,
    into collector: inout FindingCollector
  ) {
    // The name may come from a preset; a preset that does not resolve is reported on its own account.
    var members = object
    if object.contains("preset_identifier"), let resolved = try? resolver.resolved(.object(object)).objectValue {
      members = resolved
    }
    let member = members["identifier"]?.stringValue == nil ? "filename" : "identifier"
    guard let name = members[member]?.stringValue else { return }
    guard !name.allSatisfy(\.isWhitespace) else {
      collector.report(.blankResourceName(member: member), at: path.member(member))
      return
    }
    if member == "identifier", let filename = members["filename"]?.stringValue, filename.allSatisfy(\.isWhitespace) {
      collector.report(.blankResourceName(member: "filename"), at: path.member("filename"))
    }
    if !input.resourceNames.contains(name) {
      collector.report(.missingResource(name: name), at: path.member(member))
    }
  }
}
