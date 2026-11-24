extension JSONValue {
  /// Calls `visit` for this value and for every value below it, a parent before its children.
  ///
  /// The steps are those of the value's path below `prefix`, and are valid only during the call.
  public func walk<Failure: Error>(
    from prefix: JSONPath = .root, _ visit: (JSONValue, [JSONPath.Component]) throws(Failure) -> Void
  ) throws(Failure) {
    var steps = prefix.components
    try walk(&steps, visit)
  }

  private func walk<Failure: Error>(
    _ steps: inout [JSONPath.Component], _ visit: (JSONValue, [JSONPath.Component]) throws(Failure) -> Void
  ) throws(Failure) {
    try visit(self, steps)
    switch self {
    case .array(let elements):
      for (index, element) in elements.enumerated() {
        steps.append(.index(index))
        defer { steps.removeLast() }
        try element.walk(&steps, visit)
      }
    case .object(let object):
      for (name, value) in object {
        steps.append(.member(name))
        defer { steps.removeLast() }
        try value.walk(&steps, visit)
      }
    case .null, .bool, .number, .string:
      break
    }
  }
}
