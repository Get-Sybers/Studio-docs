public import JSONTree

/// A reason a JSON value is not the value of the type that its place calls for.
public enum WireError: Error, Sendable, Hashable {
  /// A member that the type requires is absent.
  case missingMember(String, at: JSONPath)
  /// A member that the type requires is `null`, which is a value and no stand-in for one.
  case nullMember(String, at: JSONPath)
  /// The value is of another kind of JSON than the type takes.
  case unexpectedKind(expected: JSONKind, found: JSONKind, at: JSONPath)
  /// A number with a fraction, or beyond the range of an integer, stands where the type takes an integer.
  case notAnInteger(at: JSONPath)
  /// The object names a type other than the one its place calls for.
  case typeMismatch(expected: TypeIdentifier, found: String, at: JSONPath)
  /// The object declares a major version of its type that the library does not model.
  case unsupportedVersion(type: TypeIdentifier, declared: FormatVersion, modelled: FormatVersion, at: JSONPath)

  /// Where in the tree the value stands.
  public var path: JSONPath {
    switch self {
    case .missingMember(_, let path), .nullMember(_, let path), .unexpectedKind(_, _, let path),
      .notAnInteger(let path), .typeMismatch(_, _, let path), .unsupportedVersion(_, _, _, let path):
      path
    }
  }

  /// Returns the same error with its path placed below one more step.
  public func nested(under component: JSONPath.Component) -> WireError {
    let nest = { (path: JSONPath) in JSONPath([component] + path.components) }
    return switch self {
    case .missingMember(let name, let path): .missingMember(name, at: nest(path))
    case .nullMember(let name, let path): .nullMember(name, at: nest(path))
    case .unexpectedKind(let expected, let found, let path):
      .unexpectedKind(expected: expected, found: found, at: nest(path))
    case .notAnInteger(let path): .notAnInteger(at: nest(path))
    case .typeMismatch(let expected, let found, let path):
      .typeMismatch(expected: expected, found: found, at: nest(path))
    case .unsupportedVersion(let type, let declared, let modelled, let path):
      .unsupportedVersion(type: type, declared: declared, modelled: modelled, at: nest(path))
    }
  }
}
