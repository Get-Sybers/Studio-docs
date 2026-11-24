public import JSONTree

/// An object of the format: a type with a name, members, and an envelope for everything else.
///
/// A conforming type names its members twice, to read and to write; the library adds the envelope.
public protocol WireObject: WireValue, Codable, Hashable {
  /// The facts of the type.
  static var schema: ObjectSchema { get }

  /// The identifier, version and preset of the object, and the members that the type does not model.
  var envelope: ObjectEnvelope { get set }

  /// Reads the members of the type; the envelope is filled in afterwards.
  init(reading reader: inout ObjectReader) throws(WireError)

  /// Writes the members of the type; the envelope is added afterwards.
  func write(to writer: inout ObjectWriter)
}

extension WireObject {
  /// The name of the type.
  public static var typeIdentifier: TypeIdentifier { schema.typeIdentifier }

  /// Reads an object: the members of the type, then the envelope from what the type did not take.
  public init(wire value: JSONValue) throws(WireError) {
    guard case .object(let object) = value else {
      throw .unexpectedKind(expected: .object, found: value.kind, at: .root)
    }
    var reader = try ObjectReader(object, schema: Self.schema)
    self = try Self(reading: &reader)
    envelope = reader.finish()
  }

  /// The object as JSON, with its `type_identifier`.
  public var wireValue: JSONValue {
    var writer = ObjectWriter(schema: Self.schema)
    write(to: &writer)
    return .object(writer.finish(envelope))
  }

  /// The `identifier` member of the object.
  public var identifier: ObjectID? {
    get { envelope.identifier }
    set { envelope.identifier = newValue }
  }

  /// The `preset_identifier` member of the object.
  public var presetIdentifier: String? {
    get { envelope.presetIdentifier }
    set { envelope.presetIdentifier = newValue }
  }

  /// Reads the object through any decoder, by way of the JSON tree.
  public init(from decoder: any Decoder) throws {
    try self.init(wire: JSONValue(from: decoder))
  }

  /// Writes the object through any encoder, by way of the JSON tree.
  public func encode(to encoder: any Encoder) throws {
    try wireValue.encode(to: encoder)
  }
}
