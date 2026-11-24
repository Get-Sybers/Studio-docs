public import JSONTree

/// What a type writes its members to.
public struct ObjectWriter {
  private var members = JSONObject()
  private let schema: ObjectSchema
  private var needed = FormatVersion.initial
  private var modelsIdentifier = false

  init(schema: ObjectSchema) {
    self.schema = schema
  }

  /// Writes a member that the type requires.
  public mutating func required<Value: WireValue>(_ name: String, _ value: Value) {
    put(name, value.wireValue)
  }

  /// Writes a member that may be omitted; nil writes nothing.
  public mutating func optional<Value: WireValue>(_ name: String, _ value: Value?) {
    guard let value else { return }
    put(name, value.wireValue)
  }

  /// Writes a member that may be omitted or `null`: `.inherited` writes nothing and `.cleared` writes `null`.
  public mutating func inheritable<Value: WireValue>(_ name: String, _ value: Inheritable<Value>) {
    switch value {
    case .inherited: break
    case .cleared: put(name, .null)
    case .value(let value): put(name, value.wireValue)
    }
  }

  mutating func finish(_ envelope: ObjectEnvelope) -> JSONObject {
    envelope.write(
      into: &members, type: schema.typeIdentifier, needed: needed, modelsIdentifier: modelsIdentifier)
    return members
  }

  private mutating func put(_ name: String, _ value: JSONValue) {
    members[name] = value
    modelsIdentifier = modelsIdentifier || name == EnvelopeMember.identifier
    if let since = schema.introductions[name] { needed = max(needed, since) }
  }
}
