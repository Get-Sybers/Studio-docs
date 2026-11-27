# TextDocument

The library's own small body of text, under its own type identifiers.

## What it provides

A document body of the library's own, for long-form text. A `TextDocumentBody` has a title, its text
styles, its sections in order, and the size of a page; a `TextSection` has a heading and its text as
paragraphs of `TextModel`. It is the body a consumer opens and saves through `StudioDocument` when the
document is text rather than a presentation, and it carries the consumer's own members through
`ClientProperty` on the body, a section and a paragraph.

## Principal API

- `TextDocumentBody` — the body: title, styles, sections, page size.
- `TextSection` — a heading and its paragraphs.
- `TextDocumentFormat` — the format table of this target.

## Resources

`Resources/format.json`, the format table of the text-document types.

## Depends on

`Appearance`, `DocumentPackage`, `TextModel`, `WireFormat`. A product module of `StudioDocs`.
