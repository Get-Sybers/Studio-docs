public import JSONTree

/// The presets of a document, in the order of `presets.json`.
public struct PresetLibrary: Sendable, Hashable, ExpressibleByArrayLiteral {
  /// The presets in file order; where two share an identifier, objects adopt the later.
  public var presets: [Preset]

  /// Creates a library.
  public init(_ presets: [Preset] = []) {
    self.presets = presets
  }

  /// Creates a library from a literal.
  public init(arrayLiteral elements: Preset...) {
    self.init(elements)
  }

  /// Reads the tree of `presets.json`: an array of entries, each with an identifier and properties.
  public init(wire value: JSONValue) throws(PresetError) {
    guard let entries = value.arrayValue else { throw .notAnArray }
    var presets: [Preset] = []
    presets.reserveCapacity(entries.count)
    for (index, entry) in entries.enumerated() {
      presets.append(try Preset(entry: entry, index: index))
    }
    self.init(presets)
  }

  /// The library as the tree of `presets.json`.
  public var wireValue: JSONValue {
    .array(presets.map(\.entry))
  }

  /// The preset that objects adopt under an identifier.
  public subscript(identifier: String) -> Preset? {
    presets.last { $0.identifier == identifier }
  }

  /// The identifiers that more than one preset carries, each once, in file order.
  public var duplicateIdentifiers: [String] {
    var seen: Set<String> = []
    var repeated: [String] = []
    for preset in presets where !seen.insert(preset.identifier).inserted && !repeated.contains(preset.identifier) {
      repeated.append(preset.identifier)
    }
    return repeated
  }
}
