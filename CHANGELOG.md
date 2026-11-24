# Changelog

All notable changes to this package are recorded in this file. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and the package follows
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- The target `PageSizes`: the trim sizes of the book trade today, American, British, ISO and Japanese, each as the
  trade quotes it and in points, read from the `page-sizes.json` the target embeds.
- `TextDocumentBody.pageSize`, the size of a page in points, a member of version 1.1 of the library's own type.

## [0.1.1] - 2026-11-24

### Added

- The targets `CanvasCommon`, `TableModel`, `ChartModel`, `CanvasModel` and `PresentationModel`: every type that
  Apple documents, 171 of them, from the presentation and its slides to the cells of a table and the series of a
  chart, each with its format table, fixtures and goldens. `Presentation` is a document body, so a Keynote
  presentation opens typed through `StudioDocument<Presentation>`.
- `Indirect`, a box that keeps a value out of line where a type of the format holds one of its own type.
- The rules of a presentation beyond its schemas, as findings of `Presentation`: a slide's layout stands in the
  theme, placeholders of one slide differ in kind, a connection line has its end points and is anchored beside
  itself, a table's rows, columns, formats and style sets are named once and its indices rise within it, a cell
  and a merge name what the table holds, and a two-axis series selects the first or the second axis. Identifiers
  are checked for repeats in every document; an object a slide takes from its layout may repeat the layout's.
- The ZIP writer writes Zip64 records where a size, an offset or a count needs them; the reader read them already.
- `JSONValue(parsing:)` refuses an object that holds one member name twice, naming the member and the place of
  the object, where Foundation's decoder kept the first value in silence.
- A package whose entries all sit inside one folder, as zipping a folder makes, opens.
- The attribute `RunIndexAttribute`, through which adjacent runs of one style survive the bridge to
  `AttributedString` as two runs.
- The workflow `Release`: run by hand on `main`, it publishes the newest version that `CHANGELOG.md` names as a
  tag and a GitHub release, after the gate, in the environment `release` that the owner approves.
- The pull request template, Dependabot for the Swift packages, and in `docs/Conformance.md` the rules of the
  repository on GitHub: the ruleset `protect-main` and the environment `release`.

### Changed

- `ZipWriter.finish()` no longer throws, and `ZipError.Feature.zip64Writing` is gone.

## [0.1.0] - 2026-11-24

### Added

- The targets `RawDeflate` and `ZipArchives`: a reader and a writer of ZIP archives over the system's
  zlib. The reader refuses names that leave the archive, repeated names, entries that share bytes, and
  sizes and ratios beyond its limits.
- The target `JSONTree`: a JSON value tree that reads and writes through Foundation's coders, keeps
  whole numbers exact, and treats the order of an object's members as without meaning.
- The target `WireFormat`: type identifiers, versions, the envelope of an object, tagged unions, the
  three states of an inheritable member, and readers and writers that keep every member a type does
  not model. A client adds members of its own to a type of the library with `ClientProperty`.
- The target `ModelFixtures`, which the tests share: the fixtures of a test target, and the checks that a
  type reads and writes every member that its format table lists.
- The target `ResourceReferences`: the resource union, the indirect and the embedded resource, and the
  marks of a premium resource, with the format table that states their members.
- The target `Appearance`: colours, fills, gradients, image fills, shadows, strokes and the small
  geometric values they use.
- The target `TextModel`: text bodies, paragraphs, runs, links, breaks, character, paragraph, list and
  layout properties, and the text styles of a stylesheet. A plain string and a list of runs split into
  paragraphs at U+000A, U+000D and U+2029.
- The target `PresetStyles`: the presets of `presets.json`, their inheritance, and a resolver that
  returns the effective properties of an object: its own, its preset's, the parents', then the declared
  default. A `null` stops the search. `TextModel` adds the layering of a run over its paragraph and the
  text styles of a stylesheet.
- The target `DocumentIdentifiers`: an index of every object identifier of a tree with the places that
  carry it, and a mint that makes identifiers no object carries. Reading and writing keep an identifier
  as it is; only a call to the mint makes one.
- The target `DocumentValidation`: typed findings, each an error or a warning with its part and its place.
  It checks the presets, the names in `Data`, every object that names a modelled type against its schema
  and its own rules, the identifiers, and what links and presets refer to.
- The target `DocumentPackage`: `StudioDocument`, generic over the body a client defines, with its presets,
  manifest and resources. It opens and saves a package as one ZIP archive or as a directory, where a save
  writes only the files whose bytes differ. It keeps every entry and member it does not know, refuses a
  later major version of the package, and refuses to write a document that has validation errors.
  `UntypedBody` opens a Keynote presentation and writes it back as it was.
- The target `TextDocument`: a small body of the library's own, a title, text styles and sections in order.
- The target `AttributedText`: a bridge between paragraphs and Foundation's `AttributedString`, both ways.
  Italic, bold and strikethrough travel as the inline presentation intent, underline and everything else as
  attributes of the library's own, and a paragraph-bound attribute carries each paragraph's properties and
  identifier. A run that holds a paragraph separator is refused.
- The target `GoldenFiles`, which the tests share: one file of expected outputs for each test target.
- The gate `make tidy conform`, the structural lint `scripts/structure-lint.sh`, and the workflow
  `Swift CI`.
- `README.md` in full: the dependency line and the imports, the example of a document created, saved and
  opened again, what the library models and what it does not, the departures from Apple's reader and the
  limits.
- `docs/Architecture.md`: the targets, their concerns, their dependencies and the layers. The table of where
  things live in `AGENTS.md` names every document of the repository.

### Changed

- The forms of a union and the values of `Inheritable` are kept out of line. A paragraph is 936 bytes where
  it was 5,280, which a deep call on a secondary thread could not hold on its stack.
- The example of the README and the test `createSaveReopen` are one: a section of two paragraphs, one of
  them styled, saved as an archive and opened again.

[Unreleased]: https://github.com/Get-Sybers/Studio-docs/compare/0.1.1...HEAD
[0.1.1]: https://github.com/Get-Sybers/Studio-docs/compare/0.1.0...0.1.1
[0.1.0]: https://github.com/Get-Sybers/Studio-docs/releases/tag/0.1.0
