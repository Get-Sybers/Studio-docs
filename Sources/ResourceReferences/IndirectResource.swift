public import WireFormat

/// A resource whose bytes are a file in the package's `Data` directory.
public struct IndirectResource: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = ResourceFormat.table.object(named: "IndirectResource")

  /// The name of the file in `Data`; when nil, `filename` is that name. It is no object identifier.
  public var identifier: String?
  /// The name shown for the resource, with its extension.
  public var filename: String
  /// What marks the resource as content of the Content Hub; a member of version 2.0.
  public var premiumResourceInfo: PremiumResourceInfo?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a reference to a file in `Data`; a member left out is absent from the JSON.
  public init(filename: String, identifier: String? = nil, premiumResourceInfo: PremiumResourceInfo? = nil) {
    self.identifier = identifier
    self.filename = filename
    self.premiumResourceInfo = premiumResourceInfo
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    identifier = try reader.optional("identifier")
    filename = try reader.required("filename")
    premiumResourceInfo = try reader.optional("premium_resource_info")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("identifier", identifier)
    writer.required("filename", filename)
    writer.optional("premium_resource_info", premiumResourceInfo)
  }
}
