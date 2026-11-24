public import WireFormat

/// The type `category-comparison-chart-generic` of the format.
public struct GenericCategoryComparisonChart: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = ChartModelFormat.table.object(named: "GenericCategoryComparisonChart")

  /// The `category_axis` member; kept out of line, so the value stays small.
  public var categoryAxis: Indirect<ChartCategoryAxis>?
  /// The `value_axis` member; kept out of line, so the value stays small.
  public var valueAxis: Indirect<ChartValueAxis>?
  /// The `value_axis_secondary` member; kept out of line, so the value stays small.
  public var valueAxisSecondary: Indirect<ChartValueAxis>?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    categoryAxis: ChartCategoryAxis? = nil, valueAxis: ChartValueAxis? = nil, valueAxisSecondary: ChartValueAxis? = nil
  ) {
    self.categoryAxis = categoryAxis.map(Indirect.init)
    self.valueAxis = valueAxis.map(Indirect.init)
    self.valueAxisSecondary = valueAxisSecondary.map(Indirect.init)
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    categoryAxis = try reader.optional("category_axis")
    valueAxis = try reader.optional("value_axis")
    valueAxisSecondary = try reader.optional("value_axis_secondary")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("category_axis", categoryAxis)
    writer.optional("value_axis", valueAxis)
    writer.optional("value_axis_secondary", valueAxisSecondary)
  }
}
