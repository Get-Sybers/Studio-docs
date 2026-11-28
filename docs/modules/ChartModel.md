# ChartModel

Every kind of chart, with axes, series, data, legends and label formatting.

## What it provides

The model of a chart. A `Chart` holds its common properties, its data — rows and values from a source —
its series, a legend, a category axis and a value axis, and the formatting of its labels. Every kind of
chart is modelled: bar, column, line, area, bubble, donut, category-comparison and correlation, in flat,
3D and interactive forms, and a mixed chart that combines them.

## Principal API

- `Chart`, `ChartCommon` — a chart and the properties every chart shares.
- `ChartData`, `ChartDataRow`, `ChartDataValue`, `ChartDataSource` — the data of a chart.
- `ChartSeries`, `ChartLegend`, `ChartColor` — series, legend and colour.
- `ChartCategoryAxis`, `ChartValueAxis`, `ChartAxisCommon`, `AxisScale`, `AxisLabelOrientation` — the axes.
- `ChartLabelFormatting`, `LabelSpacing` — label formatting.
- `BarChart`, `ColumnChart`, `LineChart`, `AreaChart`, `BubbleChart`, `DonutChart`, `CorrelationChart`, their 3D and interactive variants, and `MixedChart` — the kinds of chart.
- `ChartModelFormat` — the format table of this target.

## Resources

`Resources/format.json`, the format table of the chart types.

## Depends on

`Appearance`, `CanvasCommon`, `JSONTree`, `TableModel`, `TextModel`, `WireFormat`. A product module of
`StudioDocs`.
