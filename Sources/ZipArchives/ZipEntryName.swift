/// The rule that keeps an entry's name inside the archive's own tree.
enum ZipEntryName {
  /// Tells whether a name is relative, stays below its root, and holds no backslash and no NUL.
  static func isSafe(_ name: String) -> Bool {
    guard !name.isEmpty, !name.hasPrefix("/"), !name.unicodeScalars.contains(where: { $0 == "\\" || $0.value == 0 })
    else { return false }
    var components = name.split(separator: "/", omittingEmptySubsequences: false)
    // A directory entry ends with a slash, which leaves one empty component at the end.
    if components.count > 1, components.last == "" { components.removeLast() }
    return components.allSatisfy { !$0.isEmpty && $0 != "." && $0 != ".." }
  }
}
