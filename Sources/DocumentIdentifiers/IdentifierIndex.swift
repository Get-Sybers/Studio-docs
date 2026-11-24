import HashTreeCollections
public import JSONTree
public import WireFormat

/// Every object identifier of a tree, with the places that carry it.
///
/// An object's `identifier` member is its identifier, except on a type that gives the member another meaning.
public struct IdentifierIndex: Sendable {
  private var places: TreeDictionary<ObjectID, [JSONPath]> = [:]
  private var order: [ObjectID] = []

  /// Creates an empty index.
  public init() {}

  /// Indexes a tree; an object whose `type_identifier` is in `excluding` is passed over.
  public init(of tree: JSONValue, excluding: Set<TypeIdentifier> = []) {
    let excluded = Set(excluding.map(\.rawValue))
    tree.walk { value, steps in
      guard let object = value.objectValue, let text = object["identifier"]?.stringValue else { return }
      if let type = object["type_identifier"]?.stringValue, excluded.contains(type) { return }
      insert(ObjectID(rawValue: text), at: JSONPath(steps))
    }
  }

  /// The identifiers, each once, in the order the tree first carries them.
  public var identifiers: [ObjectID] { order }

  /// The number of distinct identifiers.
  public var count: Int { order.count }

  /// Whether an object carries the identifier.
  public func contains(_ identifier: ObjectID) -> Bool {
    places[identifier] != nil
  }

  /// The places of the objects that carry an identifier, in the order of the tree.
  public func paths(of identifier: ObjectID) -> [JSONPath] {
    places[identifier] ?? []
  }

  /// The identifiers that more than one object carries, in the order the tree first carries them.
  public var duplicates: [ObjectID] {
    order.filter { (places[$0]?.count ?? 0) > 1 }
  }

  /// Records that the object at a place carries an identifier.
  public mutating func insert(_ identifier: ObjectID, at path: JSONPath) {
    if places[identifier] == nil { order.append(identifier) }
    places[identifier, default: []].append(path)
  }
}
