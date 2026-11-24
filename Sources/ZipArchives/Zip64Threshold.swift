/// The sizes from which the writer uses Zip64 records: the format's own limits, or lower ones for a test.
package struct Zip64Threshold: Sendable, Hashable {
  /// A size or an offset, in bytes, from which the 32-bit field is saturated and the wide one is written.
  package var size: Int
  /// A number of entries from which the 16-bit field is saturated and the wide one is written.
  package var count: Int

  /// Creates thresholds.
  package init(size: Int, count: Int) {
    self.size = size
    self.count = count
  }

  /// The limits of the format: 4 GiB less one byte and 65,535 entries.
  package static let standard = Zip64Threshold(size: 0xFFFF_FFFF, count: 0xFFFF)
}
