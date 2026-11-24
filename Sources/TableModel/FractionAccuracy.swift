public import WireFormat

/// The enumeration `Accuracy` of the format.
public struct FractionAccuracy: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The value `conflicting`.
  public static let conflicting = FractionAccuracy(rawValue: "conflicting")
  /// The value `eighths`.
  public static let eighths = FractionAccuracy(rawValue: "eighths")
  /// The value `halves`.
  public static let halves = FractionAccuracy(rawValue: "halves")
  /// The value `hundredths`.
  public static let hundredths = FractionAccuracy(rawValue: "hundredths")
  /// The value `quarters`.
  public static let quarters = FractionAccuracy(rawValue: "quarters")
  /// The value `sixteenths`.
  public static let sixteenths = FractionAccuracy(rawValue: "sixteenths")
  /// The value `tenths`.
  public static let tenths = FractionAccuracy(rawValue: "tenths")
  /// The value `up_to_one_digit`.
  public static let upToOneDigit = FractionAccuracy(rawValue: "up_to_one_digit")
  /// The value `up_to_three_digits`.
  public static let upToThreeDigits = FractionAccuracy(rawValue: "up_to_three_digits")
  /// The value `up_to_two_digits`.
  public static let upToTwoDigits = FractionAccuracy(rawValue: "up_to_two_digits")

  /// The values that the library knows, from the format table.
  public static let modelled = TableModelFormat.table.values(of: "FractionAccuracy").map(
    FractionAccuracy.init(rawValue:))
}
