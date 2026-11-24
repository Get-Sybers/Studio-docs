public import WireFormat

/// A reason the presets of a document are not read or not resolved.
public enum PresetError: Error, Sendable, Hashable {
  /// `presets.json` is not a JSON array.
  case notAnArray
  /// The entry at this index is not an object with a string `identifier`.
  case entryWithoutIdentifier(index: Int)
  /// The preset has no `properties` object.
  case entryWithoutProperties(identifier: String)
  /// A member of the entry is of the wrong kind of JSON.
  case malformedEntry(identifier: String, member: String)
  /// The parents of a preset lead back to it; the value is the chain that closes.
  case cycle([String])
  /// A value that a preset supplies does not fit the object that adopts it.
  case inheritedValueInvalid(preset: String, underlying: WireError)
}
