import DocumentIdentifiers
import JSONTree
import ResourceReferences
import WireFormat

/// The rules of object identifiers: each once and none empty; and, where the document defines them all, each reference met.
enum IdentifierRules {
  static func check(_ tree: JSONValue, resolvingReferences: Bool, into collector: inout FindingCollector) {
    collector.part = .main
    let index = Self.index(of: tree)
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
    guard resolvingReferences else { return }
    for reference in collector.references where !index.contains(ObjectID(rawValue: reference.identifier)) {
      collector.report(.unresolvedReference(ObjectID(rawValue: reference.identifier)), at: reference.path)
    }
  }

  /// The slide object type and the source kind of an object that a slide takes from its layout, with its identifiers.
  private static let slideObject = "com.apple.apps.content-language.slide-object"

  /// Indexes the identifiers of a tree, passing over resources and the objects a slide takes from its layout.
  static func index(of tree: JSONValue) -> IdentifierIndex {
    var index = IdentifierIndex()
    var layoutCopies: [[JSONPath.Component]] = []
    tree.walk { value, steps in
      guard let object = value.objectValue else { return }
      if layoutCopies.contains(where: { steps.starts(with: $0) }) { return }
      if object["type_identifier"]?.stringValue == slideObject, object["source_kind"]?.stringValue == "layout" {
        layoutCopies.append(steps)
        return
      }
      guard let text = object["identifier"]?.stringValue,
        object["type_identifier"]?.stringValue != IndirectResource.typeIdentifier.rawValue
      else { return }
      index.insert(ObjectID(rawValue: text), at: JSONPath(steps))
    }
    return index
  }
}
