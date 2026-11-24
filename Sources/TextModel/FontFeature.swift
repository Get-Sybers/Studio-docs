public import WireFormat

/// A typographic feature of a font, by the numbers of its feature type and its setting.
public struct FontFeature: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TextFormat.table.object(named: "FontFeature")

  /// The number of the feature type.
  public var feature: Int
  /// The number of the setting within that type.
  public var selector: Int
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a font feature; a member left out is absent from the JSON.
  public init(feature: Int, selector: Int) {
    self.feature = feature
    self.selector = selector
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    feature = try reader.required("feature")
    selector = try reader.required("selector")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("feature", feature)
    writer.required("selector", selector)
  }
}
