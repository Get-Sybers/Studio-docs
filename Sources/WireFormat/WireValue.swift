public import JSONTree

/// A value with a form in the format's JSON.
public protocol WireValue: Sendable {
  /// Reads the value from its JSON; an error names the place by a path below this value.
  init(wire value: JSONValue) throws(WireError)

  /// The value as JSON.
  var wireValue: JSONValue { get }
}

extension WireValue {
  /// Reads an element or a member of a container, and places a failure below that step.
  package static func read(_ value: JSONValue, under component: JSONPath.Component) throws(WireError) -> Self {
    do throws(WireError) {
      return try Self(wire: value)
    } catch {
      throw error.nested(under: component)
    }
  }
}
