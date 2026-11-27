# Appearance

Colours, fills, gradients, image fills, shadows, strokes and the geometric values they use.

## What it provides

The appearance values that objects of the format share. A colour stands in a colour space; a fill is flat,
a gradient of stops, or an image under a technique; a shadow is a drop, contact or curved shadow; a stroke
is a line or a text stroke with its pattern; and the geometric values — insets, offsets, positions and
sizes — are the frame these sit in.

## Principal API

- `ColorValue`, `RGBAColor`, `RGBColorSpace` — a colour and its space.
- `Fill`, `GradientFill`, `GradientStop`, `GradientFlavor`, `LinearFlavor`, `RadialFlavor` — flat and gradient fills.
- `ImageFill`, `ImageFillTechnique` — a fill from an image.
- `Shadow`, `DropShadow`, `ContactShadow`, `CurvedShadow` — the kinds of shadow.
- `Stroke`, `LineStroke`, `TextStroke`, `StrokePattern` — strokes and their pattern.
- `PictureFrame`, `PictureFrameName` — a decorative frame.
- `Insets`, `OffsetValue`, `PositionValue`, `SizeValue` — the geometric values.
- `AppearanceFormat` — the format table of this target.

## Resources

`Resources/format.json`, the format table of the appearance types.

## Depends on

`JSONTree`, `ResourceReferences`, `WireFormat`. A product module of `StudioDocs`.
