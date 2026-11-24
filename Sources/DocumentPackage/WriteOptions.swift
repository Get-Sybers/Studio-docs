public import JSONTree

/// How a document is written.
public struct WriteOptions: Sendable, Hashable {
  /// How the three JSON files are written; compact unless set.
  public var style: JSONStyle
  /// Whether a document with a validation error is refused; true unless set.
  public var refusesInvalid: Bool

  /// Creates options.
  public init(style: JSONStyle = .compact, refusesInvalid: Bool = true) {
    self.style = style
    self.refusesInvalid = refusesInvalid
  }
}
