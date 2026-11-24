public import Appearance

/// One trim size of a book, as the trade quotes it, with its size in points for a document.
public struct PageSize: Sendable, Hashable, Decodable {
  /// The name the trade uses.
  public let name: String
  /// The trade the size belongs to.
  public let system: PageSizeSystem
  /// The width, in `unit`.
  public let width: Double
  /// The height, in `unit`.
  public let height: Double
  /// The unit the width and the height are quoted in.
  public let unit: LengthUnit

  /// Creates a size.
  public init(name: String, system: PageSizeSystem, width: Double, height: Double, unit: LengthUnit) {
    self.name = name
    self.system = system
    self.width = width
    self.height = height
    self.unit = unit
  }

  /// The size in points, as a document holds it.
  public var size: SizeValue {
    SizeValue(width: unit.points(width), height: unit.points(height))
  }
}
