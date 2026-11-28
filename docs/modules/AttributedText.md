# AttributedText

Paragraphs to Foundation's `AttributedString` and back.

## What it provides

A bridge between the text model and Foundation's `AttributedString`. It turns a `TextBody` or a `Paragraph`
into an attributed string and reads one back. Italic, bold and strikethrough travel as the inline
presentation intent; underline, the rest of a run's style, links and inline objects travel as the library's
own attributes; and a paragraph-bound attribute carries each paragraph's properties and its identifier.
`AttributedTextOptions` governs the edges, such as whether the last paragraph ends in a line feed.

## Principal API

- `AttributedTextOptions` — the options of the round trip.
- `ContentAttribute`, `ParagraphAttribute`, `RunIndexAttribute`, `UnderlineAttribute` — the library's own attributes.
- `AttributedTextError` — a run that does not survive the round trip.

## Resources

None.

## Depends on

`TextModel`, `WireFormat`. A product module of `StudioDocs`.
