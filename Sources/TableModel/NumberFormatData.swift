public import WireFormat

/// The type `table.custom-format.number-format-data` of the format.
public struct NumberFormatData: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "NumberFormatData")

  /// The `scale_factor` member; 1 when omitted.
  public var scaleFactor: Double?
  /// The `fraction_accuracy` member.
  public var fractionAccuracy: FractionAccuracy?
  /// The `interstitial_strings` member.
  public var interstitialStrings: [String]?
  /// The `interstitial_string_insertion_indexes` member.
  public var interstitialStringInsertionIndexes: [Int]?
  /// The `minimum_integer_width` member; 0 when omitted.
  public var minimumIntegerWidth: Int?
  /// The `decimal_width` member; 0 when omitted.
  public var decimalWidth: Int?
  /// The `number_of_non_space_integer_placeholder_digits` member; 0 when omitted.
  public var numberOfNonSpaceIntegerPlaceholderDigits: Int?
  /// The `number_of_non_space_decimal_placeholder_digits` member; 0 when omitted.
  public var numberOfNonSpaceDecimalPlaceholderDigits: Int?
  /// The `index_from_right_of_last_digit_placeholder` member; 0 when omitted.
  public var indexFromRightOfLastDigitPlaceholder: Int?
  /// The `number_of_hash_decimal_placeholders` member; 0 when omitted.
  public var numberOfHashDecimalPlaceholders: Int?
  /// The `total_number_of_decimal_placeholders_in_format` member; 0 when omitted.
  public var totalNumberOfDecimalPlaceholdersInFormat: Int?
  /// The `currency_code` member.
  public var currencyCode: String?
  /// The `show_thousands_separator` member; false when omitted.
  public var showThousandsSeparator: Bool?
  /// The `use_accounting_style` member; false when omitted.
  public var useAccountingStyle: Bool?
  /// The `requires_fraction_replacement` member; false when omitted.
  public var requiresFractionReplacement: Bool?
  /// The `format_contains_integer_token` member; false when omitted.
  public var formatContainsIntegerToken: Bool?
  /// The `is_complex_format` member; false when omitted.
  public var isComplexFormat: Bool?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    scaleFactor: Double? = nil, fractionAccuracy: FractionAccuracy? = nil, interstitialStrings: [String]? = nil,
    interstitialStringInsertionIndexes: [Int]? = nil, minimumIntegerWidth: Int? = nil, decimalWidth: Int? = nil,
    numberOfNonSpaceIntegerPlaceholderDigits: Int? = nil, numberOfNonSpaceDecimalPlaceholderDigits: Int? = nil,
    indexFromRightOfLastDigitPlaceholder: Int? = nil, numberOfHashDecimalPlaceholders: Int? = nil,
    totalNumberOfDecimalPlaceholdersInFormat: Int? = nil, currencyCode: String? = nil,
    showThousandsSeparator: Bool? = nil, useAccountingStyle: Bool? = nil, requiresFractionReplacement: Bool? = nil,
    formatContainsIntegerToken: Bool? = nil, isComplexFormat: Bool? = nil
  ) {
    self.scaleFactor = scaleFactor
    self.fractionAccuracy = fractionAccuracy
    self.interstitialStrings = interstitialStrings
    self.interstitialStringInsertionIndexes = interstitialStringInsertionIndexes
    self.minimumIntegerWidth = minimumIntegerWidth
    self.decimalWidth = decimalWidth
    self.numberOfNonSpaceIntegerPlaceholderDigits = numberOfNonSpaceIntegerPlaceholderDigits
    self.numberOfNonSpaceDecimalPlaceholderDigits = numberOfNonSpaceDecimalPlaceholderDigits
    self.indexFromRightOfLastDigitPlaceholder = indexFromRightOfLastDigitPlaceholder
    self.numberOfHashDecimalPlaceholders = numberOfHashDecimalPlaceholders
    self.totalNumberOfDecimalPlaceholdersInFormat = totalNumberOfDecimalPlaceholdersInFormat
    self.currencyCode = currencyCode
    self.showThousandsSeparator = showThousandsSeparator
    self.useAccountingStyle = useAccountingStyle
    self.requiresFractionReplacement = requiresFractionReplacement
    self.formatContainsIntegerToken = formatContainsIntegerToken
    self.isComplexFormat = isComplexFormat
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    scaleFactor = try reader.optional("scale_factor")
    fractionAccuracy = try reader.optional("fraction_accuracy")
    interstitialStrings = try reader.optional("interstitial_strings")
    interstitialStringInsertionIndexes = try reader.optional("interstitial_string_insertion_indexes")
    minimumIntegerWidth = try reader.optional("minimum_integer_width")
    decimalWidth = try reader.optional("decimal_width")
    numberOfNonSpaceIntegerPlaceholderDigits = try reader.optional("number_of_non_space_integer_placeholder_digits")
    numberOfNonSpaceDecimalPlaceholderDigits = try reader.optional("number_of_non_space_decimal_placeholder_digits")
    indexFromRightOfLastDigitPlaceholder = try reader.optional("index_from_right_of_last_digit_placeholder")
    numberOfHashDecimalPlaceholders = try reader.optional("number_of_hash_decimal_placeholders")
    totalNumberOfDecimalPlaceholdersInFormat = try reader.optional("total_number_of_decimal_placeholders_in_format")
    currencyCode = try reader.optional("currency_code")
    showThousandsSeparator = try reader.optional("show_thousands_separator")
    useAccountingStyle = try reader.optional("use_accounting_style")
    requiresFractionReplacement = try reader.optional("requires_fraction_replacement")
    formatContainsIntegerToken = try reader.optional("format_contains_integer_token")
    isComplexFormat = try reader.optional("is_complex_format")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("scale_factor", scaleFactor)
    writer.optional("fraction_accuracy", fractionAccuracy)
    writer.optional("interstitial_strings", interstitialStrings)
    writer.optional("interstitial_string_insertion_indexes", interstitialStringInsertionIndexes)
    writer.optional("minimum_integer_width", minimumIntegerWidth)
    writer.optional("decimal_width", decimalWidth)
    writer.optional("number_of_non_space_integer_placeholder_digits", numberOfNonSpaceIntegerPlaceholderDigits)
    writer.optional("number_of_non_space_decimal_placeholder_digits", numberOfNonSpaceDecimalPlaceholderDigits)
    writer.optional("index_from_right_of_last_digit_placeholder", indexFromRightOfLastDigitPlaceholder)
    writer.optional("number_of_hash_decimal_placeholders", numberOfHashDecimalPlaceholders)
    writer.optional("total_number_of_decimal_placeholders_in_format", totalNumberOfDecimalPlaceholdersInFormat)
    writer.optional("currency_code", currencyCode)
    writer.optional("show_thousands_separator", showThousandsSeparator)
    writer.optional("use_accounting_style", useAccountingStyle)
    writer.optional("requires_fraction_replacement", requiresFractionReplacement)
    writer.optional("format_contains_integer_token", formatContainsIntegerToken)
    writer.optional("is_complex_format", isComplexFormat)
  }
}
