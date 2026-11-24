public import JSONTree
public import WireFormat

/// The slide that a link jumps to, by identifier or by position.
public struct SlideTarget: WireUnion {
  /// The forms that the library models.
  public enum Form: Sendable, Hashable {
    /// The slide with this identifier.
    case byIdentifier(ObjectID)
    /// The first slide.
    case first
    /// The last slide.
    case last
    /// The slide viewed before this one.
    case lastViewed
    /// The slide after this one.
    case next
    /// The slide before this one.
    case previous
  }

  /// The facts of the type, from the format table.
  public static let schema = TextFormat.table.union(named: "SlideTarget")

  /// The form the value takes; nil when a preset supplies it or the library does not model it.
  public var form: Form?
  /// The version and preset of the value, and its members beside the form.
  public var envelope: ObjectEnvelope

  /// Creates a value from its parts.
  public init(form: Form?, envelope: ObjectEnvelope = ObjectEnvelope()) {
    self.form = form
    self.envelope = envelope
  }

  /// Makes the `by_identifier` form.
  public static func byIdentifier(_ value: ObjectID) -> SlideTarget {
    SlideTarget(.byIdentifier(value))
  }

  /// The `first` form.
  public static let first = SlideTarget(.first)

  /// The `last` form.
  public static let last = SlideTarget(.last)

  /// The `last_viewed` form.
  public static let lastViewed = SlideTarget(.lastViewed)

  /// The `next` form.
  public static let next = SlideTarget(.next)

  /// The `previous` form.
  public static let previous = SlideTarget(.previous)

  /// Reads the contents of a case; nil for a case the library does not model.
  public static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "by_identifier": .byIdentifier(try ObjectID(wire: contents))
    case "first": .first
    case "last": .last
    case "last_viewed": .lastViewed
    case "next": .next
    case "previous": .previous
    default: nil
    }
  }

  /// Names the case of a form, with its contents, or nil for a form that has none.
  public static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .byIdentifier(let value): ("by_identifier", value.wireValue)
    case .first: ("first", nil)
    case .last: ("last", nil)
    case .lastViewed: ("last_viewed", nil)
    case .next: ("next", nil)
    case .previous: ("previous", nil)
    }
  }
}
