public import WireFormat

/// What marks a resource as content that came from the Content Hub, with its watermark terms.
public struct PremiumResourceInfo: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = ResourceFormat.table.object(named: "PremiumResourceInfo")

  /// The UUID of the asset in the media library.
  public var assetUUID: String
  /// Whether the bytes were changed since they left the Content Hub.
  public var isDerivedAsset: Bool
  /// Whether a reader without a subscription may show the resource under a watermark.
  public var mayNeedWatermark: Bool
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates the marks of a premium resource; a member left out is absent from the JSON.
  public init(assetUUID: String, isDerivedAsset: Bool, mayNeedWatermark: Bool) {
    self.assetUUID = assetUUID
    self.isDerivedAsset = isDerivedAsset
    self.mayNeedWatermark = mayNeedWatermark
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    assetUUID = try reader.required("asset_uuid")
    isDerivedAsset = try reader.required("is_derived_asset")
    mayNeedWatermark = try reader.required("may_need_watermark")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("asset_uuid", assetUUID)
    writer.required("is_derived_asset", isDerivedAsset)
    writer.required("may_need_watermark", mayNeedWatermark)
  }
}
