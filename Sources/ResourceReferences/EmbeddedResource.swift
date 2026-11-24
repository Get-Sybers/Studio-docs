public import WireFormat

/// A resource whose bytes are carried in the JSON itself.
public struct EmbeddedResource: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = ResourceFormat.table.object(named: "EmbeddedResource")

  /// The bytes, in Base64.
  public var string: String
  /// The name shown for the resource, with its extension.
  public var filename: String
  /// What marks the resource as content of the Content Hub; a member of version 2.0.
  public var premiumResourceInfo: PremiumResourceInfo?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a resource from its Base64 text; a member left out is absent from the JSON.
  public init(string: String, filename: String, premiumResourceInfo: PremiumResourceInfo? = nil) {
    self.string = string
    self.filename = filename
    self.premiumResourceInfo = premiumResourceInfo
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    string = try reader.required("string")
    filename = try reader.required("filename")
    premiumResourceInfo = try reader.optional("premium_resource_info")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("string", string)
    writer.required("filename", filename)
    writer.optional("premium_resource_info", premiumResourceInfo)
  }
}
