import Foundation
import HashTreeCollections
public import WireFormat

/// Makes identifiers that no object of a document carries. Nothing in the library calls it on its own.
public struct IdentifierMint: Sendable {
  private var taken: TreeSet<ObjectID>

  /// Creates a mint that avoids the identifiers of an index.
  public init(avoiding index: IdentifierIndex = IdentifierIndex()) {
    taken = TreeSet(index.identifiers)
  }

  /// Creates a mint that avoids some identifiers.
  public init(avoiding identifiers: some Sequence<ObjectID>) {
    taken = TreeSet(identifiers)
  }

  /// Whether the mint avoids an identifier: it was given it, or made it.
  public func avoids(_ identifier: ObjectID) -> Bool {
    taken.contains(identifier)
  }

  /// Makes the mint avoid an identifier that came into use elsewhere.
  public mutating func reserve(_ identifier: ObjectID) {
    taken.insert(identifier)
  }

  /// Makes a new identifier, the text of a random UUID, from a generator the caller owns.
  public mutating func mint<Generator: RandomNumberGenerator>(using generator: inout Generator) -> ObjectID {
    while true {
      var high = generator.next()
      var low = generator.next()
      // The two fixed fields of a random UUID: version 4 and the RFC 4122 variant.
      high = (high & 0xFFFF_FFFF_FFFF_0FFF) | 0x0000_0000_0000_4000
      low = (low & 0x3FFF_FFFF_FFFF_FFFF) | 0x8000_0000_0000_0000
      let bytes =
        (0..<8).map { UInt8(truncatingIfNeeded: high >> (56 - 8 * $0)) }
        + (0..<8).map { UInt8(truncatingIfNeeded: low >> (56 - 8 * $0)) }
      let uuid = UUID(
        uuid: (
          bytes[0], bytes[1], bytes[2], bytes[3], bytes[4], bytes[5], bytes[6], bytes[7], bytes[8], bytes[9],
          bytes[10], bytes[11], bytes[12], bytes[13], bytes[14], bytes[15]
        ))
      let identifier = ObjectID(rawValue: uuid.uuidString)
      if taken.insert(identifier).inserted { return identifier }
    }
  }

  /// Makes a new identifier from the system's generator.
  public mutating func mint() -> ObjectID {
    var generator = SystemRandomNumberGenerator()
    return mint(using: &generator)
  }
}
