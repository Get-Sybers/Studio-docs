# PageSizes

The trim sizes of the book trade, in points.

## What it provides

A catalogue of the trim sizes the book trade uses — American, British, ISO and Japanese — each in points,
read from `Resources/page-sizes.json`. A consumer looks a size up by name and gives it to a text document,
so a document carries the trim size of a book.

## Principal API

- `PageSizeCatalogue` — the sizes, looked up by name.
- `PageSize` — one trim size, in points.
- `PageSizeSystem` — the system a size belongs to: American, British, ISO or Japanese.
- `LengthUnit` — the unit a size is quoted in.

## Resources

`Resources/page-sizes.json`, the sizes the catalogue holds. It is a data file, not a format table.

## Depends on

`Appearance`. A product module of `StudioDocs`.
