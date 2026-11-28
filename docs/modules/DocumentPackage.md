# DocumentPackage

`StudioDocument<Body>`, the manifest, the resources, the two layouts of a package, and `UntypedBody`.

## What it provides

Opens and saves a package. `StudioDocument<Body>` is a document whose body is a type the consumer chooses;
opening it reads `main.json`, `manifest.json`, `presets.json` and the files of `Data`, and saving writes
them back as one ZIP archive or as a directory, where only a file whose bytes differ is written. A save
validates the tree first and refuses a document with an error unless the write options say otherwise.
`UntypedBody` keeps the tree of `main.json` for any package and writes it back as it was, so a consumer
opens a document whose root is a type the library does not model.

## Principal API

- `StudioDocument` — a package with a typed body, opened and saved.
- `DocumentBody` — the protocol a body conforms to.
- `UntypedBody` — the tree of `main.json` kept whole.
- `Manifest`, `PackageEntry` — the manifest and an entry of the package.
- `ResourceStore` — the files of `Data` as resources.
- `PackageLayout` — an archive or a directory.
- `WriteOptions`, `WriteSummary` — how a save runs and what it did.
- `DocumentError` — a malformed or refused package.

## Resources

None.

## Depends on

`DocumentValidation`, `JSONTree`, `PresetStyles`, `ResourceReferences`, `TextModel`, `WireFormat`,
`ZipArchives`, OrderedCollections. A product module of `StudioDocs`.
