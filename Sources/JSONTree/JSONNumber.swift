/// A JSON number: a whole number kept exactly when it fits 64 bits, or else a double.
///
/// A double with no fraction is kept as a whole number, so `1` and `1.0` are one value, as in the format.
public struct JSONNumber: Sendable, Hashable {
  private enum Storage: Sendable, Hashable {
    case integer(Int64)
    case unsigned(UInt64)
    case floating(bits: UInt64)
  }

  private let storage: Storage

  /// Creates a whole number.
  public init(_ value: Int64) {
    storage = .integer(value)
  }

  /// Creates a whole number.
  public init(_ value: Int) {
    storage = .integer(Int64(value))
  }

  /// Creates a whole number, which may lie beyond the range of `Int64`.
  public init(_ value: UInt64) {
    storage = Int64(exactly: value).map(Storage.integer) ?? .unsigned(value)
  }

  /// Creates a number from a double; a value that is not finite is kept, and JSON text cannot spell it.
  public init(_ value: Double) {
    if let whole = Int64(exactly: value) {
      storage = .integer(whole)
    } else if let whole = UInt64(exactly: value) {
      storage = .unsigned(whole)
    } else {
      storage = .floating(bits: value.bitPattern)
    }
  }

  /// The number as a double, rounded when a whole number exceeds 53 bits.
  public var doubleValue: Double {
    switch storage {
    case .integer(let value): Double(value)
    case .unsigned(let value): Double(value)
    case .floating(let bits): Double(bitPattern: bits)
    }
  }

  /// The number as an `Int64`, or nil when it has a fraction or lies outside that range.
  public var int64Value: Int64? {
    if case .integer(let value) = storage { value } else { nil }
  }

  /// The number as an `Int`, or nil when it has a fraction or lies outside that range.
  public var intValue: Int? {
    int64Value.flatMap(Int.init(exactly:))
  }

  /// The number as a `UInt64`, or nil when it has a fraction or is negative.
  public var uint64Value: UInt64? {
    switch storage {
    case .integer(let value): UInt64(exactly: value)
    case .unsigned(let value): value
    case .floating: nil
    }
  }

  /// Whether the number is neither infinite nor NaN.
  public var isFinite: Bool {
    doubleValue.isFinite
  }
}
