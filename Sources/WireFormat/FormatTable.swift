import Foundation
package import JSONTree

/// The format table of one target: the schema of every type it models, read from its `format.json`.
package struct FormatTable: Sendable {
  /// The object schemas, by the name of the Swift type that models each.
  package let objects: [String: ObjectSchema]
  /// The union schemas, by the name of the Swift type that models each.
  package let unions: [String: UnionSchema]
  /// The values of each enumeration, by the name of the Swift type that models it.
  package let enumerations: [String: [String]]
  private let target: String

  private struct File: Decodable {
    var enumerations: [Enumeration]?
    var objects: [Entry]
    var unions: [Entry]
  }

  private struct Enumeration: Decodable {
    var name: String
    var values: [String]
  }

  private struct Entry: Decodable {
    var type: String
    var name: String
    var version: FormatVersion
    var members: [Part]?
    var cases: [Part]?
  }

  private struct Part: Decodable {
    var name: String
    var kind: ObjectSchema.Member.Kind?
    var since: FormatVersion?
    var `default`: JSONValue?
    var minimum: Double?
    var maximum: Double?
    var minimumCount: Int?
    var maximumCount: Int?
    var valueless: Bool?
  }

  /// A table that does not hold what the format requires of it.
  package enum Defect: Error, Sendable, Hashable {
    case repeatedName(String)
    case repeatedPart(type: String, part: String)
    case partNewerThanType(type: String, part: String)
    case emptyRange(type: String, part: String)
    case objectWithoutMembers(String)
    case unionWithoutCases(String)
    case enumerationWithoutValues(String)
  }

  /// Decodes a table and checks what its shape cannot express.
  package init(decoding bytes: [UInt8], target: String) throws {
    let file = try JSONDecoder().decode(File.self, from: Data(bytes))
    var objects: [String: ObjectSchema] = [:]
    var unions: [String: UnionSchema] = [:]
    var names: Set<String> = []
    var enumerations: [String: [String]] = [:]
    for listed in file.enumerations ?? [] {
      guard names.insert(listed.name).inserted else { throw Defect.repeatedName(listed.name) }
      guard !listed.values.isEmpty else { throw Defect.enumerationWithoutValues(listed.name) }
      guard let repeated = listed.values.first(where: { value in listed.values.count { $0 == value } > 1 }) else {
        enumerations[listed.name] = listed.values
        continue
      }
      throw Defect.repeatedPart(type: listed.name, part: repeated)
    }
    for entry in file.objects + file.unions {
      guard names.insert(entry.name).inserted, names.insert(entry.type).inserted else {
        throw Defect.repeatedName(entry.name)
      }
      var parts: Set<String> = []
      for part in entry.members ?? entry.cases ?? [] {
        guard parts.insert(part.name).inserted else { throw Defect.repeatedPart(type: entry.name, part: part.name) }
        guard part.since ?? .initial <= entry.version else {
          throw Defect.partNewerThanType(type: entry.name, part: part.name)
        }
        if let minimum = part.minimum, let maximum = part.maximum, minimum > maximum {
          throw Defect.emptyRange(type: entry.name, part: part.name)
        }
      }
    }
    for entry in file.objects {
      guard let members = entry.members else { throw Defect.objectWithoutMembers(entry.name) }
      objects[entry.name] = ObjectSchema(
        typeIdentifier: TypeIdentifier(rawValue: entry.type), version: entry.version,
        members: members.map { part in
          ObjectSchema.Member(
            part.name, kind: part.kind ?? .optional, since: part.since ?? .initial, defaultValue: part.default,
            minimum: part.minimum, maximum: part.maximum, minimumCount: part.minimumCount,
            maximumCount: part.maximumCount)
        })
    }
    for entry in file.unions {
      guard let cases = entry.cases, !cases.isEmpty else { throw Defect.unionWithoutCases(entry.name) }
      unions[entry.name] = UnionSchema(
        typeIdentifier: TypeIdentifier(rawValue: entry.type), version: entry.version,
        cases: cases.map { UnionSchema.Case($0.name, since: $0.since ?? .initial, isValueless: $0.valueless ?? false) })
    }
    self.objects = objects
    self.unions = unions
    self.enumerations = enumerations
    self.target = target
  }

  /// Decodes the table that a target embeds; a table that does not decode is a defect of the package itself.
  package init(embedded bytes: [UInt8], target: String) {
    do {
      try self.init(decoding: bytes, target: target)
    } catch {
      preconditionFailure("the format table that \(target) embeds does not decode: \(error)")
    }
  }

  /// The schema of the object type that a Swift type models.
  package func object(named name: String) -> ObjectSchema {
    guard let schema = objects[name] else {
      preconditionFailure("the format table of \(target) lists no object named \(name)")
    }
    return schema
  }

  /// The values of the enumeration that a Swift type models.
  package func values(of name: String) -> [String] {
    guard let values = enumerations[name] else {
      preconditionFailure("the format table of \(target) lists no enumeration named \(name)")
    }
    return values
  }

  /// The schema of the union type that a Swift type models.
  package func union(named name: String) -> UnionSchema {
    guard let schema = unions[name] else {
      preconditionFailure("the format table of \(target) lists no union named \(name)")
    }
    return schema
  }
}
