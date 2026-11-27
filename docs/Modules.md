# Modules

Studio-docs is one product, `StudioDocs`, built from the targets below; a consumer imports each module by
name. Each target holds one concern and takes its name. This index gives the concern of each module and
links to its spec; [Architecture.md](Architecture.md) gives the dependencies and the layers, and
[Modelled-types.md](Modelled-types.md) lists every type of the format that the library models.

## In the product

The modules below are the targets of the `StudioDocs` library, from the bytes up.

| Module | Concern | Spec |
| --- | --- | --- |
| `ZipArchives` | a ZIP reader and writer, with limits against hostile archives | [spec](modules/ZipArchives.md) |
| `JSONTree` | a JSON value tree through Foundation's coders, whole numbers exact, members in file order | [spec](modules/JSONTree.md) |
| `WireFormat` | type identifiers, versions, the envelope, unions, `Inheritable`, `ClientProperty`, readers and writers | [spec](modules/WireFormat.md) |
| `PresetStyles` | the presets of `presets.json`, their inheritance, and the resolver of effective properties | [spec](modules/PresetStyles.md) |
| `DocumentIdentifiers` | an index of object identifiers and a mint | [spec](modules/DocumentIdentifiers.md) |
| `ResourceReferences` | the resource union, indirect and embedded resources, premium marks | [spec](modules/ResourceReferences.md) |
| `Appearance` | colours, fills, gradients, image fills, shadows, strokes and geometric values | [spec](modules/Appearance.md) |
| `TextModel` | text bodies, paragraphs, runs, links, breaks, properties and stylesheets | [spec](modules/TextModel.md) |
| `DocumentValidation` | typed findings and the checks that make them | [spec](modules/DocumentValidation.md) |
| `DocumentPackage` | `StudioDocument<Body>`, the manifest, the resources, the two layouts, `UntypedBody` | [spec](modules/DocumentPackage.md) |
| `TextDocument` | the library's own small body of text, under its own type identifiers | [spec](modules/TextDocument.md) |
| `PageSizes` | the trim sizes of the book trade, in points | [spec](modules/PageSizes.md) |
| `CanvasCommon` | what canvas objects share: geometry, labels, reflections, durations, titles and captions | [spec](modules/CanvasCommon.md) |
| `TableModel` | tables: cells, rows, columns, formats, formulas, conditional styles, filters and sorts | [spec](modules/TableModel.md) |
| `ChartModel` | every kind of chart, with axes, series, data, legends and label formatting | [spec](modules/ChartModel.md) |
| `CanvasModel` | the objects of a canvas and their union `CanvasObject` | [spec](modules/CanvasModel.md) |
| `PresentationModel` | the presentation, its slides, layouts and theme, and `Presentation` as a document body | [spec](modules/PresentationModel.md) |
| `AttributedText` | paragraphs to Foundation's `AttributedString` and back | [spec](modules/AttributedText.md) |

## Not in the product

`RawDeflate` is an internal module, and `GoldenFiles` and `ModelFixtures` support the tests. No consumer
imports them.

| Module | Concern | Spec |
| --- | --- | --- |
| `RawDeflate` | raw DEFLATE streams over the system's zlib; the one target with C, a system library and unsafe pointers | [spec](modules/RawDeflate.md) |
| `GoldenFiles` | the expected outputs of a test target, one file for each | [spec](modules/GoldenFiles.md) |
| `ModelFixtures` | the fixtures of a test target, and the checks that a type and its table agree | [spec](modules/ModelFixtures.md) |
