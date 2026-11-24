import DocumentIdentifiers
import JSONTree
import ResourceReferences
import WireFormat

/// The rules of object identifiers, for a document that defines every identifier it uses.
enum IdentifierRules {
  static func check(_ tree: JSONValue, into collector: inout FindingCollector) {
    collector.part = .main
    let index = IdentifierIndex(of: tree, excluding: [IndirectResource.typeIdentifier])
    for identifier in index.identifiers {
      let places = index.paths(of: identifier)
      if identifier.rawValue.isEmpty {
        for place in places { collector.report(.emptyIdentifier, at: place.member("identifier")) }
        continue
      }
      for place in places.dropFirst() {
        collector.report(.duplicateIdentifier(identifier, first: places[0]), at: place.member("identifier"))
      }
    }
    for reference in collector.references where !index.contains(ObjectID(rawValue: reference.identifier)) {
      collector.report(.unresolvedReference(ObjectID(rawValue: reference.identifier)), at: reference.path)
    }
  }
}
