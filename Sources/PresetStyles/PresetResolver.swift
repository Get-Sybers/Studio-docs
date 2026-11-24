public import JSONTree
import OrderedCollections
public import WireFormat

/// Works out what an object's properties are once its presets and the format's defaults are applied.
///
/// The order is the format's: the object, its preset, that preset's parents, then the declared default.
public struct PresetResolver: Sendable {
  private let presets: OrderedDictionary<String, Preset>
  private let schemas: SchemaRegistry
  private let styles: [TypeIdentifier: [String: JSONObject]]

  /// Creates a resolver over a library.
  ///
  /// `styles` gives, for a type, named properties that an object of that type adopts ahead of the library's.
  public init(
    _ library: PresetLibrary, schemas: SchemaRegistry = .empty, styles: [TypeIdentifier: [String: JSONObject]] = [:]
  ) {
    presets = OrderedDictionary(library.presets.map { ($0.identifier, $0) }, uniquingKeysWith: { _, later in later })
    self.schemas = schemas
    self.styles = styles
  }

  /// The properties of a preset merged over those of its parents; a preset or a parent that is absent adds none.
  public func resolvedProperties(of identifier: String) throws(PresetError) -> JSONObject {
    var merged = JSONObject()
    var chain: [String] = []
    var next: String? = identifier
    while let current = next, let preset = presets[current] {
      guard !chain.contains(current) else { throw .cycle(chain + [current]) }
      chain.append(current)
      merged = merged.merging(over: preset.properties)
      next = preset.parentIdentifier
    }
    return merged
  }

  /// The object with every member that it leaves out taken from its presets, then from the declared defaults.
  ///
  /// The objects of `lower` supply what is still missing, the first of them first, before the defaults.
  public func effective<Object: WireObject>(
    _ object: Object, over lower: [Object] = [], applyingDefaults: Bool = true
  ) throws(PresetError) -> Object {
    var merged = try resolved(object.wireValue, adopting: [])
    for layer in lower {
      guard let own = merged.objectValue, let below = try resolved(layer.wireValue, adopting: []).objectValue
      else { continue }
      merged = .object(own.merging(over: below))
    }
    if applyingDefaults { merged = withDefaults(merged) }
    do throws(WireError) {
      return try Object(wire: merged)
    } catch {
      throw .inheritedValueInvalid(preset: object.envelope.presetIdentifier ?? "", underlying: error)
    }
  }

  /// A tree with the presets of every object in it applied, and each `preset_identifier` removed.
  public func resolved(_ tree: JSONValue) throws(PresetError) -> JSONValue {
    try resolved(tree, adopting: [])
  }

  // A preset already being applied is not applied again inside its own properties.
  private func resolved(_ value: JSONValue, adopting: [String]) throws(PresetError) -> JSONValue {
    switch value {
    case .array(let elements):
      var items: [JSONValue] = []
      items.reserveCapacity(elements.count)
      for element in elements {
        items.append(try resolved(element, adopting: adopting))
      }
      return .array(items)
    case .object(var object):
      var adopting = adopting
      if let identifier = object["preset_identifier"]?.stringValue {
        object.removeValue(forKey: "preset_identifier")
        if !adopting.contains(identifier) {
          adopting.append(identifier)
          if let type = object["type_identifier"]?.stringValue,
            let named = styles[TypeIdentifier(rawValue: type)]?[identifier]
          {
            object = object.merging(over: named)
          }
          object = object.merging(over: try resolvedProperties(of: identifier))
          object.removeValue(forKey: "preset_identifier")
        }
      }
      var members = JSONObject()
      for (name, member) in object {
        members[name] = try resolved(member, adopting: adopting)
      }
      return .object(members)
    case .null, .bool, .number, .string:
      return value
    }
  }

  private func withDefaults(_ value: JSONValue) -> JSONValue {
    switch value {
    case .array(let elements):
      return .array(elements.map(withDefaults))
    case .object(let object):
      var members = JSONObject()
      for (name, member) in object {
        members[name] = withDefaults(member)
      }
      if let type = object["type_identifier"]?.stringValue,
        let schema = schemas.object(TypeIdentifier(rawValue: type))
      {
        for member in schema.members where !members.contains(member.name) {
          members[member.name] = member.defaultValue
        }
      }
      return .object(members)
    case .null, .bool, .number, .string:
      return value
    }
  }
}
