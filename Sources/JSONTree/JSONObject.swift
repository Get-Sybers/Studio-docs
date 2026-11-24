import OrderedCollections

/// A JSON object: members with distinct names, which iterate in a stable order.
///
/// The order carries no meaning: two objects with the same members are equal in any order.
public struct JSONObject: Sendable {
  private var members: OrderedDictionary<String, JSONValue>

  /// Creates an object with no members.
  public init() {
    members = [:]
  }

  /// Creates an object from pairs; a later pair replaces an earlier one of the same name.
  public init(_ pairs: some Sequence<(String, JSONValue)>) {
    members = OrderedDictionary(pairs, uniquingKeysWith: { _, later in later })
  }

  /// The number of members.
  public var count: Int { members.count }

  /// Whether the object has no members.
  public var isEmpty: Bool { members.isEmpty }

  /// The names of the members, in iteration order.
  public var keys: [String] { Array(members.keys) }

  /// The value of a member; assigning nil removes the member, and a new member goes last.
  public subscript(name: String) -> JSONValue? {
    get { members[name] }
    set { members[name] = newValue }
  }

  /// Whether a member of this name exists, a member whose value is `null` included.
  public func contains(_ name: String) -> Bool {
    members[name] != nil
  }

  /// Removes a member and returns its value.
  @discardableResult
  public mutating func removeValue(forKey name: String) -> JSONValue? {
    members.removeValue(forKey: name)
  }

  /// Returns this object with the members of `lower` that it lacks added after its own.
  public func merging(over lower: JSONObject) -> JSONObject {
    var merged = self
    for (name, value) in lower.members where merged.members[name] == nil {
      merged.members[name] = value
    }
    return merged
  }

  /// Puts the members in the order of their names, which is the order of the written text.
  public mutating func sortKeys() {
    members.sort { $0.key < $1.key }
  }
}

extension JSONObject: Hashable {
  public static func == (left: JSONObject, right: JSONObject) -> Bool {
    left.members.count == right.members.count && left.members.allSatisfy { right.members[$0.key] == $0.value }
  }

  public func hash(into hasher: inout Hasher) {
    // A sum does not depend on the order of the members, as equality does not.
    var sum = 0
    for (name, value) in members {
      var member = Hasher()
      member.combine(name)
      member.combine(value)
      sum &+= member.finalize()
    }
    hasher.combine(sum)
  }
}

extension JSONObject: Sequence {
  /// Returns an iterator over the members in their stable order.
  public func makeIterator() -> some IteratorProtocol<(key: String, value: JSONValue)> {
    members.elements.makeIterator()
  }
}

extension JSONObject: ExpressibleByDictionaryLiteral {
  /// Creates an object from a literal; a later pair replaces an earlier one of the same name.
  public init(dictionaryLiteral elements: (String, JSONValue)...) {
    self.init(elements)
  }
}
