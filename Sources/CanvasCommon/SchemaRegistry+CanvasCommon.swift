import TextModel
public import WireFormat

extension SchemaRegistry {
  /// The schemas of every type of the format that the library models, what canvas objects share included.
  public static let canvasCommon = SchemaRegistry.text.merging(SchemaRegistry(tables: [CanvasCommonFormat.table]))
}
