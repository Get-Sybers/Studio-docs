/// A version in major.minor form: that of a type, or that of the package.
///
/// A reader has to implement the major version of a value to read it; it may be older than the minor.
public struct FormatVersion: Sendable, Hashable, Comparable, CustomStringConvertible {
  /// The major version.
  public let major: Int
  /// The minor version.
  public let minor: Int

  /// Creates a version from its two parts.
  public init(_ major: Int, _ minor: Int) {
    self.major = major
    self.minor = minor
  }

  /// Reads `major.minor`, or `major` alone, in decimal digits; any other text is no version.
  public init?(_ text: String) {
    let parts = text.split(separator: ".", omittingEmptySubsequences: false)
    guard parts.count == 1 || parts.count == 2,
      parts.allSatisfy({ !$0.isEmpty && $0.utf8.allSatisfy { (0x30...0x39).contains($0) } }),
      let major = Int(parts[0]), let minor = parts.count == 2 ? Int(parts[1]) : 0
    else { return nil }
    self.init(major, minor)
  }

  /// Version 1.0, which every type of the format starts at.
  public static let initial = FormatVersion(1, 0)

  /// The text `major.minor`.
  public var description: String { "\(major).\(minor)" }

  /// Orders by the major version, then by the minor.
  public static func < (left: FormatVersion, right: FormatVersion) -> Bool {
    (left.major, left.minor) < (right.major, right.minor)
  }
}
