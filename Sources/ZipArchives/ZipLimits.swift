/// The sizes beyond which an archive is refused before any of it is expanded.
public struct ZipLimits: Sendable, Hashable {
  /// The greatest number of entries, directories included.
  public var maximumEntryCount: Int
  /// The greatest expanded size of one entry, in bytes.
  public var maximumEntrySize: Int
  /// The greatest expanded size of all entries together, in bytes.
  public var maximumTotalSize: Int
  /// The greatest ratio of expanded to stored size that an entry above `ratioThreshold` may have.
  public var maximumCompressionRatio: Int
  /// The expanded size, in bytes, below which an entry's ratio is not examined.
  public var ratioThreshold: Int

  /// Creates limits; the defaults are those of `standard`.
  public init(
    maximumEntryCount: Int = 16_384, maximumEntrySize: Int = 1 << 31, maximumTotalSize: Int = 1 << 32,
    maximumCompressionRatio: Int = 200, ratioThreshold: Int = 1 << 20
  ) {
    self.maximumEntryCount = maximumEntryCount
    self.maximumEntrySize = maximumEntrySize
    self.maximumTotalSize = maximumTotalSize
    self.maximumCompressionRatio = maximumCompressionRatio
    self.ratioThreshold = ratioThreshold
  }

  /// 16,384 entries, 2 GiB an entry, 4 GiB in all, and a ratio of 200 for an entry above 1 MiB.
  public static let standard = ZipLimits()
}
