public import JSONTree
public import WireFormat

/// A named set of properties that objects adopt, as one entry of `presets.json` holds it.
public struct Preset: Sendable, Hashable {
  /// The name that an object's `preset_identifier` refers to.
  public var identifier: String
  /// The name shown for the preset.
  public var displayName: String?
  /// The preset from which this one takes every property it does not set.
  public var parentIdentifier: String?
  /// The properties, as JSON: a member set to `null` clears the property for every object that adopts the preset.
  public var properties: JSONObject
  /// The members of the entry beside the four above, kept as read.
  public var unmodelled: JSONObject

  /// Creates a preset from properties as JSON.
  public init(
    identifier: String, properties: JSONObject = JSONObject(), displayName: String? = nil,
    parentIdentifier: String? = nil
  ) {
    self.identifier = identifier
    self.displayName = displayName
    self.parentIdentifier = parentIdentifier
    self.properties = properties
    self.unmodelled = JSONObject()
  }

  /// Creates a preset from the members that an object sets; its type identifier is left out.
  public init<Properties: WireObject>(
    identifier: String, properties: Properties, displayName: String? = nil, parentIdentifier: String? = nil
  ) {
    var members = properties.wireValue.objectValue ?? JSONObject()
    members.removeValue(forKey: "type_identifier")
    self.init(
      identifier: identifier, properties: members, displayName: displayName, parentIdentifier: parentIdentifier)
  }

  init(entry: JSONValue, index: Int) throws(PresetError) {
    guard let object = entry.objectValue, let identifier = object["identifier"]?.stringValue else {
      throw .entryWithoutIdentifier(index: index)
    }
    guard let properties = object["properties"] else { throw .entryWithoutProperties(identifier: identifier) }
    guard let properties = properties.objectValue else {
      throw .malformedEntry(identifier: identifier, member: "properties")
    }
    self.init(identifier: identifier, properties: properties)
    for (name, value) in object {
      switch (name, value) {
      case ("identifier", _), ("properties", _): break
      case ("display_name", .string(let text)): displayName = text
      case ("parent_identifier", .string(let text)): parentIdentifier = text
      case ("display_name", .null), ("parent_identifier", .null): unmodelled[name] = value
      case ("display_name", _), ("parent_identifier", _):
        throw .malformedEntry(identifier: identifier, member: name)
      default: unmodelled[name] = value
      }
    }
  }

  var entry: JSONValue {
    var object = unmodelled
    object["identifier"] = .string(identifier)
    if let displayName { object["display_name"] = .string(displayName) }
    if let parentIdentifier { object["parent_identifier"] = .string(parentIdentifier) }
    object["properties"] = .object(properties)
    return .object(object)
  }
}
