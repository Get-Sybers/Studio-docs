public import DocumentPackage
public import DocumentValidation
public import WireFormat

extension Presentation: DocumentBody {
  /// A presentation leans on its theme for identifiers and presets that the document does not hold.
  public static var isSelfContained: Bool { false }

  /// The schemas of every type of the format, the presentation's own included.
  public static var schemas: SchemaRegistry { .presentation }

  /// The rules of a presentation beyond its schemas: layouts, placeholders, connection lines, tables and charts.
  public func findings() -> [ValidationFinding] { PresentationRules.findings(of: self) }
}
