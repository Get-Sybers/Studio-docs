public import JSONTree
public import WireFormat

/// The bytes of an image or other media: carried in the JSON, or kept as a file of the package.
public struct ResourceReference: WireUnion {
  /// The forms that the library models.
  public enum Form: Sendable, Hashable {
    /// The bytes are in the JSON, as Base64.
    case embedded(EmbeddedResource)
    /// The bytes are a file in the package's `Data` directory.
    case indirect(IndirectResource)
  }

  /// The facts of the type, from the format table.
  public static let schema = ResourceFormat.table.union(named: "ResourceReference")

  /// The form the value takes; nil when a preset supplies it or the library does not model it.
  public var form: Form?
  /// The version and preset of the value, and its members beside the form.
  public var envelope: ObjectEnvelope

  /// Creates a value from its parts.
  public init(form: Form?, envelope: ObjectEnvelope = ObjectEnvelope()) {
    self.form = form
    self.envelope = envelope
  }

  /// Makes the `base64_encoded` form.
  public static func embedded(_ value: EmbeddedResource) -> ResourceReference {
    ResourceReference(.embedded(value))
  }

  /// Makes the `indirect` form.
  public static func indirect(_ value: IndirectResource) -> ResourceReference {
    ResourceReference(.indirect(value))
  }

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "base64_encoded": .embedded(try EmbeddedResource(wire: contents))
    case "indirect": .indirect(try IndirectResource(wire: contents))
    default: nil
    }
  }

  /// Names the case of a form, with its contents, or nil for a form that has none.
  public static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .embedded(let value): ("base64_encoded", value.wireValue)
    case .indirect(let value): ("indirect", value.wireValue)
    }
  }
}
