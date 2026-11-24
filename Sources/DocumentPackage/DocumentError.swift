public import DocumentValidation
public import JSONTree
public import PresetStyles
public import WireFormat
public import ZipArchives

/// A reason a document was not opened or not saved.
public enum DocumentError: Error, Sendable {
  /// The path is neither a file nor a directory.
  case notAPackage(path: String)
  /// The file system refused; the value is its own error.
  case fileSystem(path: String, underlying: any Error)
  /// The archive is not read or not written.
  case archive(ZipError)
  /// A directory holds an entry that is refused: a link, a special file, or more than the limits allow.
  case unsafeEntry(name: String)
  /// The package has no `main.json`.
  case missingMain
  /// One of the JSON files is not JSON text, or holds what JSON text cannot spell.
  case malformedJSON(entry: String, JSONTreeError)
  /// `presets.json` is not a list of presets.
  case malformedPresets(PresetError)
  /// `main.json` does not read as the body of the document.
  case unreadableBody(WireError)
  /// The manifest declares a later major version of the package format than the library reads.
  case unsupportedPackageVersion(FormatVersion)
  /// The document has validation errors, and is not written.
  case invalid(ValidationReport)
  /// The destination of an archive is a directory, or that of a directory package is a file.
  case destinationOccupied(path: String)
  /// The destination directory holds files and no `main.json`, so it is no package to write into.
  case notAPackageDirectory(path: String)
  /// Two resources have names that the destination's file system holds as one.
  case resourceNamesCollide(String, String)
}
