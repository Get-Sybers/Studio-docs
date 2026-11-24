/// The schemas of a set of types, by type identifier, for work that meets objects as JSON.
public struct SchemaRegistry: Sendable {
  private var objects: [TypeIdentifier: ObjectSchema]
  private var unions: [TypeIdentifier: UnionSchema]

  /// Creates a registry; of two schemas for one type, the later is kept.
  public init(objects: [ObjectSchema] = [], unions: [UnionSchema] = []) {
    self.objects = Dictionary(objects.map { ($0.typeIdentifier, $0) }, uniquingKeysWith: { _, later in later })
    self.unions = Dictionary(unions.map { ($0.typeIdentifier, $0) }, uniquingKeysWith: { _, later in later })
  }

  /// Creates a registry of every type that some format tables list.
  package init(tables: [FormatTable]) {
    self.init(objects: tables.flatMap(\.objects.values), unions: tables.flatMap(\.unions.values))
  }

  /// A registry of no types.
  public static let empty = SchemaRegistry()

  /// The schema of an object type, if the registry holds it.
  public func object(_ type: TypeIdentifier) -> ObjectSchema? {
    objects[type]
  }

  /// The schema of a union type, if the registry holds it.
  public func union(_ type: TypeIdentifier) -> UnionSchema? {
    unions[type]
  }

  /// Every type identifier that the registry holds, in order.
  public var typeIdentifiers: [TypeIdentifier] {
    (Array(objects.keys) + Array(unions.keys)).sorted { $0.rawValue < $1.rawValue }
  }

  /// Returns a registry of the types of both; where both hold a type, that of `other` is kept.
  public func merging(_ other: SchemaRegistry) -> SchemaRegistry {
    var merged = self
    merged.objects.merge(other.objects) { _, later in later }
    merged.unions.merge(other.unions) { _, later in later }
    return merged
  }
}
