public import JSONTree
public import WireFormat

/// The content of a document kept as it was read, for a root type that the library does not model.
///
/// A Keynote presentation opens through this body: every slide and object is written back as it was.
public struct UntypedBody: DocumentBody, Hashable {
  /// The tree of `main.json`.
  public var tree: JSONValue

  /// Wraps a tree.
  public init(tree: JSONValue) {
    self.tree = tree
  }

  /// Takes the tree of `main.json` as it is.
  public init(mainTree: JSONValue) throws(WireError) {
    tree = mainTree
  }

  /// The tree as it was read or set.
  public var mainTree: JSONValue { tree }

  /// A presentation leans on its theme for identifiers and presets that the document does not hold.
  public static var isSelfContained: Bool { false }

  /// The `type_identifier` of the root object, when it names one.
  public var typeIdentifier: TypeIdentifier? {
    tree["type_identifier"]?.stringValue.map(TypeIdentifier.init(rawValue:))
  }
}
