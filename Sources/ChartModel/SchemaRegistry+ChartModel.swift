import TableModel
public import WireFormat

extension SchemaRegistry {
  /// The schemas of every type of the format that the library models, charts included.
  public static let charts = SchemaRegistry.tables.merging(SchemaRegistry(tables: [ChartModelFormat.table]))
}
