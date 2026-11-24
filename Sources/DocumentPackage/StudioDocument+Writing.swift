import DocumentValidation
public import Foundation
import JSONTree
import PresetStyles

extension StudioDocument {
  /// Saves the package as one archive, replaced whole, or into a directory, where only what differs is written.
  ///
  /// A document with a validation error is refused, and nothing is written, unless the options say otherwise.
  @discardableResult
  public func write(
    to url: URL, as layout: PackageLayout = .archive, options: WriteOptions = WriteOptions()
  ) throws(DocumentError) -> WriteSummary {
    let contents = try contents(options)
    switch layout {
    case .directory:
      return try DirectoryPackage.write(contents, to: url)
    case .archive:
      if PackageContents.kind(of: url) == .directory { throw .destinationOccupied(path: url.path) }
      let archive = try contents.archive()
      do {
        try archive.write(to: url, options: .atomic)
      } catch {
        throw .fileSystem(path: url.path, underlying: error)
      }
      return WriteSummary(written: contents.names, unchanged: [], removed: [])
    }
  }

  /// The package as the bytes of a ZIP archive.
  public func archive(options: WriteOptions = WriteOptions()) throws(DocumentError) -> Data {
    try contents(options).archive()
  }

  private func contents(_ options: WriteOptions) throws(DocumentError) -> PackageContents {
    let tree = body.mainTree
    if options.refusesInvalid {
      let report = validation(of: tree)
      guard report.isSaveable else { throw .invalid(report) }
    }
    var contents = PackageContents()
    for (entry, value) in [
      (PackageContents.main, tree), (PackageContents.manifest, manifest.tree),
      (PackageContents.presets, presets.wireValue),
    ] {
      do throws(JSONTreeError) {
        contents[entry] = try value.text(options.style)
      } catch {
        throw .malformedJSON(entry: entry, error)
      }
    }
    for (name, bytes) in resources {
      contents[PackageContents.data + name] = bytes
    }
    // An entry that the library does not know never displaces one that it writes.
    for entry in unmodelledEntries where contents[entry.name] == nil {
      contents[entry.name] = entry.contents
    }
    return contents
  }
}
