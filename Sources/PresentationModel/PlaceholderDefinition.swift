public import WireFormat

/// The type `slide-object.placeholder-info.placeholder-definition` of the format.
public struct PlaceholderDefinition: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = PresentationModelFormat.table.object(named: "PlaceholderDefinition")

  /// The `kind` member.
  public var kind: PlaceholderKind
  /// The `is_visible` member; true when omitted.
  public var isVisible: Bool?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(kind: PlaceholderKind, isVisible: Bool? = nil) {
    self.kind = kind
    self.isVisible = isVisible
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    kind = try reader.required("kind")
    isVisible = try reader.optional("is_visible")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("kind", kind)
    writer.optional("is_visible", isVisible)
  }
}
