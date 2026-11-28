# TextModel

Text bodies, paragraphs, runs, links, breaks, character, paragraph, list and layout properties, and
stylesheets.

## What it provides

The model of rich text in a document. A `TextBody` is a sequence of paragraphs; a `Paragraph` is a sequence
of `ParagraphContent`, each a `TextRun` of styled text or an inline object; and a `TextRun` carries its
`CharacterProperties`. A paragraph carries `ParagraphProperties` — alignment, first-line and edge indents,
tab stops, line spacing, outline level, and keep-with-next and widow controls — and layout properties for
its columns. Lists carry levels, number formats and string or image labels. A `Stylesheet` holds the named
character, paragraph and list styles that an object inherits through `PresetStyles`.

Each type is a `WireObject`, so a consumer attaches its own members with `ClientProperty` at any grain, a
run's `CharacterProperties` included.

## Principal API

- `TextBody`, `Paragraph`, `ParagraphContent`, `TextRun` — the text and its runs.
- `CharacterProperties` — the style of a run: font features, baseline, capitalisation, ligatures, colour.
- `ParagraphProperties`, `TextLayoutProperties` — paragraph and column layout.
- `ListProperties`, `ListLevel`, `ListLabel`, `ListNumberFormat` — list structure and labels.
- `Stylesheet`, `NamedCharacterStyle`, `NamedParagraphStyle`, `NamedListStyle` — named styles.
- `Hyperlink`, `HyperlinkField` — links in text.
- `ParagraphBreak`, `ParagraphSeparator` — breaks between and within paragraphs.
- `TextFormat` — the format table of this target.

## Resources

`Resources/format.json`, the format table of the text types.

## Depends on

`Appearance`, `JSONTree`, `PresetStyles`, `ResourceReferences`, `WireFormat`. A product module of `StudioDocs`.
