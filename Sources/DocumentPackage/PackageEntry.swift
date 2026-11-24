public import Foundation

/// A file of a package that is none of the three JSON files and no resource, kept as it was read.
public struct PackageEntry: Sendable, Hashable {
  /// The name within the package, with `/` between its components.
  public var name: String
  /// The bytes.
  public var contents: Data

  /// Creates an entry.
  public init(name: String, contents: Data) {
    self.name = name
    self.contents = contents
  }
}
