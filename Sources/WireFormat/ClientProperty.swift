/// A member that a client adds to an object of a type it does not own, such as a mark on a paragraph.
///
/// The value lives among the object's unmodelled members, so every reader and writer of the library keeps it.
public struct ClientProperty<Value: WireValue>: Sendable, Hashable {
  /// The name of the member in JSON; it has to differ from every member that the format gives the type.
  public let name: String

  /// Names a member.
  public init(_ name: String) {
    self.name = name
  }
}
