public import WireFormat

/// The type `table.cell-format.currency-format` of the format.
public struct CurrencyFormat: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "CurrencyFormat")

  /// The `decimal_places` member; 2 when omitted.
  public var decimalPlaces: Int?
  /// The `negative_number_style` member; "minus" when omitted.
  public var negativeNumberStyle: NegativeNumberStyle?
  /// The `use_thousands_separator` member; true when omitted.
  public var useThousandsSeparator: Bool?
  /// The `accounting_style` member; false when omitted.
  public var accountingStyle: Bool?
  /// The `currency_code` member; "USD" when omitted.
  public var currencyCode: String?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    decimalPlaces: Int? = nil, negativeNumberStyle: NegativeNumberStyle? = nil, useThousandsSeparator: Bool? = nil,
    accountingStyle: Bool? = nil, currencyCode: String? = nil
  ) {
    self.decimalPlaces = decimalPlaces
    self.negativeNumberStyle = negativeNumberStyle
    self.useThousandsSeparator = useThousandsSeparator
    self.accountingStyle = accountingStyle
    self.currencyCode = currencyCode
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    decimalPlaces = try reader.optional("decimal_places")
    negativeNumberStyle = try reader.optional("negative_number_style")
    useThousandsSeparator = try reader.optional("use_thousands_separator")
    accountingStyle = try reader.optional("accounting_style")
    currencyCode = try reader.optional("currency_code")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("decimal_places", decimalPlaces)
    writer.optional("negative_number_style", negativeNumberStyle)
    writer.optional("use_thousands_separator", useThousandsSeparator)
    writer.optional("accounting_style", accountingStyle)
    writer.optional("currency_code", currencyCode)
  }
}
