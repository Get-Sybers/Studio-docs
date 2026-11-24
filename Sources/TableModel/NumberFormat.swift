public import WireFormat

/// The type `table.cell-format.number-format` of the format.
public struct NumberFormat: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "NumberFormat")

  /// The `decimal_places` member; 2 when omitted.
  public var decimalPlaces: Int?
  /// The `negative_number_style` member; "minus" when omitted.
  public var negativeNumberStyle: NegativeNumberStyle?
  /// The `use_thousands_separator` member; true when omitted.
  public var useThousandsSeparator: Bool?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    decimalPlaces: Int? = nil, negativeNumberStyle: NegativeNumberStyle? = nil, useThousandsSeparator: Bool? = nil
  ) {
    self.decimalPlaces = decimalPlaces
    self.negativeNumberStyle = negativeNumberStyle
    self.useThousandsSeparator = useThousandsSeparator
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    decimalPlaces = try reader.optional("decimal_places")
    negativeNumberStyle = try reader.optional("negative_number_style")
    useThousandsSeparator = try reader.optional("use_thousands_separator")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("decimal_places", decimalPlaces)
    writer.optional("negative_number_style", negativeNumberStyle)
    writer.optional("use_thousands_separator", useThousandsSeparator)
  }
}
