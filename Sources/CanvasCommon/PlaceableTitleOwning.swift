public import JSONTree
public import WireFormat

/// The union `placeable-title-owning` of the format.
public struct PlaceableTitleOwning: WireUnion {
  /// The forms that the library models; each is kept out of line, so the value stays small.
  public indirect enum Form: Sendable, Hashable {
    /// The `genericPlaceableTitleOwning` form.
    case genericPlaceableTitleOwning(GenericPlaceableTitleOwning)
  }

  /// The facts of the type, from the format table.
  public static let schema = CanvasCommonFormat.table.union(named: "PlaceableTitleOwning")

  /// The form the value takes; nil when a preset supplies it or the library does not model it.
  public var form: Form?
  /// The version and preset of the value, and its members beside the form.
  public var envelope: ObjectEnvelope

  /// Creates a value from its parts.
  public init(form: Form?, envelope: ObjectEnvelope = ObjectEnvelope()) {
    self.form = form
    self.envelope = envelope
  }

  /// Makes the `genericPlaceableTitleOwning` form.
  public static func genericPlaceableTitleOwning(_ value: GenericPlaceableTitleOwning) -> PlaceableTitleOwning {
    PlaceableTitleOwning(.genericPlaceableTitleOwning(value))
  }

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "genericPlaceableTitleOwning": .genericPlaceableTitleOwning(try GenericPlaceableTitleOwning(wire: contents))
    default: nil
    }
  }

  /// Names the case of a form, with its contents, or nil for a form that has none.
  public static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .genericPlaceableTitleOwning(let value): ("genericPlaceableTitleOwning", value.wireValue)
    }
  }
}
