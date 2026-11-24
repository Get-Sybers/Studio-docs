public import WireFormat

/// The type `table.conditional-style-set` of the format.
public struct ConditionalStyleSet: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TableModelFormat.table.object(named: "ConditionalStyleSet")

  /// The `rules` member.
  public var rules: [ConditionalStyleRule]
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(rules: [ConditionalStyleRule]) {
    self.rules = rules
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    rules = try reader.required("rules")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.required("rules", rules)
  }
}
