import CanvasCommon
public import WireFormat

extension SchemaRegistry {
  /// The schemas of every type of the format that the library models, tables included.
  public static let tables = SchemaRegistry.canvasCommon.merging(SchemaRegistry(tables: [TableModelFormat.table]))
}
