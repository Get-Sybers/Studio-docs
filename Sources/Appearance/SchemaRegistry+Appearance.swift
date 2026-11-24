import ResourceReferences
public import WireFormat

extension SchemaRegistry {
  /// The schemas of colours, fills, shadows and strokes, and of the resource types they use.
  public static let appearance = SchemaRegistry.resources.merging(SchemaRegistry(tables: [AppearanceFormat.table]))
}
