public import JSONTree

/// A set of named values that the format writes as strings, and that a later version may extend.
///
/// A value outside `modelled` is kept and written back as it was read.
public protocol WireEnumeration: WireValue, RawRepresentable, Hashable, Codable where RawValue == String {
  /// Creates a value from its text, known or not.
  init(rawValue: String)

  /// The values that the library knows.
  static var modelled: [Self] { get }
}

extension WireEnumeration {
  /// Reads a JSON string.
  public init(wire value: JSONValue) throws(WireError) {
    self.init(rawValue: try String(wire: value))
  }

  /// The value as a JSON string.
  public var wireValue: JSONValue { .string(rawValue) }

  /// Whether the library knows the value.
  public var isModelled: Bool { Self.modelled.contains(self) }

  /// Reads the value through any decoder.
  public init(from decoder: any Decoder) throws {
    self.init(rawValue: try decoder.singleValueContainer().decode(String.self))
  }

  /// Writes the value through any encoder.
  public func encode(to encoder: any Encoder) throws {
    var single = encoder.singleValueContainer()
    try single.encode(rawValue)
  }
}
