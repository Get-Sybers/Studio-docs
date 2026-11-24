import CanvasModel
public import WireFormat

extension SchemaRegistry {
  /// The schemas of every type of the format that the library models, a presentation included.
  public static let presentation = SchemaRegistry.canvas.merging(
    SchemaRegistry(tables: [PresentationModelFormat.table]))
}
