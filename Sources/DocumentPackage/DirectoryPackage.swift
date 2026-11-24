import Foundation
import ZipArchives

/// Writes the entries of a package into a directory, touching only the files whose bytes differ.
enum DirectoryPackage {
  static func write(_ contents: PackageContents, to directory: URL) throws(DocumentError) -> WriteSummary {
    let manager = FileManager.default
    if let kind = PackageContents.kind(of: directory) {
      guard kind == .directory else { throw .destinationOccupied(path: directory.path) }
      let existing = (try? manager.contentsOfDirectory(atPath: directory.path)) ?? []
      // A directory that holds other things is nobody's package, and is not written into.
      guard existing.allSatisfy(PackageContents.isDebris) || existing.contains(PackageContents.main) else {
        throw .notAPackageDirectory(path: directory.path)
      }
    }
    var folded: [String: String] = [:]
    for name in contents.names {
      guard ZipEntryName.isSafe(name), !name.hasSuffix("/") else { throw .unsafeEntry(name: name) }
      let key = name.precomposedStringWithCanonicalMapping.lowercased()
      if let earlier = folded[key] { throw .resourceNamesCollide(earlier, name) }
      folded[key] = name
    }

    var summary = WriteSummary(written: [], unchanged: [], removed: [])
    // The body goes last, so that it never names a resource that is not yet there.
    let ordered = contents.names.filter { $0 != PackageContents.main } + [PackageContents.main]
    for name in ordered {
      guard let bytes = contents[name] else { continue }
      let file = directory.appendingPathComponent(name)
      if let present = try? Data(contentsOf: file, options: .mappedIfSafe), present == bytes {
        summary.unchanged.append(name)
        continue
      }
      do {
        try manager.createDirectory(at: file.deletingLastPathComponent(), withIntermediateDirectories: true)
        try bytes.write(to: file, options: .atomic)
      } catch {
        throw .fileSystem(path: file.path, underlying: error)
      }
      summary.written.append(name)
    }

    let data = directory.appendingPathComponent("Data")
    for name in ((try? manager.contentsOfDirectory(atPath: data.path)) ?? []).sorted() {
      let key = (PackageContents.data + name).precomposedStringWithCanonicalMapping.lowercased()
      let file = data.appendingPathComponent(name)
      guard folded[key] == nil, !name.hasPrefix("."), PackageContents.kind(of: file) == .file else { continue }
      do {
        try manager.removeItem(at: file)
      } catch {
        throw .fileSystem(path: file.path, underlying: error)
      }
      summary.removed.append(PackageContents.data + name)
    }
    return summary
  }
}
