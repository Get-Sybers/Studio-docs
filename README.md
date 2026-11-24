# Studio-docs

A Swift package for documents in the package layout and text model that Apple documents for Creator
Studio documents. A Swift app creates, opens, edits, validates and saves such documents, long-form text
above all.

This is an independent implementation. It is not affiliated with, sponsored by or endorsed by Apple Inc.
Keynote and Creator Studio are trademarks of Apple Inc.

## Using the package

The manifest needs the Swift 6.4 tools and sets a deployment target of macOS 27. Add the package by its
URL, depend on its one product, `StudioDocs`, and import the modules you use by name.

```swift
.package(url: "https://github.com/Get-Sybers/Studio-docs", from: "0.1.0")
```

```swift
.product(name: "StudioDocs", package: "Studio-docs")
```

```swift
import DocumentPackage  // StudioDocument, DocumentBody, UntypedBody, WriteOptions
import TextDocument  // TextDocumentBody, TextSection
import TextModel  // TextBody, Paragraph, TextRun, CharacterProperties, Stylesheet
import WireFormat  // ObjectEnvelope, Inheritable, ClientProperty, FormatVersion
```

## An example

Create a document of text, save it as one archive, and open it again. The test `createSaveReopen` in
`Tests/TextDocumentTests` runs this example.

```swift
let styled = Paragraph(contents: [
  .text("Low water at "), .text("six", style: CharacterProperties(italic: true)), .text("."),
])
var body = TextDocumentBody(title: .string("Harbour notes"))
body.sections.append(
  TextSection(
    heading: .string("Monday"), text: .paragraphs([styled, Paragraph("The boats leaned on their keels.")])))
try StudioDocument(body: body).write(to: url)

let reopened = try StudioDocument<TextDocumentBody>(contentsOf: url)
reopened.body == body  // true
reopened.body.plainText  // "Harbour notes\nMonday\nLow water at six.\nThe boats leaned on their keels."
reopened.validate().findings.isEmpty  // true
```

Beyond the example:

- `write(to: url, as: .directory)` saves into a directory with the same entries as the archive, and
  writes only the files whose bytes differ. An editor saves step by step that way.
- `validate()` returns typed findings, each an error or a warning with the part of the package and the
  path it concerns. A document with an error is refused on save, unless `WriteOptions` says otherwise.
- `try AttributedString(body.sections[0].text)` is the text of a section as Foundation's attributed
  string, and `TextBody(attributed)` reads one back. Italic, bold and strikethrough travel as the inline
  presentation intent; underline, the rest of a run's style, links and inline objects travel as the
  library's own attributes; a paragraph-bound attribute carries each paragraph's properties and
  identifier.
- `StudioDocument<UntypedBody>(contentsOf: url)` opens any package, a Keynote presentation included, keeps
  `main.json` as a tree, and writes it back as it was.
- A body of your own conforms to `WireObject` and `DocumentBody`; a member of your own on a type of the
  library is a `ClientProperty`, and every reader and writer of the library keeps it.

## What the library models

A package is `main.json`, `manifest.json`, `presets.json` and the files of `Data`, stored as one ZIP
archive or as a directory. The library models the package, the text model and what the text model
refers to.

| Module | Holds |
| --- | --- |
| `DocumentPackage` | `StudioDocument<Body>`, which opens and saves a package; the manifest; the resources; `UntypedBody` |
| `TextDocument` | the library's own small body: a title, text styles and sections in order |
| `TextModel` | text bodies, paragraphs, runs, links, breaks; character, paragraph, list and layout properties; stylesheets |
| `AttributedText` | paragraphs to Foundation's `AttributedString` and back |
| `Appearance` | colours, fills, gradients, image fills, shadows, strokes and the geometric values they use |
| `ResourceReferences` | indirect and embedded resources, and the marks of a premium resource |
| `PresetStyles` | the presets of `presets.json`, their inheritance, and the resolver of effective properties |
| `DocumentIdentifiers` | an index of every object identifier of a tree, and a mint that makes new ones |
| `DocumentValidation` | typed findings, each an error or a warning, with its part and its path |
| `WireFormat` | type identifiers, versions, the envelope of an object, unions, `Inheritable`, `ClientProperty`, readers and writers |
| `JSONTree` | a JSON value tree through Foundation's coders, whole numbers exact |
| `ZipArchives` | a ZIP reader and writer over the system's zlib, Zip64 included, with limits against hostile archives |

[docs/Modelled-types.md](docs/Modelled-types.md) lists every type of the format that the library models,
generated from the format tables in `Sources/<Target>/Resources/format.json`.
[docs/Architecture.md](docs/Architecture.md) gives the targets and their dependencies.

Slides, canvas objects, tables, charts and themes are not modelled. A document that holds them opens
through `UntypedBody`, which loses nothing: it keeps the tree of `main.json` and writes it back as it
was. Inside a modelled type, every member, union case, enumeration value and package entry that the
library does not model is kept as read and written back.

## Departures from Apple's reader

- Apple's reader drops an object it cannot read. This library keeps what it does not model and writes it
  back, and it writes `type_identifier` on every object it models.
- An object keeps the version it declares. The library raises the version when a member of a later
  version is set, and gives a version to an object that declares none only for a member of a later major
  version; Apple's reference library rewrites every version. A member newer than the version its object
  declares is kept and not read. A later major version of a modelled type, or of the package, is refused
  on open.
- A run inside a paragraph that holds U+000A, U+000D or U+2029 is a validation warning, not an error,
  since a reader of flat text ends the paragraph there. The bridge to `AttributedString` refuses it.
- The identifier of an indirect resource is the name of a file in `Data`, not an object identifier.
- A member name repeated in one JSON object is refused on open, with the place of the object. Apple's reader
  keeps the first value.
- An archive whose entries all sit inside one folder, as zipping a folder makes, opens as the package; it is
  written back with its files at the root.

## Limits

- The library is checked against the documentation pages and the models of Apple's reference library,
  and against no file that Keynote wrote.
- Every entry of a package is read and checked on open.
- In the bridge to `AttributedString`, a run with no text does not survive the round trip: no character
  carries it. Every paragraph ends with a line feed;
  `AttributedTextOptions(terminatesLastParagraph: false)` drops the last one, and then an empty last
  paragraph has no character to carry its properties and identifier.

## Development

`make tidy conform` is the gate; CI runs the same command. [AGENTS.md](AGENTS.md) holds the rules for
every contributor and [docs/Conformance.md](docs/Conformance.md) describes the gate, the structural lint,
the version pins and CI.

Licence: Apache-2.0, in `LICENSE`. `NOTICE` credits Apple's documentation and reference library as the
reference for the format.
