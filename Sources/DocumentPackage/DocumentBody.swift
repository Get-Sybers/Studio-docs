public import DocumentValidation
public import JSONTree
public import WireFormat

/// The content of a document: the root of `main.json`, of a type that the client chooses.
///
/// An object type of the client's own conforms by conforming to `WireObject`; nothing else is required.
public protocol DocumentBody: Sendable {
  /// Reads the body from the tree of `main.json`.
  init(mainTree: JSONValue) throws(WireError)

  /// The body as the tree of `main.json`.
  var mainTree: JSONValue { get }

  /// Whether the tree defines every identifier and preset that it names; true unless the body says otherwise.
  static var isSelfContained: Bool { get }

  /// The schemas by which validation checks the objects of the tree; those of the library unless the body adds its own.
  static var schemas: SchemaRegistry { get }

  /// The findings of the body's own rules, which validation adds to the library's; none unless the body has rules.
  func findings() -> [ValidationFinding]
}
