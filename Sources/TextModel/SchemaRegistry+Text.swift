import Appearance
public import WireFormat

extension SchemaRegistry {
  /// The schemas of every type of the format that the library models: text, appearance and resources.
  public static let text = SchemaRegistry.appearance.merging(SchemaRegistry(tables: [TextFormat.table]))
}
