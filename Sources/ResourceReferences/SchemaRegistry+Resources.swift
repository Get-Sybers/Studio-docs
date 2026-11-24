public import WireFormat

extension SchemaRegistry {
  /// The schemas of the resource types.
  public static let resources = SchemaRegistry(tables: [ResourceFormat.table])
}
