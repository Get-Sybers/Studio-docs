public import Foundation
import JSONTree
import PresetStyles
import WireFormat
public import ZipArchives

extension StudioDocument {
  /// Opens a package: a ZIP archive, or a directory with the same entries.
  ///
  /// The limits bound what is read in either form; an archive is refused whole before any of it is expanded.
  public init(contentsOf url: URL, limits: ZipLimits = .standard) throws(DocumentError) {
    switch PackageContents.kind(of: url) {
    case .directory:
      try self.init(contents: try PackageContents(directory: url, limits: limits))
      return
    case .file:
      break
    case .other, nil:
      throw .notAPackage(path: url.path)
    }
    let bytes: Data
    do {
      bytes = try Data(contentsOf: url, options: .mappedIfSafe)
    } catch {
      throw .fileSystem(path: url.path, underlying: error)
    }
    try self.init(archive: bytes, limits: limits)
  }

  /// Opens a package from the bytes of a ZIP archive.
  public init(archive: Data, limits: ZipLimits = .standard) throws(DocumentError) {
    try self.init(contents: try PackageContents(archive: archive, limits: limits))
  }

  init(contents: PackageContents) throws(DocumentError) {
    guard let main = contents[PackageContents.main] else { throw .missingMain }
    let manifest = Manifest(reading: contents[PackageContents.manifest])
    guard manifest.isSupported else { throw .unsupportedPackageVersion(manifest.effectiveVersion) }

    var presets = PresetLibrary()
    if let bytes = contents[PackageContents.presets] {
      let tree = try Self.tree(of: bytes, entry: PackageContents.presets)
      do throws(PresetError) {
        presets = try PresetLibrary(wire: tree)
      } catch {
        throw .malformedPresets(error)
      }
    }
    let tree = try Self.tree(of: main, entry: PackageContents.main)
    let body: Body
    do throws(WireError) {
      body = try Body(mainTree: tree)
    } catch {
      throw .unreadableBody(error)
    }

    self.init(body: body, presets: presets, manifest: manifest)
    for name in contents.names {
      guard let bytes = contents[name] else { continue }
      if let resource = PackageContents.resourceName(of: name) {
        resources[resource] = bytes
      } else if ![PackageContents.main, PackageContents.manifest, PackageContents.presets].contains(name) {
        unmodelledEntries.append(PackageEntry(name: name, contents: bytes))
      }
    }
  }

  private static func tree(of bytes: Data, entry: String) throws(DocumentError) -> JSONValue {
    do throws(JSONTreeError) {
      return try JSONValue(parsing: bytes)
    } catch {
      throw .malformedJSON(entry: entry, error)
    }
  }
}
