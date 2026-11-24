/// What writing a package did to its entries.
public struct WriteSummary: Sendable, Hashable {
  /// The entries that were written, in order.
  public var written: [String]
  /// The entries that the destination already held with the same bytes; a directory is left untouched there.
  public var unchanged: [String]
  /// The files of `Data` that the document no longer holds and that were removed from a directory.
  public var removed: [String]
}
