import BitCollections
public import JSONTree

/// A value of the format that takes one of several named forms.
///
/// It is written as an object with one member, named for the form, or as the name alone for a form with no contents.
public protocol WireUnion: WireValue, Codable, Hashable {
  /// The forms that the library models.
  associatedtype Form: Sendable, Hashable

  /// The facts of the type.
  static var schema: UnionSchema { get }

  /// The form the value takes; nil when a preset supplies it or when the library does not model it.
  var form: Form? { get set }

  /// The version and preset of the value, and its members beside the form: other cases and `primary_case`.
  var envelope: ObjectEnvelope { get set }

  /// Creates a value from its parts.
  init(form: Form?, envelope: ObjectEnvelope)

  /// Reads the contents of a case; returns nil for a case that the type does not model.
  static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form?

  /// Names the case of a form, with its contents, or nil for a form that has none.
  static func member(for form: Form) -> (name: String, contents: JSONValue?)
}

extension WireUnion {
  /// The name of the type.
  public static var typeIdentifier: TypeIdentifier { schema.typeIdentifier }

  /// Creates a value that takes a form.
  public init(_ form: Form) {
    self.init(form: form, envelope: ObjectEnvelope())
  }

  /// Reads a value: of the cases present, the one that `primary_case` names, or else the newest.
  public init(wire value: JSONValue) throws(WireError) {
    switch value {
    case .string(let name):
      if Self.schema.case(named: name)?.isValueless == true, let form = try Self.readForm(named: name, from: .null) {
        self.init(form: form, envelope: ObjectEnvelope())
      } else {
        self.init(form: nil, envelope: ObjectEnvelope(unmodelled: [name: .null]))
      }
    case .object(let object):
      var taken = BitSet()
      let declared = try ObjectEnvelope.header(
        of: object, type: Self.schema.typeIdentifier, modelled: Self.schema.version, taken: &taken)
      let present = Self.schema.cases.filter { object.contains($0.name) && $0.since <= declared ?? $0.since }
      let named = object[EnvelopeMember.primaryCase]?.stringValue
      let chosen =
        present.first { $0.name == named }
        ?? present.min { ($1.since, $0.name) < ($0.since, $1.name) }
      var form: Form?
      if let chosen, let position = object.position(of: chosen.name) {
        do throws(WireError) {
          form = try Self.readForm(named: chosen.name, from: object.member(at: position).value)
        } catch {
          throw error.nested(under: .member(chosen.name))
        }
        if form != nil { taken.insert(position) }
      }
      self.init(form: form, envelope: ObjectEnvelope(of: object, declared: declared, taken: taken))
    case .null, .bool, .number, .array:
      throw .unexpectedKind(expected: .object, found: value.kind, at: .root)
    }
  }

  /// The value as JSON: the name alone when that says everything, or else an object with its `type_identifier`.
  public var wireValue: JSONValue {
    var members = JSONObject()
    var needed = FormatVersion.initial
    var envelope = envelope
    if let form {
      let (name, contents) = Self.member(for: form)
      if envelope.isEmpty, contents == nil { return .string(name) }
      members[name] = contents ?? .null
      needed = Self.schema.case(named: name)?.since ?? .initial
    } else if envelope.unmodelled.count == 1, let only = envelope.unmodelled.keys.first,
      envelope.unmodelled[only] == .some(.null), ObjectEnvelope(unmodelled: envelope.unmodelled) == envelope
    {
      return .string(only)
    }
    // A `primary_case` that names a case no longer present would point a reader at nothing.
    if let primary = envelope.unmodelled[EnvelopeMember.primaryCase]?.stringValue,
      !members.contains(primary), !envelope.unmodelled.contains(primary)
    {
      envelope.unmodelled.removeValue(forKey: EnvelopeMember.primaryCase)
    }
    envelope.write(into: &members, type: Self.schema.typeIdentifier, needed: needed)
    return .object(members)
  }

  /// The `preset_identifier` member of the value.
  public var presetIdentifier: String? {
    get { envelope.presetIdentifier }
    set { envelope.presetIdentifier = newValue }
  }

  /// Reads the value through any decoder, by way of the JSON tree.
  public init(from decoder: any Decoder) throws {
    try self.init(wire: JSONValue(from: decoder))
  }

  /// Writes the value through any encoder, by way of the JSON tree.
  public func encode(to encoder: any Encoder) throws {
    try wireValue.encode(to: encoder)
  }
}
