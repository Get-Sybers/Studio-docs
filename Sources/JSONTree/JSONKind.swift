/// The six kinds of JSON value.
public enum JSONKind: String, Sendable, Hashable, CaseIterable {
  /// The literal `null`.
  case null
  /// `true` or `false`.
  case boolean
  /// A number.
  case number
  /// A string.
  case string
  /// An array.
  case array
  /// An object.
  case object
}
