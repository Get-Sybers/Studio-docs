# PresentationModel

The presentation, its slides, layouts and theme, the stylesheet's styles, and `Presentation` as a document
body.

## What it provides

The presentation itself. `Presentation` is a document body, so `StudioDocument<Presentation>` opens and
saves a Keynote presentation typed: its slides, their layouts, a `KeynoteTheme`, and the shape, media and
table styles of a stylesheet. A slide holds its objects of `CanvasModel`, a background and its
placeholders.

## Principal API

- `Presentation` — the body: slides, layouts, theme, styles.
- `Slide`, `SlideLayout`, `SlideObject`, `SlideBackground` — a slide, its layout, its objects and its background.
- `KeynoteTheme` — the theme of a presentation.
- `ShapeStyle`, `ShapeProperties`, `MediaStyle`, `MediaProperties`, `CellStyle`, `TableStyleCollection`, `OverallStyle` — the styles of the stylesheet.
- `PlaceholderDefinition`, `PlaceholderInfo`, `PlaceholderKind` — the placeholders of a layout.
- `PresentationModelFormat` — the format table of this target.

## Resources

`Resources/format.json`, the format table of the presentation types.

## Depends on

`Appearance`, `CanvasCommon`, `CanvasModel`, `DocumentPackage`, `JSONTree`, `TableModel`, `TextModel`,
`WireFormat`. A product module of `StudioDocs`.
