/// A unit that a trim size is quoted in; a page size in the format is in points, 72 to the inch.
public enum LengthUnit: String, Sendable, Hashable, Decodable {
  /// An inch, 72 points.
  case inch
  /// A millimetre, 72 points to 25.4 of them.
  case millimetre = "mm"

  /// Converts a length in this unit to points.
  public func points(_ length: Double) -> Double {
    switch self {
    case .inch: length * 72
    case .millimetre: length * 72 / 25.4
    }
  }
}
