public import WireFormat

/// The type `table.cell-format.base-format` of the format.
public struct BaseFormat: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "BaseFormat")

  /// The `base` member; 10 when omitted.
  public var base: Int?
  /// The `base_places` member; 0 when omitted.
  public var basePlaces: Int?
  /// The `base_use_minus_sign` member; true when omitted.
  public var baseUseMinusSign: Bool?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(base: Int? = nil, basePlaces: Int? = nil, baseUseMinusSign: Bool? = nil) {
    self.base = base
    self.basePlaces = basePlaces
    self.baseUseMinusSign = baseUseMinusSign
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    base = try reader.optional("base")
    basePlaces = try reader.optional("base_places")
    baseUseMinusSign = try reader.optional("base_use_minus_sign")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("base", base)
    writer.optional("base_places", basePlaces)
    writer.optional("base_use_minus_sign", baseUseMinusSign)
  }
}
