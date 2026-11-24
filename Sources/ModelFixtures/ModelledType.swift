package import JSONTree
package import WireFormat

/// One type that a target models, in a form that a table of tests can hold: its schema and a way to read it.
package struct ModelledType: Sendable, CustomStringConvertible {
  /// What reading a sample gave.
  package struct Reading: Sendable {
    /// The sample as the type writes it back.
    package var written: JSONValue
    /// The members that the type left unread.
    package var unmodelled: [String]
    /// Whether a union read a form; true for an object.
    package var hasForm: Bool
  }

  /// The name of the Swift type.
  package let name: String
  /// The name of the type in the format.
  package let typeIdentifier: TypeIdentifier
  /// The members of an object type, or the cases of a union, as the schema lists them.
  package let parts: [String]
  /// Whether the type is a union.
  package let isUnion: Bool
  private let reader: @Sendable (JSONValue) throws(WireError) -> Reading

  /// Describes an object type.
  package init<Object: WireObject>(_ type: Object.Type) {
    name = "\(Object.self)"
    typeIdentifier = Object.schema.typeIdentifier
    parts = Object.schema.members.map(\.name)
    isUnion = false
    reader = { sample throws(WireError) in
      let object = try Object(wire: sample)
      return Reading(written: object.wireValue, unmodelled: object.envelope.unmodelled.keys, hasForm: true)
    }
  }

  /// Describes a union type.
  package init<Union: WireUnion>(_ type: Union.Type) {
    name = "\(Union.self)"
    typeIdentifier = Union.schema.typeIdentifier
    parts = Union.schema.cases.map(\.name)
    isUnion = true
    reader = { sample throws(WireError) in
      let union = try Union(wire: sample)
      return Reading(
        written: union.wireValue, unmodelled: union.envelope.unmodelled.keys, hasForm: union.form != nil)
    }
  }

  /// Reads a sample as the type and writes it back.
  package func read(_ sample: JSONValue) throws(WireError) -> Reading {
    try reader(sample)
  }

  package var description: String { name }
}
