# CanvasCommon

What canvas objects share: geometry, labels, reflections, durations, and the owning of titles and captions.

## What it provides

The values a canvas object holds whatever its kind: its geometry — position, size and rotation — a label,
a reflection, a duration, and the ends of a line. It also holds the mix-ins by which an object owns a title
and a caption, so a chart, a table or an image carries its own title and caption in one way.

## Principal API

- `Geometry` — position, size and rotation.
- `Label` — a label on an object.
- `Reflection` — a reflection below an object.
- `DurationValue` — a duration, for timed media.
- `LineEnd` — the end treatment of a line.
- `TitleOwning`, `CaptionOwning`, `PlaceableTitleOwning` — owning a title and a caption, with generic forms.
- `CanvasCommonFormat` — the format table of this target.

## Resources

`Resources/format.json`, the format table of the shared canvas types.

## Depends on

`Appearance`, `JSONTree`, `TextModel`, `WireFormat`. A product module of `StudioDocs`.
