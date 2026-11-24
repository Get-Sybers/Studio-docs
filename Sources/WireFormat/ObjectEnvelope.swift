public import JSONTree

/// What every object of the format may carry beside the members of its type.
public struct ObjectEnvelope: Sendable, Hashable {
  /// The `identifier` member, on a type that does not give that member a meaning of its own.
  public var identifier: ObjectID?
  /// The `version` member: the version of its type that the object declares, if it declares one.
  public var version: FormatVersion?
  /// The `preset_identifier` member: the preset whose properties the object adopts.
  public var presetIdentifier: String?
  /// Every member that the type does not model, a client's own members included, kept as read.
  public var unmodelled: JSONObject

  /// Creates an envelope; with no arguments it adds nothing to an object.
  public init(
    identifier: ObjectID? = nil, version: FormatVersion? = nil, presetIdentifier: String? = nil,
    unmodelled: JSONObject = JSONObject()
  ) {
    self.identifier = identifier
    self.version = version
    self.presetIdentifier = presetIdentifier
    self.unmodelled = unmodelled
  }

  /// Whether the envelope adds nothing to an object.
  public var isEmpty: Bool {
    identifier == nil && version == nil && presetIdentifier == nil && unmodelled.isEmpty
  }
}
