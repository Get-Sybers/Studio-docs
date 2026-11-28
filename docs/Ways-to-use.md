# Ways to use Studio-docs

The package models the Creator Studio document format and gives a consumer more than a reader of plain
text. Four patterns draw on parts of the library that a simple text client leaves untouched. Each is a
present capability of the modules named; [the module specs](Modules.md) describe those modules in full.

## Carry your own metadata on a document

Every modelled type is a `WireObject`, and a `WireObject` carries members of the client's own through
`ClientProperty<Value>`. `setValue(_:of:)` writes one and `value(of:)` reads it back; a reader that does
not model a member keeps it in the object's envelope and writes it back unchanged. The metadata rides
inside the package and survives every round trip, including a save by a reader that knows nothing of it.

A client property sits on a body, a section, a paragraph, and a run's `CharacterProperties` alike, so
metadata attaches at the grain the client needs. For a mark bound to a stretch of a paragraph rather than
to the whole of it, a paragraph-level client property holds a list of objects, each with a byte range into
the paragraph's text and a payload of its own: a note, the speaker of a line, a point of view, a quality
judged. `ObjectID` on a section or a paragraph gives each one a stable identifier, so a mark keyed by that
identifier survives an edit elsewhere in the document.

This is how an annotated copy of a manuscript carries the output of an analysis — who speaks, who listens,
whose head a passage is told from, a measure that falls outside its band — as span-anchored members that
any Studio-docs reader preserves.

## Render and edit through the AttributedText bridge

`AttributedText` turns a `TextBody` or a `Paragraph` into Foundation's `AttributedString` and reads one
back. Italic, bold and strikethrough travel as the inline presentation intent; underline, the rest of a
run's style, links and inline objects travel as the library's own attributes; a paragraph-bound attribute
carries each paragraph's properties and its identifier. A view built on TextKit draws its storage from the
bridge and writes edits back into the model, and the attributed string a client already holds reads into a
document body without a bespoke converter.

## Use the whole text model, not italic alone

`TextModel` holds far more than italic runs and page breaks. A paragraph carries alignment, first-line and
edge indents, tab stops, line spacing, an outline level, and keep-with-next and widow controls through
`ParagraphProperties`; a run carries the font feature, baseline, capitalisation, ligature and colour fields
of `CharacterProperties`; lists carry levels, number formats and string or image labels; and a `Stylesheet`
holds named character, paragraph and list styles that an object inherits. Headings, block quotations,
numbered lists and a styled epigraph come from this one model, under the same format, with nothing new to
define.

## Generate presentations and charts as native documents

`PresentationModel` makes `Presentation` a document body, so `StudioDocument<Presentation>` writes a slide
deck in the format: slides, layouts, a `KeynoteTheme`, and the shape, media and table styles of a
stylesheet. `CanvasModel`, `ChartModel` and `TableModel` model what stands on a slide — shapes, text boxes,
images, movies, audio, groups and connection lines; every kind of chart with its axes, series, legend and
label formatting; and tables with cell formats and formulas. A report of figures, or a chart of a measure
drawn from a document, writes as one `.studiodoc` that the format's own applications open.
