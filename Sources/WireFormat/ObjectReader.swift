import BitCollections
public import JSONTree

/// What a type reads its members from; a member it does not take stays with the object.
public struct ObjectReader {
  private let object: JSONObject
  private let schema: ObjectSchema
  private let declared: FormatVersion?
  private var taken = BitSet()

  init(_ object: JSONObject, schema: ObjectSchema) throws(WireError) {
    self.object = object
    self.schema = schema
    self.declared = try ObjectEnvelope.header(
      of: object, type: schema.typeIdentifier, modelled: schema.version, taken: &taken)
  }

  /// Reads a member that the type requires.
  public mutating func required<Value: WireValue>(
    _ name: String, as type: Value.Type = Value.self
  ) throws(WireError) -> Value {
    guard let position = position(of: name) else { throw .missingMember(name, at: .root) }
    let value = object.member(at: position).value
    guard !value.isNull else { throw .nullMember(name, at: .root) }
    taken.insert(position)
    return try Value.read(value, under: .member(name))
  }

  /// Reads a member that may be omitted; a `null` there is left with the object and reads as absent.
  public mutating func optional<Value: WireValue>(
    _ name: String, as type: Value.Type = Value.self
  ) throws(WireError) -> Value? {
    guard let position = position(of: name) else { return nil }
    let value = object.member(at: position).value
    guard !value.isNull else { return nil }
    taken.insert(position)
    return try Value.read(value, under: .member(name))
  }

  /// Reads a member that may be omitted, to inherit, or `null`, to clear.
  public mutating func inheritable<Value: WireValue>(
    _ name: String, as type: Value.Type = Value.self
  ) throws(WireError) -> Inheritable<Value> {
    guard let position = position(of: name) else { return .inherited }
    let value = object.member(at: position).value
    taken.insert(position)
    return value.isNull ? .cleared : .value(try Value.read(value, under: .member(name)))
  }

  mutating func finish() -> ObjectEnvelope {
    ObjectEnvelope(of: object, declared: declared, taken: taken)
  }

  // A member newer than the version its object declares is not part of the object at that version.
  private func position(of name: String) -> Int? {
    guard let position = object.position(of: name) else { return nil }
    if let declared, let since = schema.introductions[name], since > declared { return nil }
    return position
  }
}
