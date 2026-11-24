public import PresetStyles

/// A document in memory: its body, its presets, its manifest and its resources.
///
/// `Body` is the root of `main.json`: a type of the client's own, the library's text document, or `UntypedBody`.
public struct StudioDocument<Body: DocumentBody>: Sendable {
  /// The content, written to `main.json`.
  public var body: Body
  /// The presets, written to `presets.json`.
  public var presets: PresetLibrary
  /// The files of `Data`.
  public var resources: ResourceStore
  /// The manifest, written to `manifest.json`.
  public var manifest: Manifest
  /// The other files of the package, kept as they were read and written back.
  public var unmodelledEntries: [PackageEntry]

  /// Creates a document; with a body alone it has no presets and no resources, and declares the current version.
  public init(
    body: Body, presets: PresetLibrary = PresetLibrary(), resources: ResourceStore = ResourceStore(),
    manifest: Manifest = Manifest()
  ) {
    self.body = body
    self.presets = presets
    self.resources = resources
    self.manifest = manifest
    self.unmodelledEntries = []
  }
}
