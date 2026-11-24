public import WireFormat

/// The type `table.custom-format` of the format.
public struct CustomFormat: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "CustomFormat")

  /// The `format_name` member.
  public var formatName: String?
  /// The `format_string` member.
  public var formatString: String
  /// The `format_type` member; "number" when omitted.
  public var formatType: CustomFormatType?
  /// The `number_format_data` member.
  public var numberFormatData: NumberFormatData?
  /// The `conditions` member.
  public var conditions: [CustomFormatCondition]?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    formatName: String? = nil, formatString: String, formatType: CustomFormatType? = nil,
    numberFormatData: NumberFormatData? = nil, conditions: [CustomFormatCondition]? = nil
  ) {
    self.formatName = formatName
    self.formatString = formatString
    self.formatType = formatType
    self.numberFormatData = numberFormatData
    self.conditions = conditions
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    formatName = try reader.optional("format_name")
    formatString = try reader.required("format_string")
    formatType = try reader.optional("format_type")
    numberFormatData = try reader.optional("number_format_data")
    conditions = try reader.optional("conditions")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("format_name", formatName)
    writer.required("format_string", formatString)
    writer.optional("format_type", formatType)
    writer.optional("number_format_data", numberFormatData)
    writer.optional("conditions", conditions)
  }
}
