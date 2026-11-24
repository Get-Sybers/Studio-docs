public import WireFormat

/// The enumeration `LoopOption` of the format.
public struct LoopOption: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The value `back_and_forth`.
  public static let backAndForth = LoopOption(rawValue: "back_and_forth")
  /// The value `none`.
  public static let off = LoopOption(rawValue: "none")
  /// The value `repeating`.
  public static let repeating = LoopOption(rawValue: "repeating")

  /// The values that the library knows, from the format table.
  public static let modelled = CanvasModelFormat.table.values(of: "LoopOption").map(LoopOption.init(rawValue:))
}
