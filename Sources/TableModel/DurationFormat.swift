public import WireFormat

/// The type `table.cell-format.duration-format` of the format.
public struct DurationFormat: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "DurationFormat")

  /// The `use_automatic_units` member; true when omitted.
  public var useAutomaticUnits: Bool?
  /// The `smallest_unit` member; "second" when omitted.
  public var smallestUnit: DurationFormatUnit?
  /// The `largest_unit` member; "hour" when omitted.
  public var largestUnit: DurationFormatUnit?
  /// The `style` member; "short" when omitted.
  public var style: DurationStyle?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    useAutomaticUnits: Bool? = nil, smallestUnit: DurationFormatUnit? = nil, largestUnit: DurationFormatUnit? = nil,
    style: DurationStyle? = nil
  ) {
    self.useAutomaticUnits = useAutomaticUnits
    self.smallestUnit = smallestUnit
    self.largestUnit = largestUnit
    self.style = style
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    useAutomaticUnits = try reader.optional("use_automatic_units")
    smallestUnit = try reader.optional("smallest_unit")
    largestUnit = try reader.optional("largest_unit")
    style = try reader.optional("style")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("use_automatic_units", useAutomaticUnits)
    writer.optional("smallest_unit", smallestUnit)
    writer.optional("largest_unit", largestUnit)
    writer.optional("style", style)
  }
}
