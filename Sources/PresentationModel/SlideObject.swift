public import CanvasModel
public import WireFormat

/// The type `slide-object` of the format.
public struct SlideObject: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = PresentationModelFormat.table.object(named: "SlideObject")

  /// The `instructional_text` member.
  public var instructionalText: String?
  /// The `is_locked` member; false when omitted.
  public var isLocked: Bool?
  /// The `object` member.
  public var object: CanvasObject
  /// The `placeholder_info` member.
  public var placeholderInfo: PlaceholderInfo?
  /// The `source_kind` member.
  public var sourceKind: SourceKind?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    instructionalText: String? = nil, isLocked: Bool? = nil, object: CanvasObject,
    placeholderInfo: PlaceholderInfo? = nil, sourceKind: SourceKind? = nil
  ) {
    self.instructionalText = instructionalText
    self.isLocked = isLocked
    self.object = object
    self.placeholderInfo = placeholderInfo
    self.sourceKind = sourceKind
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    instructionalText = try reader.optional("instructional_text")
    isLocked = try reader.optional("is_locked")
    object = try reader.required("object")
    placeholderInfo = try reader.optional("placeholder_info")
    sourceKind = try reader.optional("source_kind")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("instructional_text", instructionalText)
    writer.optional("is_locked", isLocked)
    writer.required("object", object)
    writer.optional("placeholder_info", placeholderInfo)
    writer.optional("source_kind", sourceKind)
  }
}
