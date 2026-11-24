/// One file of an archive, as its central directory describes it.
package struct ZipEntry: Sendable, Hashable {
  /// The name, with `/` between its components.
  package let name: String
  /// How the bytes are stored.
  package let compression: ZipCompression
  /// The CRC-32 of the expanded bytes.
  package let checksum: UInt32
  /// The size as stored, in bytes.
  package let storedSize: Int
  /// The size once expanded, in bytes.
  package let size: Int
  /// Where the stored bytes lie in the archive.
  let storedRange: Range<Int>
}
