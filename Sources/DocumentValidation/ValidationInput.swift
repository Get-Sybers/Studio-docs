public import JSONTree
public import PresetStyles
public import WireFormat

/// What validation examines: the trees and names of a document, apart from how it is stored.
public struct ValidationInput: Sendable {
  /// The tree of `main.json`.
  public var main: JSONValue
  /// The presets of `presets.json`.
  public var presets: PresetLibrary
  /// The names of the files in `Data`.
  public var resourceNames: [String]
  /// Whether everything the tree refers to is defined in the document itself.
  ///
  /// False for a tree that leans on a theme outside it, which may define the identifiers and presets it names.
  public var isSelfContained: Bool
  /// The schemas by which objects that name their type are checked.
  public var schemas: SchemaRegistry

  /// Creates an input.
  public init(
    main: JSONValue, presets: PresetLibrary = PresetLibrary(), resourceNames: [String] = [],
    isSelfContained: Bool = true, schemas: SchemaRegistry
  ) {
    self.main = main
    self.presets = presets
    self.resourceNames = resourceNames
    self.isSelfContained = isSelfContained
    self.schemas = schemas
  }
}
