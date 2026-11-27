# CanvasModel

The objects of a canvas and their union `CanvasObject`.

## What it provides

The objects that stand on a canvas or a slide — a shape, a text box, an image, a movie, audio, a group and
a connection line — and `CanvasObject`, the union of them. Paths, image masks, connection anchors and
playback options belong here; a text box draws its text from `TextModel`, a chart from `ChartModel` and a
table from `TableModel`.

## Principal API

- `CanvasObject` — the union of the canvas objects.
- `Shape`, `Textbox`, `Image`, `Movie`, `Audio`, `Group` — the objects.
- `ConnectionLine`, `ConnectionAnchor`, `ConnectionEnd`, `AnchorMagnet`, `ConnectionLineKind` — connection lines.
- `Path`, `BezierPath`, `InstantAlphaPath`, `ImageMask`, `Rect` — paths, masks and geometry.
- `PlaybackOptions`, `LoopOption` — playback of timed media.
- `CanvasModelFormat` — the format table of this target.

## Resources

`Resources/format.json`, the format table of the canvas-object types.

## Depends on

`Appearance`, `CanvasCommon`, `ChartModel`, `JSONTree`, `ResourceReferences`, `TableModel`, `TextModel`,
`WireFormat`. A product module of `StudioDocs`.
