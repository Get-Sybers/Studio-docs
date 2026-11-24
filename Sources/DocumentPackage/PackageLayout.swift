/// The two forms in which a package is stored.
public enum PackageLayout: Sendable, Hashable {
  /// One ZIP archive, the form that documents are exchanged in.
  case archive
  /// A directory with the same entries as files, the form that an editor saves into step by step.
  case directory
}
