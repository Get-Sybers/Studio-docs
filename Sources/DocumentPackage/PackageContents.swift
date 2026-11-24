import Foundation
import OrderedCollections
import ZipArchives

/// The entries of a package, by name, however it is stored.
struct PackageContents {
  static let main = "main.json"
  static let manifest = "manifest.json"
  static let presets = "presets.json"
  static let data = "Data/"

  private var entries: OrderedDictionary<String, Data> = [:]

  /// The names of the entries, in order.
  var names: [String] { Array(entries.keys) }

  /// The bytes of an entry; assigning adds it after the others or replaces it in place.
  subscript(name: String) -> Data? {
    get { entries[name] }
    set { entries[name] = newValue }
  }

  /// What kind of thing a path names, if it names anything; a link is neither a file nor a directory.
  enum Kind {
    case file, directory, other
  }

  static func kind(of url: URL) -> Kind? {
    let keys: Set<URLResourceKey> = [.isRegularFileKey, .isDirectoryKey, .isSymbolicLinkKey]
    guard let values = try? url.resourceValues(forKeys: keys) else { return nil }
    if values.isSymbolicLink == true { return .other }
    if values.isDirectory == true { return .directory }
    return values.isRegularFile == true ? .file : .other
  }

  /// What a tool of the operating system leaves beside the entries of a package.
  static func isDebris(_ name: String) -> Bool {
    name.hasPrefix("__MACOSX/") || name == ".DS_Store" || name.hasSuffix("/.DS_Store")
  }

  /// The name of a resource, when an entry lies directly inside `Data`.
  static func resourceName(of entry: String) -> String? {
    guard entry.hasPrefix(data) else { return nil }
    let name = entry.dropFirst(data.count)
    return name.isEmpty || name.contains("/") ? nil : String(name)
  }

  init() {}

  init(archive: Data, limits: ZipLimits) throws(DocumentError) {
    do throws(ZipError) {
      let reader = try ZipReader(archive, limits: limits)
      for entry in reader.entries where !Self.isDebris(entry.name) {
        entries[entry.name] = try reader.contents(of: entry)
      }
    } catch {
      throw .archive(error)
    }
  }

  init(directory: URL, limits: ZipLimits) throws(DocumentError) {
    var total = 0
    try read(directory, prefix: "", limits: limits, total: &total)
  }

  private mutating func read(
    _ directory: URL, prefix: String, limits: ZipLimits, total: inout Int
  ) throws(DocumentError) {
    let keys: Set<URLResourceKey> = [.isRegularFileKey, .isDirectoryKey, .isSymbolicLinkKey, .fileSizeKey]
    let children: [URL]
    do {
      children = try FileManager.default.contentsOfDirectory(
        at: directory, includingPropertiesForKeys: Array(keys), options: [])
    } catch {
      throw .fileSystem(path: directory.path, underlying: error)
    }
    for child in children.sorted(by: { $0.lastPathComponent < $1.lastPathComponent }) {
      let name = prefix + child.lastPathComponent
      guard !Self.isDebris(name), name != "__MACOSX" else { continue }
      let values: URLResourceValues
      do {
        values = try child.resourceValues(forKeys: keys)
      } catch {
        throw .fileSystem(path: child.path, underlying: error)
      }
      // A link could lead out of the package, so it is refused, as is anything that is no file.
      guard values.isSymbolicLink != true else { throw .unsafeEntry(name: name) }
      if values.isDirectory == true {
        try read(child, prefix: name + "/", limits: limits, total: &total)
        continue
      }
      guard values.isRegularFile == true else { throw .unsafeEntry(name: name) }
      let size = values.fileSize ?? 0
      total += size
      guard entries.count < limits.maximumEntryCount else {
        throw .archive(.hostile(.tooManyEntries(entries.count + 1)))
      }
      guard size <= limits.maximumEntrySize else { throw .archive(.hostile(.entryTooLarge(name: name, size: size))) }
      guard total <= limits.maximumTotalSize else { throw .archive(.hostile(.archiveTooLarge(size: total))) }
      do {
        entries[name] = try Data(contentsOf: child, options: .mappedIfSafe)
      } catch {
        throw .fileSystem(path: child.path, underlying: error)
      }
    }
  }

  func archive() throws(DocumentError) -> Data {
    do throws(ZipError) {
      var writer = ZipWriter()
      for (name, bytes) in entries {
        try writer.add(bytes, named: name)
      }
      return try writer.finish()
    } catch {
      throw .archive(error)
    }
  }
}
