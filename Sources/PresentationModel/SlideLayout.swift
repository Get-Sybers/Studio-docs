public import WireFormat

/// The type `slide-layout` of the format.
public struct SlideLayout: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = PresentationModelFormat.table.object(named: "SlideLayout")

  /// The `name` member.
  public var name: String
  /// The `contents` member.
  public var contents: [SlideObject]?
  /// The `background` member.
  public var background: SlideBackground?
  /// The `slide_objects_layer_with_layout` member; false when omitted.
  public var slideObjectsLayerWithLayout: Bool?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    name: String, contents: [SlideObject]? = nil, background: SlideBackground? = nil,
    slideObjectsLayerWithLayout: Bool? = nil
  ) {
    self.name = name
    self.contents = contents
    self.background = background
    self.slideObjectsLayerWithLayout = slideObjectsLayerWithLayout
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    name = try reader.required("name")
    contents = try reader.optional("contents")
    background = try reader.optional("background")
    slideObjectsLayerWithLayout = try reader.optional("slide_objects_layer_with_layout")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("name", name)
    writer.optional("contents", contents)
    writer.optional("background", background)
    writer.optional("slide_objects_layer_with_layout", slideObjectsLayerWithLayout)
  }
}
