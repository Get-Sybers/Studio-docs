import ChartModel
public import WireFormat

extension SchemaRegistry {
  /// The schemas of every type of the format that the library models, the objects of a canvas included.
  public static let canvas = SchemaRegistry.charts.merging(SchemaRegistry(tables: [CanvasModelFormat.table]))
}
