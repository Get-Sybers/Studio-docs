public import CanvasCommon
public import JSONTree
public import TableModel
public import WireFormat

/// The union `chart-data.chart-data-value` of the format.
public struct ChartDataValue: WireUnion {
  /// The forms that the library models; each is kept out of line, so the value stays small.
  public indirect enum Form: Sendable, Hashable {
    /// The `date` form.
    case date(TableDate)
    /// The `duration` form.
    case duration(DurationValue)
    /// The `empty` form.
    case empty
    /// The `number` form.
    case number(Double)
  }

  /// The facts of the type, from the format table.
  public static let schema = ChartModelFormat.table.union(named: "ChartDataValue")

  /// The form the value takes; nil when a preset supplies it or the library does not model it.
  public var form: Form?
  /// The version and preset of the value, and its members beside the form.
  public var envelope: ObjectEnvelope

  /// Creates a value from its parts.
  public init(form: Form?, envelope: ObjectEnvelope = ObjectEnvelope()) {
    self.form = form
    self.envelope = envelope
  }

  /// Makes the `date` form.
  public static func date(_ value: TableDate) -> ChartDataValue {
    ChartDataValue(.date(value))
  }

  /// Makes the `duration` form.
  public static func duration(_ value: DurationValue) -> ChartDataValue {
    ChartDataValue(.duration(value))
  }

  /// The `empty` form.
  public static let empty = ChartDataValue(.empty)

  /// Makes the `number` form.
  public static func number(_ value: Double) -> ChartDataValue {
    ChartDataValue(.number(value))
  }

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "date": .date(try TableDate(wire: contents))
    case "duration": .duration(try DurationValue(wire: contents))
    case "empty": .empty
    case "number": .number(try Double(wire: contents))
    default: nil
    }
  }

  /// Names the case of a form, with its contents, or nil for a form that has none.
  public static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .date(let value): ("date", value.wireValue)
    case .duration(let value): ("duration", value.wireValue)
    case .empty: ("empty", nil)
    case .number(let value): ("number", value.wireValue)
    }
  }
}
