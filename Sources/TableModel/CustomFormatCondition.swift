public import WireFormat

/// The type `table.custom-format.custom-format-condition` of the format.
public struct CustomFormatCondition: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "CustomFormatCondition")

  /// The `condition_type` member.
  public var conditionType: FormatConditionType
  /// The `condition_value` member.
  public var conditionValue: Double
  /// The `format_string` member.
  public var formatString: String
  /// The `number_format_data` member.
  public var numberFormatData: NumberFormatData?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    conditionType: FormatConditionType, conditionValue: Double, formatString: String,
    numberFormatData: NumberFormatData? = nil
  ) {
    self.conditionType = conditionType
    self.conditionValue = conditionValue
    self.formatString = formatString
    self.numberFormatData = numberFormatData
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    conditionType = try reader.required("condition_type")
    conditionValue = try reader.required("condition_value")
    formatString = try reader.required("format_string")
    numberFormatData = try reader.optional("number_format_data")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("condition_type", conditionType)
    writer.required("condition_value", conditionValue)
    writer.required("format_string", formatString)
    writer.optional("number_format_data", numberFormatData)
  }
}
