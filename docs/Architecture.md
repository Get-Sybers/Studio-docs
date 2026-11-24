# Architecture

The package has one product, `StudioDocs`, whose modules a consumer imports by name. Each target holds one
concern and is named for it. A target that models types of the format embeds the facts of those types,
their identifiers, versions, members, defaults and limits, from `Sources/<Target>/Resources/format.json`.

## Targets

| Target | Concern | Depends on | In the product |
| --- | --- | --- | --- |
| `RawDeflate` | raw DEFLATE streams over the system's zlib; the one target with C, a system library and unsafe pointers | zlib | no |
| `ZipArchives` | a ZIP reader and writer, with limits against hostile archives | `RawDeflate`, OrderedCollections | yes |
| `JSONTree` | a JSON value tree through Foundation's coders, whole numbers exact, members in file order | OrderedCollections | yes |
| `WireFormat` | type identifiers, versions, the envelope, unions, `Inheritable`, `ClientProperty`, readers, writers, format tables and schema registries | `JSONTree`, BitCollections | yes |
| `PresetStyles` | the presets of `presets.json`, their inheritance, and the resolver of effective properties | `JSONTree`, `WireFormat`, OrderedCollections | yes |
| `DocumentIdentifiers` | an index of object identifiers and a mint | `JSONTree`, `WireFormat`, HashTreeCollections | yes |
| `ResourceReferences` | the resource union, indirect and embedded resources, premium marks; a format table | `JSONTree`, `WireFormat` | yes |
| `Appearance` | colours, fills, gradients, image fills, shadows, strokes, geometric values; a format table | `JSONTree`, `ResourceReferences`, `WireFormat` | yes |
| `TextModel` | text bodies, paragraphs, runs, links, breaks, properties, stylesheets; a format table | `Appearance`, `JSONTree`, `PresetStyles`, `ResourceReferences`, `WireFormat` | yes |
| `DocumentValidation` | typed findings and the checks that make them | `Appearance`, `DocumentIdentifiers`, `JSONTree`, `PresetStyles`, `ResourceReferences`, `TextModel`, `WireFormat` | yes |
| `DocumentPackage` | `StudioDocument<Body>`, the manifest, the resources, the two layouts of a package, `UntypedBody` | `DocumentValidation`, `JSONTree`, `PresetStyles`, `ResourceReferences`, `TextModel`, `WireFormat`, `ZipArchives`, OrderedCollections | yes |
| `TextDocument` | the library's own small body, under its own type identifiers; a format table | `Appearance`, `DocumentPackage`, `TextModel`, `WireFormat` | yes |
| `PageSizes` | the trim sizes of the book trade, read from `Resources/page-sizes.json` | `Appearance` | yes |
| `CanvasCommon` | what canvas objects share: geometry, labels, reflections, durations, the owning of titles and captions; a format table | `Appearance`, `JSONTree`, `TextModel`, `WireFormat` | yes |
| `TableModel` | tables: cells, rows, columns, formats, formulas, conditional styles, filters, sorts, visual properties; a format table | `Appearance`, `CanvasCommon`, `JSONTree`, `TextModel`, `WireFormat` | yes |
| `ChartModel` | every kind of chart, with axes, series, data, legends and label formatting; a format table | `Appearance`, `CanvasCommon`, `JSONTree`, `TableModel`, `TextModel`, `WireFormat` | yes |
| `CanvasModel` | the objects of a canvas and their union `CanvasObject`; a format table | `Appearance`, `CanvasCommon`, `ChartModel`, `JSONTree`, `ResourceReferences`, `TableModel`, `TextModel`, `WireFormat` | yes |
| `PresentationModel` | the presentation, its slides, layouts and theme, the stylesheet's shape, media and table styles, and `Presentation` as a document body; a format table | `Appearance`, `CanvasCommon`, `CanvasModel`, `DocumentPackage`, `JSONTree`, `TableModel`, `TextModel`, `WireFormat` | yes |
| `AttributedText` | paragraphs to Foundation's `AttributedString` and back | `TextModel`, `WireFormat` | yes |
| `GoldenFiles` | the expected outputs of a test target, one file for each | none | no |
| `ModelFixtures` | the fixtures of a test target, and the checks that a type and its table agree | `JSONTree`, `WireFormat` | no |

OrderedCollections, BitCollections and HashTreeCollections are products of
[Swift Collections](https://github.com/apple/swift-collections), the one package dependency. No public
signature names a type of theirs.

## Layers

From the bytes up:

1. **Bytes.** `RawDeflate` and `ZipArchives` turn an archive into named entries and back; `JSONTree` turns
   the bytes of an entry into a tree and back.
2. **Wire.** `WireFormat` reads an object of the format from a tree and writes it back: it checks the type
   identifier and the version, hands each modelled member to the type, and keeps every other member in
   the envelope.
3. **Types of the format.** `ResourceReferences`, `Appearance` and `TextModel` are the modelled types of
   resources, appearance and text, each a `WireObject`, a `WireUnion` or a `WireEnumeration`. `PresetStyles`
   resolves what an object inherits; `DocumentIdentifiers` indexes and mints identifiers.
4. **The document.** `DocumentValidation` checks a tree against the format and its own rules;
   `DocumentPackage` opens and saves a `StudioDocument` whose body is a type the client chooses.
5. **The canvas and the presentation.** `CanvasCommon`, `TableModel`, `ChartModel` and `CanvasModel` model
   what stands on a slide, bottom up; `PresentationModel` models the presentation itself and makes
   `Presentation` a document body.
6. **For clients.** `TextDocument` is a body for documents of text; `AttributedText` bridges paragraphs to
   Foundation's attributed strings.
7. **For the tests.** `GoldenFiles` and `ModelFixtures`, which no consumer imports.

## How a document is read and written

Opening a package reads every entry into memory, through `ZipArchives` for an archive or the file system
for a directory, then parses `manifest.json`, `presets.json` and `main.json` with `JSONTree`. A later
major version of the package is refused. The body reads itself from the tree of `main.json` through the
readers of `WireFormat`; the files of `Data` become the resources; every other entry is kept as it was.

Saving validates the tree of `main.json` first and refuses a document with an error. Then it writes the
three JSON files, the resources and the kept entries: as one archive, replaced whole, or into a directory,
where only a file whose bytes differ is written and a file that is gone is removed.

## Format tables

Nine targets embed a table: `ResourceReferences`, `Appearance`, `TextModel`, `TextDocument`, `CanvasCommon`,
`TableModel`, `ChartModel`, `CanvasModel` and `PresentationModel`. A table
lists each object and union with its type identifier, its version, and its members or cases with the
version that introduced each; and each enumeration with its values. The types read their schemas from the
table at start, `scripts/generate-modelled-types.swift` writes `docs/Modelled-types.md` from the tables,
and the tests of each target check that the table and the types agree.

## Build settings

Every target builds in Swift 6 language mode with the upcoming features `ExistentialAny`,
`InternalImportsByDefault`, `MemberImportVisibility` and `NonisolatedNonsendingByDefault`, with strict
memory safety, and with every warning an error. With `MemberImportVisibility`, a file imports every module
whose members it uses.
