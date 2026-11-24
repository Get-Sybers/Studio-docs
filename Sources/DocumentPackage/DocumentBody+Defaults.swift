public import DocumentValidation
public import JSONTree
import TextModel
public import WireFormat

extension DocumentBody {
  /// A body defines what it names.
  public static var isSelfContained: Bool { true }

  /// The schemas of every type that the library models.
  public static var schemas: SchemaRegistry { .text }

  /// A body has no rules of its own.
  public func findings() -> [ValidationFinding] { [] }
}

extension DocumentBody where Self: WireObject {
  /// Reads the root object of `main.json`.
  public init(mainTree: JSONValue) throws(WireError) {
    try self.init(wire: mainTree)
  }

  /// The object as the root of `main.json`.
  public var mainTree: JSONValue { wireValue }
}
