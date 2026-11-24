import Foundation

/// A directory of the test's own under the system's temporary directory, removed when the test ends.
final class Scratch {
  let url: URL

  init() throws {
    url = FileManager.default.temporaryDirectory.appendingPathComponent("studio-docs-\(UUID().uuidString)")
    try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
  }

  deinit {
    try? FileManager.default.removeItem(at: url)
  }

  func file(_ name: String) -> URL {
    url.appendingPathComponent(name)
  }

  /// The files below a directory, by relative name, in order.
  func listing(of directory: URL) throws -> [String] {
    let base = directory.resolvingSymlinksInPath().path + "/"
    let found = FileManager.default.enumerator(at: directory, includingPropertiesForKeys: [.isRegularFileKey])
    var names: [String] = []
    while let item = found?.nextObject() as? URL {
      if try item.resourceValues(forKeys: [.isRegularFileKey]).isRegularFile == true {
        names.append(String(item.resolvingSymlinksInPath().path.dropFirst(base.count)))
      }
    }
    return names.sorted()
  }
}
