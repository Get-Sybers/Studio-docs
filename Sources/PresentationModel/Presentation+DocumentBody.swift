public import DocumentPackage
public import WireFormat

extension Presentation: DocumentBody {
  /// A presentation leans on its theme for identifiers and presets that the document does not hold.
  public static var isSelfContained: Bool { false }

  /// The schemas of every type of the format, the presentation's own included.
  public static var schemas: SchemaRegistry { .presentation }
}
