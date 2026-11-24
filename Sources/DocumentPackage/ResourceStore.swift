public import Foundation
import OrderedCollections
public import ResourceReferences

/// The files of a package's `Data` directory: bytes by name, in a stable order.
public struct ResourceStore: Sendable, Hashable, ExpressibleByDictionaryLiteral {
  private var files: OrderedDictionary<String, Data>

  /// Creates an empty store.
  public init() {
    files = [:]
  }

  /// Creates a store from names and bytes; a later pair replaces an earlier one of the same name.
  public init(_ pairs: some Sequence<(String, Data)>) {
    files = OrderedDictionary(pairs, uniquingKeysWith: { _, later in later })
  }

  /// Creates a store from a literal.
  public init(dictionaryLiteral elements: (String, Data)...) {
    self.init(elements)
  }

  /// The names, in the order the files were added.
  public var names: [String] { Array(files.keys) }

  /// The number of files.
  public var count: Int { files.count }

  /// Whether the store holds no file.
  public var isEmpty: Bool { files.isEmpty }

  /// The bytes of a file; assigning nil removes it. Names that differ only in composition are one name.
  public subscript(name: String) -> Data? {
    get { files[name] }
    set { files[name] = newValue }
  }

  /// The bytes that an indirect resource refers to: those under its identifier, or else under its filename.
  public func data(for resource: IndirectResource) -> Data? {
    files[resource.storedName]
  }

  /// A name that no file has: the preferred one, or that name with a number before its extension.
  public func uniqueName(basedOn preferred: String) -> String {
    guard files[preferred] != nil else { return preferred }
    let dot = preferred.lastIndex(of: ".").flatMap { $0 == preferred.startIndex ? nil : $0 } ?? preferred.endIndex
    var number = 2
    while files["\(preferred[..<dot]) \(number)\(preferred[dot...])"] != nil {
      number += 1
    }
    return "\(preferred[..<dot]) \(number)\(preferred[dot...])"
  }

  /// Stores bytes under a name that no file has, and returns the reference that an object holds to them.
  public mutating func add(_ data: Data, preferredName: String) -> IndirectResource {
    let name = uniqueName(basedOn: preferredName)
    files[name] = data
    return IndirectResource(filename: preferredName, identifier: name == preferredName ? nil : name)
  }
}

extension ResourceStore: Sequence {
  /// Returns an iterator over the files in their stable order.
  public func makeIterator() -> some IteratorProtocol<(key: String, value: Data)> {
    files.elements.makeIterator()
  }
}
