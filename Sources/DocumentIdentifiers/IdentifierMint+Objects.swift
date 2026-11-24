public import WireFormat

extension IdentifierMint {
  /// Gives an identifier to each object that has none or that repeats one earlier in the array.
  ///
  /// The first object to carry an identifier keeps it. The result is the indices of the objects that changed.
  @discardableResult
  public mutating func assignIdentifiers<Object: WireObject, Generator: RandomNumberGenerator>(
    to objects: inout [Object], using generator: inout Generator
  ) -> [Int] {
    var seen: Set<ObjectID> = []
    var changed: [Int] = []
    for index in objects.indices {
      if let identifier = objects[index].identifier, seen.insert(identifier).inserted {
        reserve(identifier)
        continue
      }
      let identifier = mint(using: &generator)
      objects[index].identifier = identifier
      seen.insert(identifier)
      changed.append(index)
    }
    return changed
  }

  /// Gives an identifier to each object that has none or that repeats one earlier in the array.
  @discardableResult
  public mutating func assignIdentifiers<Object: WireObject>(to objects: inout [Object]) -> [Int] {
    var generator = SystemRandomNumberGenerator()
    return assignIdentifiers(to: &objects, using: &generator)
  }
}
