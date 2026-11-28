# TableModel

Tables: cells, rows, columns, formats, formulas, conditional styles, filters, sorts and visual properties.

## What it provides

The model of a table. It holds the cells, rows and columns; the format of a cell's value — number,
currency, date and time, duration, fraction, custom and boolean; formulas by cell reference and by object
id; conditional styles and their rules; filters and their combinations; and the visual properties of the
table. A cell draws its text from `TextModel` and its appearance from `Appearance`.

## Principal API

- `CellProperties`, `CellFormat`, `CellFormatType`, `CellStrokes` — a cell, its format and its strokes.
- `CellFormula`, `IdBasedFormula`, `CellReference`, `CellRange` — formulas and the cells they read.
- `ColumnHeader`, `ColumnHeaderKind`, `ColumnVisibility`, `ColumnGroupLabel` — columns and their headers.
- `ConditionalStyleRule`, `ConditionalStyleSet`, `ConditionalStylePreset` — conditional styles.
- `FilterRule`, `FilterSet`, `FilterCombination` — filters.
- `NumberFormat`, `CurrencyFormat`, `DateTimeFormat`, `DurationFormat`, `FractionFormat`, `CustomFormat`, `BoolFormat` — value formats.
- `OverallProperties` — the visual properties of the table.
- `TableModelFormat` — the format table of this target.

## Resources

`Resources/format.json`, the format table of the table types.

## Depends on

`Appearance`, `CanvasCommon`, `JSONTree`, `TextModel`, `WireFormat`. A product module of `StudioDocs`.
