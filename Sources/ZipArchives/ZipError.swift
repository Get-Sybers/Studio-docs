/// A reason an archive was not read or not written.
public enum ZipError: Error, Sendable, Hashable {
  /// The bytes hold no end-of-central-directory record at their end.
  case notAnArchive
  /// The bytes begin as an archive and stop before its directory.
  case truncated
  /// A record of the archive contradicts another or lies outside the file.
  case malformed(Defect)
  /// The archive uses a feature of the format that this reader or writer leaves out.
  case unsupported(Feature)
  /// The archive is well formed and is refused as hostile.
  case hostile(Refusal)
  /// The stored bytes of one entry do not expand to what its directory record declares.
  case entryCorrupt(name: String, EntryDefect)

  /// A structural defect.
  public enum Defect: Sendable, Hashable {
    /// The central directory does not end where the end record begins.
    case directoryMisplaced
    /// Bytes follow the end record and its comment.
    case bytesAfterEndRecord
    /// The bytes at this offset are not the record that belongs there.
    case signatureMissing(offset: Int)
    /// A record names a range of bytes outside the file or outside its own section.
    case recordOutOfBounds
    /// The Zip64 records do not point at one another.
    case zip64Misplaced
    /// The name of the entry at this index is not UTF-8.
    case nameNotUTF8(index: Int)
    /// The header before an entry's bytes disagrees with its directory record.
    case localHeaderMismatch(name: String)
    /// An entry stored without compression declares two different sizes.
    case storedSizeMismatch(name: String)
    /// A directory entry declares contents.
    case directoryWithContents(name: String)
  }

  /// A feature that is left out.
  public enum Feature: Sendable, Hashable {
    /// The entry is encrypted.
    case encryption(name: String)
    /// The entry uses a compression method other than stored and deflated.
    case compressionMethod(name: String, method: Int)
    /// The archive spans more than one disk.
    case multipleDisks
  }

  /// A ground for refusal.
  public enum Refusal: Sendable, Hashable {
    /// The name is empty, absolute, or leaves its directory, or holds a backslash or a NUL.
    case unsafeEntryName(String)
    /// Two entries have the same name.
    case duplicateEntry(String)
    /// The archive holds more entries than the limit allows; the value is its count.
    case tooManyEntries(Int)
    /// One entry expands beyond the limit.
    case entryTooLarge(name: String, size: Int)
    /// The entries together expand beyond the limit; the value is the size reached.
    case archiveTooLarge(size: Int)
    /// An entry expands to more times its stored size than the limit allows.
    case compressionRatio(name: String, ratio: Int)
    /// Two entries claim the same stored bytes.
    case overlappingEntries(String, String)
  }

  /// A defect in the stored bytes of an entry.
  public enum EntryDefect: Sendable, Hashable {
    /// The expanded bytes do not have the recorded CRC-32.
    case checksumMismatch
    /// The bytes are not a DEFLATE stream.
    case notDeflate
    /// The stream ends before its last block.
    case truncated
    /// The stream expands to a size other than the recorded one.
    case sizeMismatch
    /// Bytes follow the end of the stream.
    case trailingBytes
  }
}
