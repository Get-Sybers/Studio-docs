public import JSONTree
public import WireFormat

/// The union `correlation-chart` of the format.
public struct CorrelationChart: WireUnion {
  /// The forms that the library models; each is kept out of line, so the value stays small.
  public indirect enum Form: Sendable, Hashable {
    /// The `bubbleChart` form.
    case bubbleChart(BubbleChart)
    /// The `bubbleInteractiveChart` form.
    case bubbleInteractiveChart(BubbleInteractiveChart)
    /// The `genericCorrelationChart` form.
    case genericCorrelationChart(GenericCorrelationChart)
    /// The `scatterChart` form.
    case scatterChart(ScatterChart)
    /// The `scatterInteractiveChart` form.
    case scatterInteractiveChart(ScatterInteractiveChart)
  }

  /// The facts of the type, from the format table.
  public static let schema = ChartModelFormat.table.union(named: "CorrelationChart")

  /// The form the value takes; nil when a preset supplies it or the library does not model it.
  public var form: Form?
  /// The version and preset of the value, and its members beside the form.
  public var envelope: ObjectEnvelope

  /// Creates a value from its parts.
  public init(form: Form?, envelope: ObjectEnvelope = ObjectEnvelope()) {
    self.form = form
    self.envelope = envelope
  }

  /// Makes the `bubbleChart` form.
  public static func bubbleChart(_ value: BubbleChart) -> CorrelationChart {
    CorrelationChart(.bubbleChart(value))
  }

  /// Makes the `bubbleInteractiveChart` form.
  public static func bubbleInteractiveChart(_ value: BubbleInteractiveChart) -> CorrelationChart {
    CorrelationChart(.bubbleInteractiveChart(value))
  }

  /// Makes the `genericCorrelationChart` form.
  public static func genericCorrelationChart(_ value: GenericCorrelationChart) -> CorrelationChart {
    CorrelationChart(.genericCorrelationChart(value))
  }

  /// Makes the `scatterChart` form.
  public static func scatterChart(_ value: ScatterChart) -> CorrelationChart {
    CorrelationChart(.scatterChart(value))
  }

  /// Makes the `scatterInteractiveChart` form.
  public static func scatterInteractiveChart(_ value: ScatterInteractiveChart) -> CorrelationChart {
    CorrelationChart(.scatterInteractiveChart(value))
  }

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "bubbleChart": .bubbleChart(try BubbleChart(wire: contents))
    case "bubbleInteractiveChart": .bubbleInteractiveChart(try BubbleInteractiveChart(wire: contents))
    case "genericCorrelationChart": .genericCorrelationChart(try GenericCorrelationChart(wire: contents))
    case "scatterChart": .scatterChart(try ScatterChart(wire: contents))
    case "scatterInteractiveChart": .scatterInteractiveChart(try ScatterInteractiveChart(wire: contents))
    default: nil
    }
  }

  /// Names the case of a form, with its contents, or nil for a form that has none.
  public static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .bubbleChart(let value): ("bubbleChart", value.wireValue)
    case .bubbleInteractiveChart(let value): ("bubbleInteractiveChart", value.wireValue)
    case .genericCorrelationChart(let value): ("genericCorrelationChart", value.wireValue)
    case .scatterChart(let value): ("scatterChart", value.wireValue)
    case .scatterInteractiveChart(let value): ("scatterInteractiveChart", value.wireValue)
    }
  }
}
