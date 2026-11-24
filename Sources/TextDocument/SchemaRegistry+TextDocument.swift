import TextModel
public import WireFormat

extension SchemaRegistry {
  /// The schemas of the library's text document, and of every type of the format that the library models.
  public static let textDocument = SchemaRegistry.text.merging(SchemaRegistry(tables: [TextDocumentFormat.table]))
}
