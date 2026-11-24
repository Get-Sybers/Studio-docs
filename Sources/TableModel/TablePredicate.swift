public import WireFormat

/// The type `table.predicate` of the format.
public struct TablePredicate: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "TablePredicate")

  /// The `predicate_type` member.
  public var predicateType: PredicateType
  /// The `value1` member.
  public var value1: PredicateValue?
  /// The `value2` member.
  public var value2: PredicateValue?
  /// The `qualifier` member.
  public var qualifier: TextQualifier?
  /// The `date_qualifier1` member.
  public var dateQualifier1: DateQualifier?
  /// The `date_qualifier2` member.
  public var dateQualifier2: DateQualifier?
  /// The `duration_unit1` member.
  public var durationUnit1: PredicateDurationUnit?
  /// The `duration_unit2` member.
  public var durationUnit2: PredicateDurationUnit?
  /// The `value_list` member.
  public var valueList: [PredicateValue]?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    predicateType: PredicateType, value1: PredicateValue? = nil, value2: PredicateValue? = nil,
    qualifier: TextQualifier? = nil, dateQualifier1: DateQualifier? = nil, dateQualifier2: DateQualifier? = nil,
    durationUnit1: PredicateDurationUnit? = nil, durationUnit2: PredicateDurationUnit? = nil,
    valueList: [PredicateValue]? = nil
  ) {
    self.predicateType = predicateType
    self.value1 = value1
    self.value2 = value2
    self.qualifier = qualifier
    self.dateQualifier1 = dateQualifier1
    self.dateQualifier2 = dateQualifier2
    self.durationUnit1 = durationUnit1
    self.durationUnit2 = durationUnit2
    self.valueList = valueList
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    predicateType = try reader.required("predicate_type")
    value1 = try reader.optional("value1")
    value2 = try reader.optional("value2")
    qualifier = try reader.optional("qualifier")
    dateQualifier1 = try reader.optional("date_qualifier1")
    dateQualifier2 = try reader.optional("date_qualifier2")
    durationUnit1 = try reader.optional("duration_unit1")
    durationUnit2 = try reader.optional("duration_unit2")
    valueList = try reader.optional("value_list")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("predicate_type", predicateType)
    writer.optional("value1", value1)
    writer.optional("value2", value2)
    writer.optional("qualifier", qualifier)
    writer.optional("date_qualifier1", dateQualifier1)
    writer.optional("date_qualifier2", dateQualifier2)
    writer.optional("duration_unit1", durationUnit1)
    writer.optional("duration_unit2", durationUnit2)
    writer.optional("value_list", valueList)
  }
}
