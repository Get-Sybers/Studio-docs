# Modelled types

`make generate` writes this file from the format tables, `Sources/<Target>/Resources/format.json`.
It lists every type of the format that the library models, with the latest version of the type
that the library models and the members or cases it reads. A member or a case that a later
version than 1.0 introduced shows that version in brackets.

| Type identifier | Swift type | Target | Kind | Version | Members or cases |
| --- | --- | --- | --- | --- | --- |
| `com.apple.apps.content-language.area-chart` | `AreaChart` | ChartModel | object | 1.0 | `title`, `caption`, `data`, `show_legend`, `legend`, `series`, `chart_colors`, `category_axis`, `value_axis`, `value_axis_secondary`, `geometry`, `aspect_ratio_locked`, `description` |
| `com.apple.apps.content-language.area3-dchart` | `Area3DChart` | ChartModel | object | 1.0 | `title`, `caption`, `data`, `show_legend`, `legend`, `series`, `chart_colors`, `category_axis`, `value_axis`, `value_axis_secondary`, `geometry`, `aspect_ratio_locked`, `description` |
| `com.apple.apps.content-language.audio` | `Audio` | CanvasModel | object | 1.0 | `geometry`, `aspect_ratio_locked`, `description`, `resource`, `playback_options`, `native_audio_recording` |
| `com.apple.apps.content-language.bar-chart` | `BarChart` | ChartModel | object | 1.0 | `title`, `caption`, `data`, `show_legend`, `legend`, `series`, `chart_colors`, `category_axis`, `value_axis`, `value_axis_secondary`, `geometry`, `aspect_ratio_locked`, `description` |
| `com.apple.apps.content-language.bar-interactive-chart` | `BarInteractiveChart` | ChartModel | object | 1.0 | `title`, `caption`, `data`, `show_legend`, `legend`, `series`, `chart_colors`, `category_axis`, `value_axis`, `value_axis_secondary`, `geometry`, `aspect_ratio_locked`, `description` |
| `com.apple.apps.content-language.bar3-dchart` | `Bar3DChart` | ChartModel | object | 1.0 | `title`, `caption`, `data`, `show_legend`, `legend`, `series`, `chart_colors`, `category_axis`, `value_axis`, `value_axis_secondary`, `geometry`, `aspect_ratio_locked`, `description` |
| `com.apple.apps.content-language.bubble-chart` | `BubbleChart` | ChartModel | object | 1.0 | `title`, `caption`, `data`, `show_legend`, `legend`, `series`, `chart_colors`, `value_axis_x`, `value_axis_y`, `geometry`, `aspect_ratio_locked`, `description` |
| `com.apple.apps.content-language.bubble-interactive-chart` | `BubbleInteractiveChart` | ChartModel | object | 1.0 | `title`, `caption`, `data`, `show_legend`, `legend`, `series`, `chart_colors`, `value_axis_x`, `value_axis_y`, `geometry`, `aspect_ratio_locked`, `description` |
| `com.apple.apps.content-language.canvas-object-generic` | `GenericCanvasObject` | CanvasModel | object | 1.0 | `geometry`, `aspect_ratio_locked`, `description` |
| `com.apple.apps.content-language.canvas-object` | `CanvasObject` | CanvasModel | union | 1.2 | `audio` (1.2), `chart` (1.2), `connectionLine`, `genericCanvasObject`, `group`, `image`, `movie` (1.2), `shape`, `table`, `textbox` (1.1) |
| `com.apple.apps.content-language.caption-owning-generic` | `GenericCaptionOwning` | CanvasCommon | object | 1.0 | `caption` |
| `com.apple.apps.content-language.caption-owning` | `CaptionOwning` | CanvasCommon | union | 1.0 | `genericCaptionOwning` |
| `com.apple.apps.content-language.category-comparison-chart-generic` | `GenericCategoryComparisonChart` | ChartModel | object | 1.0 | `category_axis`, `value_axis`, `value_axis_secondary` |
| `com.apple.apps.content-language.category-comparison-chart` | `CategoryComparisonChart` | ChartModel | union | 1.0 | `area3Dchart`, `areaChart`, `bar3Dchart`, `barChart`, `barInteractiveChart`, `column3Dchart`, `columnChart`, `columnInteractiveChart`, `genericCategoryComparisonChart`, `line3Dchart`, `lineChart`, `mixedChart`, `radarChart`, `stackedArea3Dchart`, `stackedAreaChart`, `stackedBar3Dchart`, `stackedBarChart`, `stackedColumn3Dchart`, `stackedColumnChart`, `twoAxisChart` |
| `com.apple.apps.content-language.character-properties.font-features-type` | `FontFeature` | TextModel | object | 1.0 | `feature`, `selector` |
| `com.apple.apps.content-language.character-properties` | `CharacterProperties` | TextModel | object | 1.0 | `background_color`, `baseline`, `baseline_shift`, `bold`, `capitalization`, `character_fill`, `character_fill_should_fill_container`, `compatibility_font_name`, `emphasis_mark`, `font_features`, `font_name`, `font_size`, `is_named_point_size`, `italic`, `language`, `ligatures`, `shadow`, `strikethrough`, `strikethrough_color`, `strikethrough_width`, `stroke`, `tracking`, `underline`, `underline_color`, `word_strikethrough`, `word_underline`, `writing_direction` |
| `com.apple.apps.content-language.chart-axis-common-generic` | `GenericChartAxisCommon` | ChartModel | object | 1.0 | `title`, `title_text_style`, `label_text_style`, `show_labels`, `show_title`, `show_major_tickmarks`, `show_minor_tickmarks`, `labels_orientation` |
| `com.apple.apps.content-language.chart-axis-common.axis-label-orientation` | `AxisLabelOrientation` | ChartModel | union | 1.0 | `custom`, `horizontal`, `left_diagonal`, `left_vertical`, `parallel`, `perpendicular`, `right_diagonal`, `right_vertical` |
| `com.apple.apps.content-language.chart-axis-common` | `ChartAxisCommon` | ChartModel | union | 1.0 | `chartCategoryAxis`, `chartValueAxis`, `genericChartAxisCommon` |
| `com.apple.apps.content-language.chart-category-axis.label-spacing` | `LabelSpacing` | ChartModel | union | 1.0 | `auto_fit`, `custom`, `none`, `show_all` |
| `com.apple.apps.content-language.chart-category-axis` | `ChartCategoryAxis` | ChartModel | object | 1.0 | `title`, `title_text_style`, `label_text_style`, `show_labels`, `show_title`, `show_major_tickmarks`, `show_minor_tickmarks`, `labels_orientation`, `label_format_type`, `label_date_format`, `label_duration_format`, `label_number_format`, `label_currency_format`, `label_spacing`, `show_axis`, `show_major_gridlines`, `show_clustered_series_labels`, `show_last_label` |
| `com.apple.apps.content-language.chart-common-generic` | `GenericChartCommon` | ChartModel | object | 1.0 | `title`, `caption`, `data`, `show_legend`, `legend`, `series`, `chart_colors` |
| `com.apple.apps.content-language.chart-common.chart-color` | `ChartColor` | ChartModel | object | 1.0 | `fill` |
| `com.apple.apps.content-language.chart-common` | `ChartCommon` | ChartModel | union | 1.0 | `area3Dchart`, `areaChart`, `bar3Dchart`, `barChart`, `barInteractiveChart`, `bubbleChart`, `bubbleInteractiveChart`, `column3Dchart`, `columnChart`, `columnInteractiveChart`, `donutChart`, `genericChartCommon`, `line3Dchart`, `lineChart`, `mixedChart`, `pie3Dchart`, `pieChart`, `radarChart`, `scatterChart`, `scatterInteractiveChart`, `stackedArea3Dchart`, `stackedAreaChart`, `stackedBar3Dchart`, `stackedBarChart`, `stackedColumn3Dchart`, `stackedColumnChart`, `twoAxisChart` |
| `com.apple.apps.content-language.chart-data.chart-data-row` | `ChartDataRow` | ChartModel | object | 1.0 | `values` |
| `com.apple.apps.content-language.chart-data.chart-data-value` | `ChartDataValue` | ChartModel | union | 1.0 | `date`, `duration`, `empty`, `number` |
| `com.apple.apps.content-language.chart-data` | `ChartData` | ChartModel | object | 1.0 | `plot_direction`, `shared_xvalues`, `chart_data_source`, `column_labels`, `row_labels`, `rows` |
| `com.apple.apps.content-language.chart-label-formatting-generic` | `GenericChartLabelFormatting` | ChartModel | object | 1.0 | `label_format_type`, `label_date_format`, `label_duration_format`, `label_number_format`, `label_currency_format` |
| `com.apple.apps.content-language.chart-label-formatting` | `ChartLabelFormatting` | ChartModel | union | 1.0 | `chartCategoryAxis`, `chartSeries`, `chartValueAxis`, `genericChartLabelFormatting` |
| `com.apple.apps.content-language.chart-legend` | `ChartLegend` | ChartModel | object | 1.0 | `geometry`, `label_text_style` |
| `com.apple.apps.content-language.chart-series` | `ChartSeries` | ChartModel | object | 1.0 | `label_format_type`, `label_date_format`, `label_duration_format`, `label_number_format`, `label_currency_format`, `series_index`, `show_value_labels`, `value_label_position`, `value_label_text_style`, `value_label_outside_text_style`, `fill`, `stroke`, `symbol_type`, `symbol_stroke`, `symbol_fill`, `symbol_size`, `fill_reuse_rules`, `fill_use_series_stroke_alpha_multiplier`, `connection_line_type`, `value_labels_selection`, `show_negative_data`, `mixed_series_type`, `y_axis_selection` |
| `com.apple.apps.content-language.chart-value-axis` | `ChartValueAxis` | ChartModel | object | 1.0 | `title`, `title_text_style`, `label_text_style`, `show_labels`, `show_title`, `show_major_tickmarks`, `show_minor_tickmarks`, `labels_orientation`, `label_format_type`, `label_date_format`, `label_duration_format`, `label_number_format`, `label_currency_format`, `scale`, `max`, `min`, `show_axis`, `show_major_gridlines`, `show_minimum_label`, `number_of_major_gridlines`, `number_of_decades`, `number_of_minor_gridlines`, `show_minor_gridlines` |
| `com.apple.apps.content-language.chart` | `Chart` | ChartModel | union | 1.0 | `area`, `area_3d`, `bar`, `bar_3d`, `bar_interactive`, `bubble`, `bubble_interactive`, `column`, `column_3d`, `column_interactive`, `donut`, `line`, `line_3d`, `mixed`, `pie`, `pie_3d`, `radar`, `scatter`, `scatter_interactive`, `stacked_area`, `stacked_area_3d`, `stacked_bar`, `stacked_bar_3d`, `stacked_column`, `stacked_column_3d`, `two_axis` |
| `com.apple.apps.content-language.color.rgba` | `RGBAColor` | Appearance | object | 1.1 | `red`, `green`, `blue`, `alpha`, `color_space`, `headroom` (1.1) |
| `com.apple.apps.content-language.color` | `ColorValue` | Appearance | union | 1.0 | `rgba` |
| `com.apple.apps.content-language.column-chart` | `ColumnChart` | ChartModel | object | 1.0 | `title`, `caption`, `data`, `show_legend`, `legend`, `series`, `chart_colors`, `category_axis`, `value_axis`, `value_axis_secondary`, `geometry`, `aspect_ratio_locked`, `description` |
| `com.apple.apps.content-language.column-interactive-chart` | `ColumnInteractiveChart` | ChartModel | object | 1.0 | `title`, `caption`, `data`, `show_legend`, `legend`, `series`, `chart_colors`, `category_axis`, `value_axis`, `value_axis_secondary`, `geometry`, `aspect_ratio_locked`, `description` |
| `com.apple.apps.content-language.column-metrics.equal-columns-description` | `EqualColumns` | TextModel | object | 1.0 | `count`, `gutter_width` |
| `com.apple.apps.content-language.column-metrics.unequal-columns-description` | `UnequalColumns` | TextModel | object | 1.0 | `column_widths`, `gutter_widths` |
| `com.apple.apps.content-language.column-metrics` | `ColumnMetrics` | TextModel | union | 1.0 | `equal`, `single`, `unequal` |
| `com.apple.apps.content-language.column3-dchart` | `Column3DChart` | ChartModel | object | 1.0 | `title`, `caption`, `data`, `show_legend`, `legend`, `series`, `chart_colors`, `category_axis`, `value_axis`, `value_axis_secondary`, `geometry`, `aspect_ratio_locked`, `description` |
| `com.apple.apps.content-language.connection-line.end.anchor.magnet` | `AnchorMagnet` | CanvasModel | union | 1.0 | `center`, `east`, `edge`, `floating`, `north`, `south`, `west` |
| `com.apple.apps.content-language.connection-line.end.anchor` | `ConnectionAnchor` | CanvasModel | object | 1.0 | `object_id`, `magnet` |
| `com.apple.apps.content-language.connection-line.end` | `ConnectionEnd` | CanvasModel | object | 1.0 | `end_point`, `line_end`, `outset`, `anchor` |
| `com.apple.apps.content-language.connection-line.line-type` | `ConnectionLineKind` | CanvasModel | union | 1.0 | `corner`, `curved`, `straight` |
| `com.apple.apps.content-language.connection-line` | `ConnectionLine` | CanvasModel | object | 1.0 | `geometry`, `aspect_ratio_locked`, `description`, `line_type`, `tail`, `head`, `stroke`, `opacity`, `shadow`, `reflection` |
| `com.apple.apps.content-language.contact-shadow` | `ContactShadow` | Appearance | object | 1.0 | `opacity`, `color`, `offset`, `radius`, `height` |
| `com.apple.apps.content-language.correlation-chart-generic` | `GenericCorrelationChart` | ChartModel | object | 1.0 | `value_axis_x`, `value_axis_y` |
| `com.apple.apps.content-language.correlation-chart` | `CorrelationChart` | ChartModel | union | 1.0 | `bubbleChart`, `bubbleInteractiveChart`, `genericCorrelationChart`, `scatterChart`, `scatterInteractiveChart` |
| `com.apple.apps.content-language.curved-shadow` | `CurvedShadow` | Appearance | object | 1.0 | `angle`, `opacity`, `color`, `offset`, `radius`, `curve` |
| `com.apple.apps.content-language.donut-chart` | `DonutChart` | ChartModel | object | 1.0 | `title`, `caption`, `data`, `show_legend`, `legend`, `series`, `chart_colors`, `geometry`, `aspect_ratio_locked`, `description` |
| `com.apple.apps.content-language.drop-shadow` | `DropShadow` | Appearance | object | 1.0 | `angle`, `opacity`, `color`, `offset`, `radius` |
| `com.apple.apps.content-language.duration` | `DurationValue` | CanvasCommon | union | 1.0 | `seconds` |
| `com.apple.apps.content-language.fill.gradient.flavor.linear` | `LinearFlavor` | Appearance | object | 1.1 | `angle`, `start_point` (1.1), `end_point` (1.1), `base_natural_size` (1.1) |
| `com.apple.apps.content-language.fill.gradient.flavor.radial` | `RadialFlavor` | Appearance | object | 1.0 | `start_point`, `end_point`, `base_natural_size` |
| `com.apple.apps.content-language.fill.gradient.flavor` | `GradientFlavor` | Appearance | union | 1.0 | `linear`, `radial` |
| `com.apple.apps.content-language.fill.gradient.stop` | `GradientStop` | Appearance | object | 1.0 | `color`, `fraction`, `inflection` |
| `com.apple.apps.content-language.fill.gradient` | `GradientFill` | Appearance | object | 1.1 | `is_advanced` (1.1), `stops`, `opacity`, `flavor` |
| `com.apple.apps.content-language.fill.image-fill` | `ImageFill` | Appearance | object | 1.0 | `resource`, `technique`, `scale_percent`, `tint_color` |
| `com.apple.apps.content-language.fill` | `Fill` | Appearance | union | 1.0 | `color`, `gradient`, `image` |
| `com.apple.apps.content-language.geometry` | `Geometry` | CanvasCommon | object | 1.0 | `position`, `size`, `angle`, `flip_horizontally`, `width_valid`, `height_valid` |
| `com.apple.apps.content-language.group` | `Group` | CanvasModel | object | 1.0 | `geometry`, `aspect_ratio_locked`, `description`, `title`, `title_is_positioned_on_top`, `caption`, `children` |
| `com.apple.apps.content-language.hyperlink.slide-target` | `SlideTarget` | TextModel | union | 1.0 | `by_identifier`, `first`, `last`, `last_viewed`, `next`, `previous` |
| `com.apple.apps.content-language.hyperlink` | `Hyperlink` | TextModel | union | 1.0 | `file`, `program`, `slide_jump`, `url` |
| `com.apple.apps.content-language.image.instant-alpha-path` | `InstantAlphaPath` | CanvasModel | object | 1.0 | `path`, `size` |
| `com.apple.apps.content-language.image.mask` | `ImageMask` | CanvasModel | object | 1.0 | `geometry`, `path` |
| `com.apple.apps.content-language.image` | `Image` | CanvasModel | object | 1.0 | `geometry`, `aspect_ratio_locked`, `description`, `title`, `title_is_positioned_on_top`, `caption`, `resource`, `mask`, `instant_alpha_path`, `stroke`, `opacity`, `shadow`, `reflection`, `is_placeholder`, `was_media_replaced` |
| `com.apple.apps.content-language.insets` | `Insets` | Appearance | object | 1.0 | `top`, `bottom`, `left`, `right` |
| `com.apple.apps.content-language.keynote-theme` | `KeynoteTheme` | PresentationModel | object | 1.0 | `name`, `locale`, `slide_layouts` |
| `com.apple.apps.content-language.label` | `Label` | CanvasCommon | object | 1.0 | `layout_properties`, `paragraph_properties`, `text`, `is_visible` |
| `com.apple.apps.content-language.layout-properties` | `TextLayoutProperties` | TextModel | object | 1.0 | `columns`, `continuous`, `margins`, `padding`, `shrink_to_fit`, `vertical_alignment`, `vertical_text`, `writing_direction` |
| `com.apple.apps.content-language.line-chart` | `LineChart` | ChartModel | object | 1.0 | `title`, `caption`, `data`, `show_legend`, `legend`, `series`, `chart_colors`, `category_axis`, `value_axis`, `value_axis_secondary`, `geometry`, `aspect_ratio_locked`, `description` |
| `com.apple.apps.content-language.line-spacing-type` | `LineSpacing` | TextModel | object | 1.0 | `kind`, `value` |
| `com.apple.apps.content-language.line3-dchart` | `Line3DChart` | ChartModel | object | 1.0 | `title`, `caption`, `data`, `show_legend`, `legend`, `series`, `chart_colors`, `category_axis`, `value_axis`, `value_axis_secondary`, `geometry`, `aspect_ratio_locked`, `description` |
| `com.apple.apps.content-language.list-label-type.list-image-label` | `ListImageLabel` | TextModel | object | 1.0 | `scale`, `offset`, `resource` |
| `com.apple.apps.content-language.list-label-type.list-number-label` | `ListNumberLabel` | TextModel | object | 1.0 | `number_format`, `scale`, `tiered` |
| `com.apple.apps.content-language.list-label-type.list-string-label` | `ListStringLabel` | TextModel | object | 1.0 | `string`, `scale`, `offset` |
| `com.apple.apps.content-language.list-label-type` | `ListLabel` | TextModel | union | 1.0 | `image`, `none`, `null_image`, `number`, `string` |
| `com.apple.apps.content-language.list-level-type` | `ListLevel` | TextModel | object | 1.0 | `label_indent`, `text_indent`, `label` |
| `com.apple.apps.content-language.list-properties` | `ListProperties` | TextModel | object | 1.0 | `font_color`, `font_name`, `writing_direction`, `shadow`, `levels` |
| `com.apple.apps.content-language.mixed-chart` | `MixedChart` | ChartModel | object | 1.0 | `title`, `caption`, `data`, `show_legend`, `legend`, `series`, `chart_colors`, `category_axis`, `value_axis`, `value_axis_secondary`, `geometry`, `aspect_ratio_locked`, `description` |
| `com.apple.apps.content-language.movie` | `Movie` | CanvasModel | object | 1.0 | `geometry`, `aspect_ratio_locked`, `description`, `title`, `title_is_positioned_on_top`, `caption`, `resource`, `poster_image`, `poster_time`, `playback_options`, `stroke`, `opacity`, `shadow`, `reflection` |
| `com.apple.apps.content-language.number-format-type` | `ListNumberFormat` | TextModel | object | 1.0 | `kind`, `upper`, `formal`, `format` |
| `com.apple.apps.content-language.offset` | `OffsetValue` | Appearance | object | 1.0 | `dx`, `dy` |
| `com.apple.apps.content-language.paragraph-properties.border-style-type` | `ParagraphBorders` | TextModel | object | 1.0 | `stroke`, `width`, `offset`, `rounded`, `no_borders`, `all_borders`, `before`, `after`, `leading`, `trailing` |
| `com.apple.apps.content-language.paragraph-properties` | `ParagraphProperties` | TextModel | object | 1.0 | `alignment`, `decimal_tab`, `default_tabs`, `fill`, `first_line_indent`, `following_style`, `hyphenate`, `list_style`, `keep_lines_together`, `keep_with_next`, `left_indent`, `line_spacing`, `outline_level`, `start_on_new_page`, `borders`, `right_indent`, `space_after`, `space_before`, `tabs`, `prevent_widow`, `show_in_bookmarks`, `show_in_tocnavigator`, `character_properties` |
| `com.apple.apps.content-language.paragraph.constituent` | `ParagraphContent` | TextModel | union | 1.0 | `hyperlink`, `inline_object`, `run` |
| `com.apple.apps.content-language.paragraph.hyperlink-field` | `HyperlinkField` | TextModel | object | 1.0 | `target`, `run` |
| `com.apple.apps.content-language.paragraph` | `Paragraph` | TextModel | object | 1.0 | `style`, `list_style`, `list_start`, `list_level`, `writing_direction`, `contents`, `break_type` |
| `com.apple.apps.content-language.path.bezier-path` | `BezierPath` | CanvasModel | object | 1.0 | `path`, `space` |
| `com.apple.apps.content-language.path` | `Path` | CanvasModel | union | 1.0 | `bezier` |
| `com.apple.apps.content-language.pie-chart` | `PieChart` | ChartModel | object | 1.0 | `title`, `caption`, `data`, `show_legend`, `legend`, `series`, `chart_colors`, `geometry`, `aspect_ratio_locked`, `description` |
| `com.apple.apps.content-language.pie3-dchart` | `Pie3DChart` | ChartModel | object | 1.0 | `title`, `caption`, `data`, `show_legend`, `legend`, `series`, `chart_colors`, `geometry`, `aspect_ratio_locked`, `description` |
| `com.apple.apps.content-language.placeable-title-owning-generic` | `GenericPlaceableTitleOwning` | CanvasCommon | object | 1.0 | `title`, `title_is_positioned_on_top` |
| `com.apple.apps.content-language.placeable-title-owning` | `PlaceableTitleOwning` | CanvasCommon | union | 1.0 | `genericPlaceableTitleOwning` |
| `com.apple.apps.content-language.playback-options` | `PlaybackOptions` | CanvasModel | object | 1.0 | `volume`, `start_time`, `end_time`, `loop_option`, `plays_across_slides` |
| `com.apple.apps.content-language.position` | `PositionValue` | Appearance | object | 1.0 | `x`, `y` |
| `com.apple.apps.content-language.presentation` | `Presentation` | PresentationModel | object | 1.0 | `theme`, `slide_size`, `slides`, `stylesheet` |
| `com.apple.apps.content-language.radar-chart` | `RadarChart` | ChartModel | object | 1.0 | `title`, `caption`, `data`, `show_legend`, `legend`, `series`, `chart_colors`, `category_axis`, `value_axis`, `value_axis_secondary`, `geometry`, `aspect_ratio_locked`, `description` |
| `com.apple.apps.content-language.rect` | `Rect` | CanvasModel | object | 1.0 | `position`, `size` |
| `com.apple.apps.content-language.reflection` | `Reflection` | CanvasCommon | object | 1.0 | `opacity`, `fade_acceleration` |
| `com.apple.apps.content-language.resource.base64-encoded-resource` | `EmbeddedResource` | ResourceReferences | object | 2.0 | `string`, `filename`, `premium_resource_info` (2.0) |
| `com.apple.apps.content-language.resource.indirect-resource` | `IndirectResource` | ResourceReferences | object | 2.0 | `identifier`, `filename`, `premium_resource_info` (2.0) |
| `com.apple.apps.content-language.resource.premium-resource-info` | `PremiumResourceInfo` | ResourceReferences | object | 1.0 | `asset_uuid`, `is_derived_asset`, `may_need_watermark` |
| `com.apple.apps.content-language.resource` | `ResourceReference` | ResourceReferences | union | 1.0 | `base64_encoded`, `indirect` |
| `com.apple.apps.content-language.scatter-chart` | `ScatterChart` | ChartModel | object | 1.0 | `title`, `caption`, `data`, `show_legend`, `legend`, `series`, `chart_colors`, `value_axis_x`, `value_axis_y`, `geometry`, `aspect_ratio_locked`, `description` |
| `com.apple.apps.content-language.scatter-interactive-chart` | `ScatterInteractiveChart` | ChartModel | object | 1.0 | `title`, `caption`, `data`, `show_legend`, `legend`, `series`, `chart_colors`, `value_axis_x`, `value_axis_y`, `geometry`, `aspect_ratio_locked`, `description` |
| `com.apple.apps.content-language.shadow` | `Shadow` | Appearance | union | 1.1 | `contactShadow`, `curvedShadow`, `dropShadow`, `none` (1.1) |
| `com.apple.apps.content-language.shape` | `Shape` | CanvasModel | object | 1.0 | `geometry`, `aspect_ratio_locked`, `description`, `title`, `title_is_positioned_on_top`, `caption`, `path`, `tail`, `head`, `fill`, `stroke`, `opacity`, `shadow`, `reflection`, `layout_properties`, `paragraph_properties`, `text` |
| `com.apple.apps.content-language.size` | `SizeValue` | Appearance | object | 1.0 | `width`, `height` |
| `com.apple.apps.content-language.slide-background` | `SlideBackground` | PresentationModel | union | 1.0 | `standard` |
| `com.apple.apps.content-language.slide-layout` | `SlideLayout` | PresentationModel | object | 1.1 | `name`, `contents`, `background`, `slide_objects_layer_with_layout` (1.1) |
| `com.apple.apps.content-language.slide-object.placeholder-info.placeholder-definition` | `PlaceholderDefinition` | PresentationModel | object | 1.0 | `kind`, `is_visible` |
| `com.apple.apps.content-language.slide-object.placeholder-info` | `PlaceholderInfo` | PresentationModel | union | 1.0 | `defined`, `tagged` |
| `com.apple.apps.content-language.slide-object` | `SlideObject` | PresentationModel | object | 1.0 | `instructional_text`, `is_locked`, `object`, `placeholder_info`, `source_kind` |
| `com.apple.apps.content-language.slide` | `Slide` | PresentationModel | object | 1.0 | `layout`, `contents`, `background`, `depth`, `note` |
| `com.apple.apps.content-language.stacked-area-chart` | `StackedAreaChart` | ChartModel | object | 1.0 | `title`, `caption`, `data`, `show_legend`, `legend`, `series`, `chart_colors`, `category_axis`, `value_axis`, `value_axis_secondary`, `geometry`, `aspect_ratio_locked`, `description` |
| `com.apple.apps.content-language.stacked-area3-dchart` | `StackedArea3DChart` | ChartModel | object | 1.0 | `title`, `caption`, `data`, `show_legend`, `legend`, `series`, `chart_colors`, `category_axis`, `value_axis`, `value_axis_secondary`, `geometry`, `aspect_ratio_locked`, `description` |
| `com.apple.apps.content-language.stacked-bar-chart` | `StackedBarChart` | ChartModel | object | 1.0 | `title`, `caption`, `data`, `show_legend`, `legend`, `series`, `chart_colors`, `category_axis`, `value_axis`, `value_axis_secondary`, `geometry`, `aspect_ratio_locked`, `description` |
| `com.apple.apps.content-language.stacked-bar3-dchart` | `StackedBar3DChart` | ChartModel | object | 1.0 | `title`, `caption`, `data`, `show_legend`, `legend`, `series`, `chart_colors`, `category_axis`, `value_axis`, `value_axis_secondary`, `geometry`, `aspect_ratio_locked`, `description` |
| `com.apple.apps.content-language.stacked-column-chart` | `StackedColumnChart` | ChartModel | object | 1.0 | `title`, `caption`, `data`, `show_legend`, `legend`, `series`, `chart_colors`, `category_axis`, `value_axis`, `value_axis_secondary`, `geometry`, `aspect_ratio_locked`, `description` |
| `com.apple.apps.content-language.stacked-column3-dchart` | `StackedColumn3DChart` | ChartModel | object | 1.0 | `title`, `caption`, `data`, `show_legend`, `legend`, `series`, `chart_colors`, `category_axis`, `value_axis`, `value_axis_secondary`, `geometry`, `aspect_ratio_locked`, `description` |
| `com.apple.apps.content-language.stroke.frame` | `PictureFrame` | Appearance | object | 1.0 | `name`, `scale_percent` |
| `com.apple.apps.content-language.stroke.line` | `LineStroke` | Appearance | object | 1.0 | `color`, `width`, `pattern` |
| `com.apple.apps.content-language.stroke` | `Stroke` | Appearance | union | 1.0 | `empty`, `frame`, `line` |
| `com.apple.apps.content-language.stylesheet.character-style` | `NamedCharacterStyle` | TextModel | object | 1.0 | `name`, `properties` |
| `com.apple.apps.content-language.stylesheet.list-style` | `NamedListStyle` | TextModel | object | 1.0 | `name`, `properties` |
| `com.apple.apps.content-language.stylesheet.media-style.media-properties` | `MediaProperties` | PresentationModel | object | 1.0 | `stroke`, `opacity`, `reflection`, `shadow` |
| `com.apple.apps.content-language.stylesheet.media-style` | `MediaStyle` | PresentationModel | object | 1.0 | `name`, `properties` |
| `com.apple.apps.content-language.stylesheet.paragraph-style` | `NamedParagraphStyle` | TextModel | object | 1.0 | `name`, `properties` |
| `com.apple.apps.content-language.stylesheet.shape-style.shape-properties` | `ShapeProperties` | PresentationModel | object | 1.0 | `stroke`, `opacity`, `reflection`, `shadow`, `fill`, `head`, `tail`, `layout_properties`, `paragraph_properties` |
| `com.apple.apps.content-language.stylesheet.shape-style` | `ShapeStyle` | PresentationModel | object | 1.0 | `name`, `properties` |
| `com.apple.apps.content-language.stylesheet.table-style-collection.body-stroke-style` | `BodyStrokeStyle` | PresentationModel | object | 1.0 | `name`, `properties` |
| `com.apple.apps.content-language.stylesheet.table-style-collection.cell-style` | `CellStyle` | PresentationModel | object | 1.0 | `name`, `properties` |
| `com.apple.apps.content-language.stylesheet.table-style-collection.header-footer-stroke-style` | `HeaderFooterStrokeStyle` | PresentationModel | object | 1.0 | `name`, `properties` |
| `com.apple.apps.content-language.stylesheet.table-style-collection.overall-style` | `OverallStyle` | PresentationModel | object | 1.0 | `name`, `properties` |
| `com.apple.apps.content-language.stylesheet.table-style-collection` | `TableStyleCollection` | PresentationModel | object | 1.0 | `table_name_shape_style`, `table_name_style`, `overall_style`, `body_cell_style`, `body_text_style`, `body_stroke_style`, `header_row_cell_style`, `header_row_text_style`, `header_row_stroke_style`, `header_column_cell_style`, `header_column_text_style`, `header_column_stroke_style`, `footer_row_cell_style`, `footer_row_text_style`, `footer_row_stroke_style`, `category_level1_cell_style`, `category_level1_text_style`, `category_level2_cell_style`, `category_level2_text_style`, `category_level3_cell_style`, `category_level3_text_style`, `category_level4_cell_style`, `category_level4_text_style`, `category_level5_cell_style`, `category_level5_text_style`, `label_level1_cell_style`, `label_level1_text_style`, `label_level2_cell_style`, `label_level2_text_style`, `label_level3_cell_style`, `label_level3_text_style`, `label_level4_cell_style`, `label_level4_text_style`, `label_level5_cell_style`, `label_level5_text_style`, `pivot_body_summary_row_cell_style`, `pivot_body_summary_column_cell_style`, `pivot_header_column_summary_cell_style` |
| `com.apple.apps.content-language.stylesheet` | `Stylesheet` | TextModel | object | 1.0 | `character_styles`, `paragraph_styles`, `list_styles` |
| `com.apple.apps.content-language.tab-stop-type` | `TabStop` | TextModel | object | 1.0 | `position`, `kind`, `leader` |
| `com.apple.apps.content-language.table.category-rules` | `CategoryRules` | TableModel | object | 1.0 |  |
| `com.apple.apps.content-language.table.cell-format.base-format` | `BaseFormat` | TableModel | object | 1.0 | `base`, `base_places`, `base_use_minus_sign` |
| `com.apple.apps.content-language.table.cell-format.bool-format` | `BoolFormat` | TableModel | object | 1.0 | `true_string`, `false_string` |
| `com.apple.apps.content-language.table.cell-format.currency-format` | `CurrencyFormat` | TableModel | object | 1.0 | `decimal_places`, `negative_number_style`, `use_thousands_separator`, `accounting_style`, `currency_code` |
| `com.apple.apps.content-language.table.cell-format.date-time-format` | `DateTimeFormat` | TableModel | object | 1.0 | `format_string` |
| `com.apple.apps.content-language.table.cell-format.duration-format` | `DurationFormat` | TableModel | object | 1.0 | `use_automatic_units`, `smallest_unit`, `largest_unit`, `style` |
| `com.apple.apps.content-language.table.cell-format.fraction-format` | `FractionFormat` | TableModel | object | 1.0 | `accuracy` |
| `com.apple.apps.content-language.table.cell-format.number-format` | `NumberFormat` | TableModel | object | 1.0 | `decimal_places`, `negative_number_style`, `use_thousands_separator` |
| `com.apple.apps.content-language.table.cell-format` | `CellFormat` | TableModel | object | 1.0 | `format_type`, `number_format`, `currency_format`, `fraction_format`, `base_format`, `bool_format`, `duration_format`, `date_time_format`, `custom_format_identifier` |
| `com.apple.apps.content-language.table.cell-properties` | `CellProperties` | TableModel | object | 1.0 | `text_wrap`, `vertical_alignment`, `padding`, `fill` |
| `com.apple.apps.content-language.table.cell-range.row-column-id-range` | `RowColumnIdRange` | TableModel | object | 1.0 | `top_left_row_identifier`, `top_left_column_identifier`, `bottom_right_row_identifier`, `bottom_right_column_identifier` |
| `com.apple.apps.content-language.table.cell-range` | `CellRange` | TableModel | union | 1.0 | `row_column_id_range` |
| `com.apple.apps.content-language.table.cell.formula.cell-reference` | `CellReference` | TableModel | object | 1.0 | `placeholder`, `display_notation`, `start_row_identifier`, `start_column_identifier`, `end_row_identifier`, `end_column_identifier`, `is_row_absolute`, `is_column_absolute`, `is_end_row_absolute`, `is_end_column_absolute`, `table_identifier` |
| `com.apple.apps.content-language.table.cell.formula.id-based-formula` | `IdBasedFormula` | TableModel | object | 1.0 | `expression`, `references` |
| `com.apple.apps.content-language.table.cell.formula` | `CellFormula` | TableModel | union | 1.0 | `display_string`, `id_based` |
| `com.apple.apps.content-language.table.cell.strokes` | `CellStrokes` | TableModel | object | 1.0 | `top`, `bottom`, `left`, `right` |
| `com.apple.apps.content-language.table.cell.unformatted-value` | `UnformattedValue` | TableModel | union | 1.0 | `boolean`, `date`, `number`, `rich_text`, `text` |
| `com.apple.apps.content-language.table.cell` | `TableCell` | TableModel | object | 1.0 | `value`, `unformatted_value`, `cell_format`, `cell_properties`, `text_properties`, `strokes`, `anchored_objects`, `column_index`, `formula`, `spill_range`, `conditional_style_set_identifier` |
| `com.apple.apps.content-language.table.column-header.group-label` | `ColumnGroupLabel` | TableModel | object | 1.0 | `grouping_row_identifier`, `group_value`, `is_collapsed`, `nesting_level` |
| `com.apple.apps.content-language.table.column-header.kind` | `ColumnHeaderKind` | TableModel | union | 1.0 | `body`, `grand_total`, `group_label`, `group_subtotal` |
| `com.apple.apps.content-language.table.column-header` | `ColumnHeader` | TableModel | object | 1.0 | `column_identifier`, `title`, `cell_format`, `column_width`, `cell_properties`, `text_properties`, `visibility_state`, `kind` |
| `com.apple.apps.content-language.table.conditional-style-set.rule` | `ConditionalStyleRule` | TableModel | object | 1.0 | `predicate`, `cell_style`, `text_style`, `preset_kind` |
| `com.apple.apps.content-language.table.conditional-style-set` | `ConditionalStyleSet` | TableModel | object | 1.0 | `rules` |
| `com.apple.apps.content-language.table.custom-format.custom-format-condition` | `CustomFormatCondition` | TableModel | object | 1.0 | `condition_type`, `condition_value`, `format_string`, `number_format_data` |
| `com.apple.apps.content-language.table.custom-format.number-format-data` | `NumberFormatData` | TableModel | object | 1.0 | `scale_factor`, `fraction_accuracy`, `interstitial_strings`, `interstitial_string_insertion_indexes`, `minimum_integer_width`, `decimal_width`, `number_of_non_space_integer_placeholder_digits`, `number_of_non_space_decimal_placeholder_digits`, `index_from_right_of_last_digit_placeholder`, `number_of_hash_decimal_placeholders`, `total_number_of_decimal_placeholders_in_format`, `currency_code`, `show_thousands_separator`, `use_accounting_style`, `requires_fraction_replacement`, `format_contains_integer_token`, `is_complex_format` |
| `com.apple.apps.content-language.table.custom-format` | `CustomFormat` | TableModel | object | 1.0 | `format_name`, `format_string`, `format_type`, `number_format_data`, `conditions` |
| `com.apple.apps.content-language.table.date` | `TableDate` | TableModel | object | 1.0 | `time_interval_since1970` |
| `com.apple.apps.content-language.table.filter-set.filter.rule` | `FilterRule` | TableModel | object | 1.0 | `predicate` |
| `com.apple.apps.content-language.table.filter-set.filter` | `TableFilter` | TableModel | object | 1.0 | `column_identifier`, `rules` |
| `com.apple.apps.content-language.table.filter-set` | `FilterSet` | TableModel | object | 1.0 | `is_enabled`, `combine_mode`, `filters` |
| `com.apple.apps.content-language.table.pivot-rules` | `PivotRules` | TableModel | object | 1.0 |  |
| `com.apple.apps.content-language.table.predicate.reference` | `PredicateReference` | TableModel | object | 1.0 | `row_identifier`, `column_identifier`, `is_row_absolute`, `is_column_absolute`, `table_identifier` |
| `com.apple.apps.content-language.table.predicate.value` | `PredicateValue` | TableModel | union | 1.0 | `date`, `duration`, `number`, `reference`, `text` |
| `com.apple.apps.content-language.table.predicate` | `TablePredicate` | TableModel | object | 1.0 | `predicate_type`, `value1`, `value2`, `qualifier`, `date_qualifier1`, `date_qualifier2`, `duration_unit1`, `duration_unit2`, `value_list` |
| `com.apple.apps.content-language.table.row.group-label` | `RowGroupLabel` | TableModel | object | 1.0 | `grouping_column_identifier`, `group_value`, `is_collapsed`, `nesting_level` |
| `com.apple.apps.content-language.table.row.kind` | `RowKind` | TableModel | union | 1.0 | `body`, `grand_total`, `group_label`, `group_subtotal` |
| `com.apple.apps.content-language.table.row` | `TableRow` | TableModel | object | 1.0 | `row_index`, `row_identifier`, `row_height`, `cell_properties`, `text_properties`, `cells`, `visibility_state`, `kind` |
| `com.apple.apps.content-language.table.sort.rule` | `SortRule` | TableModel | object | 1.0 | `column_identifier`, `direction` |
| `com.apple.apps.content-language.table.sort` | `TableSort` | TableModel | object | 1.0 | `scope`, `rules` |
| `com.apple.apps.content-language.table.transformation-info.structure` | `TransformationStructure` | TableModel | union | 1.0 | `categorized`, `pivot` |
| `com.apple.apps.content-language.table.transformation-info` | `TransformationInfo` | TableModel | object | 1.0 | `base_table`, `structure`, `filter_set`, `sort` |
| `com.apple.apps.content-language.table.visual-properties.body-stroke-properties` | `BodyStrokeProperties` | TableModel | object | 1.0 | `horizontal_border_stroke`, `vertical_border_stroke`, `horizontal_stroke`, `vertical_stroke`, `border_strokes_visible`, `horizontal_strokes_visible`, `vertical_strokes_visible` |
| `com.apple.apps.content-language.table.visual-properties.header-footer-stroke-properties` | `HeaderFooterStrokeProperties` | TableModel | object | 1.0 | `border_stroke`, `separator_stroke`, `horizontal_stroke`, `vertical_stroke`, `separator_visible`, `across_strokes_visible` |
| `com.apple.apps.content-language.table.visual-properties.overall-properties` | `OverallProperties` | TableModel | object | 1.0 | `behaves_like_spreadsheet`, `auto_resize`, `writing_direction`, `has_alternating_rows`, `alternating_rows_fill`, `rounded_corners`, `stroke_presets` |
| `com.apple.apps.content-language.table.visual-properties.stroke-preset` | `StrokePreset` | TableModel | object | 1.0 | `horizontal_stroke`, `vertical_stroke`, `exterior_stroke`, `visible_edges` |
| `com.apple.apps.content-language.table.visual-properties` | `TableVisualProperties` | TableModel | object | 1.0 | `overall_properties`, `body_cell_properties`, `body_text_properties`, `body_stroke_properties`, `header_row_cell_properties`, `header_row_text_properties`, `header_row_stroke_properties`, `header_column_cell_properties`, `header_column_text_properties`, `header_column_stroke_properties`, `footer_row_cell_properties`, `footer_row_text_properties`, `footer_row_stroke_properties` |
| `com.apple.apps.content-language.table` | `Table` | TableModel | object | 1.0 | `geometry`, `aspect_ratio_locked`, `description`, `title`, `caption`, `table_name_border_enabled`, `number_of_columns`, `number_of_rows`, `number_of_header_rows`, `number_of_header_columns`, `number_of_footer_rows`, `default_column_width`, `default_row_height`, `visual_properties`, `column_headers`, `content`, `merges`, `conditional_style_sets`, `custom_formats`, `transformation` |
| `com.apple.apps.content-language.text-run` | `TextRun` | TextModel | object | 1.0 | `string`, `style` |
| `com.apple.apps.content-language.text-stroke` | `TextStroke` | Appearance | union | 1.0 | `none`, `stroke` |
| `com.apple.apps.content-language.text` | `TextBody` | TextModel | union | 1.0 | `paragraphs`, `string`, `text_runs` |
| `com.apple.apps.content-language.textbox` | `Textbox` | CanvasModel | object | 1.0 | `geometry`, `aspect_ratio_locked`, `description`, `title`, `title_is_positioned_on_top`, `caption`, `fill`, `stroke`, `opacity`, `shadow`, `reflection`, `layout_properties`, `paragraph_properties`, `text` |
| `com.apple.apps.content-language.title-owning-generic` | `GenericTitleOwning` | CanvasCommon | object | 1.0 | `title` |
| `com.apple.apps.content-language.title-owning` | `TitleOwning` | CanvasCommon | union | 1.0 | `genericTitleOwning` |
| `com.apple.apps.content-language.two-axis-chart` | `TwoAxisChart` | ChartModel | object | 1.0 | `title`, `caption`, `data`, `show_legend`, `legend`, `series`, `chart_colors`, `category_axis`, `value_axis`, `value_axis_secondary`, `geometry`, `aspect_ratio_locked`, `description` |
| `io.github.get-sybers.studio-docs.text-document.section` | `TextSection` | TextDocument | object | 1.0 | `heading`, `text` |
| `io.github.get-sybers.studio-docs.text-document` | `TextDocumentBody` | TextDocument | object | 1.1 | `title`, `stylesheet`, `sections`, `page_size` (1.1) |

## Enumerations

A value outside its list is kept as it was read and written back.

| Swift type | Target | Values |
| --- | --- | --- |
| `AxisScale` | ChartModel | `linear`, `log`, `percent` |
| `Baseline` | TextModel | `default`, `subscript`, `superscript` |
| `Capitalization` | TextModel | `all_caps`, `none`, `small_caps`, `start`, `title` |
| `CellFormatType` | TableModel | `automatic`, `base`, `boolean`, `currency`, `custom`, `date_time`, `duration`, `fraction`, `number`, `percentage`, `scientific`, `text` |
| `ChartDataSource` | ChartModel | `chart_data_grid`, `table_formula_references`, `uninitialized` |
| `ColumnVisibility` | TableModel | `user_hidden`, `visible` |
| `ConditionalStylePreset` | TableModel | `blue_fill`, `blue_text`, `bold`, `custom`, `gray_text`, `green_fill`, `green_text`, `italics`, `orange_fill`, `red_fill`, `red_text`, `teal_fill`, `yellow_fill` |
| `ConnectionLineType` | ChartModel | `curved`, `none`, `straight` |
| `CustomFormatType` | TableModel | `date_time`, `number`, `text` |
| `DateQualifier` | TableModel | `ago`, `days`, `from_now`, `months`, `quarters`, `weeks`, `years` |
| `DurationFormatUnit` | TableModel | `day`, `hour`, `millisecond`, `minute`, `none`, `second`, `week` |
| `DurationStyle` | TableModel | `compact`, `long`, `short` |
| `FillReuseRule` | ChartModel | `series_fill_use_series_stroke`, `symbol_fill_uses_series_fill`, `symbol_fill_uses_series_stroke` |
| `FilterCombination` | TableModel | `and`, `or` |
| `FormatConditionType` | TableModel | `equal`, `greater_than`, `greater_than_or_equal_to`, `less_than`, `less_than_or_equal_to` |
| `FractionAccuracy` | TableModel | `conflicting`, `eighths`, `halves`, `hundredths`, `quarters`, `sixteenths`, `tenths`, `up_to_one_digit`, `up_to_three_digits`, `up_to_two_digits` |
| `ImageFillTechnique` | Appearance | `natural_size`, `scale_to_fill`, `scale_to_fit`, `stretch`, `tile` |
| `Ligatures` | TextModel | `all`, `required`, `standard` |
| `LineEnd` | CanvasCommon | `filled_arrow`, `filled_circle`, `filled_diamond`, `filled_square`, `inverted_arrow`, `line`, `none`, `open_arrow`, `open_circle`, `open_square`, `simple_arrow` |
| `LineSpacingKind` | TextModel | `between`, `exact`, `maximum`, `minimum`, `relative` |
| `LoopOption` | CanvasModel | `back_and_forth`, `none`, `repeating` |
| `MixedSeriesType` | ChartModel | `area`, `column`, `line` |
| `NegativeNumberStyle` | TableModel | `minus`, `none`, `parentheses`, `red`, `red_and_parentheses` |
| `NumberDecoration` | TextModel | `circled`, `decimal`, `double_paren`, `paren`, `standard` |
| `NumberingSystem` | TextModel | `alpha`, `arabian`, `arabian_abjad`, `arabian_alpha`, `hebrew`, `hebrew_biblical`, `hiragana`, `hiragana_iroha`, `japanese`, `katakana`, `katakana_iroha`, `korean`, `numeric`, `roman`, `simplified_chinese`, `traditional_chinese` |
| `ParagraphAlignment` | TextModel | `center`, `justified`, `left`, `natural`, `right` |
| `ParagraphBreak` | TextModel | `column`, `none`, `nontopic`, `page`, `para`, `section` |
| `PictureFrameName` | Appearance | `antique`, `crayon_line`, `formal_inset`, `formal_shadow`, `graph_paper`, `headlines`, `jet_set`, `photo_portfolio1`, `portfolio_inset`, `pushpin`, `renaissance1`, `scrapbook2b`, `storyboard`, `vintage_inset` |
| `PlaceholderKind` | PresentationModel | `body`, `object`, `slide_number`, `title` |
| `PlotDirection` | ChartModel | `columns_as_series`, `rows_as_series` |
| `PredicateDurationUnit` | TableModel | `day`, `hour`, `millisecond`, `minute`, `second`, `week` |
| `PredicateType` | TableModel | `date_after_relative`, `date_before_relative`, `date_between_relative`, `date_in_this`, `date_is_after`, `date_is_before`, `date_is_between`, `date_is_exactly`, `date_is_in_the_last`, `date_is_in_the_next`, `date_is_the_date`, `date_is_today`, `date_is_tomorrow`, `date_is_yesterday`, `distincts`, `duplicates`, `duration_above_average`, `duration_below_average`, `duration_bottom`, `duration_is_between`, `duration_is_equal`, `duration_is_greater_than`, `duration_is_greater_than_or_equal`, `duration_is_less_than`, `duration_is_less_than_or_equal`, `duration_is_not_between`, `duration_is_not_equal`, `duration_top`, `formula`, `in_list`, `is_blank`, `is_checked`, `is_false`, `is_negative`, `is_not_blank`, `is_not_checked`, `is_positive`, `is_true`, `not_in_list`, `pivot_source_filtered_for_column`, `pivot_source_filtered_for_row`, `text_begins_with`, `text_contains`, `text_does_not_contain`, `text_ends_with`, `text_is`, `text_is_not`, `text_not_ends_with`, `text_not_starts_with`, `uniques`, `value_above_average`, `value_below_average`, `value_between`, `value_bottom`, `value_equal`, `value_greater_than`, `value_greater_than_or_equal`, `value_less_than`, `value_less_than_or_equal`, `value_not_between`, `value_not_equal`, `value_top` |
| `RGBColorSpace` | Appearance | `p3`, `srgb` |
| `RowVisibility` | TableModel | `filtered`, `user_hidden`, `visible` |
| `SeriesSymbolType` | ChartModel | `circle`, `diamond`, `none`, `plus`, `square`, `triangle`, `x`, `yield` |
| `SeriesValueLabelPosition` | ChartModel | `auto`, `bottom`, `bottom_left`, `bottom_right`, `center`, `inside`, `inside_bottom`, `inside_left`, `inside_right`, `inside_top`, `left`, `outside`, `outside_top`, `right`, `top`, `top_left`, `top_right` |
| `SortDirection` | TableModel | `ascending`, `descending` |
| `SortScope` | TableModel | `entire_table`, `selected_rows` |
| `SourceKind` | PresentationModel | `layout`, `placeholder`, `user` |
| `StrikethroughStyle` | TextModel | `double`, `none`, `single` |
| `StrokeEdge` | TableModel | `bottom`, `horizontal`, `left`, `right`, `top`, `vertical` |
| `StrokePattern` | Appearance | `calligraphy`, `chalk`, `dry_brush`, `feathered_brush`, `long_dash`, `medium_dash`, `pen`, `round_dash`, `short_dash`, `solid` |
| `TabAlignment` | TextModel | `center`, `decimal`, `left`, `right` |
| `TextQualifier` | TableModel | `case_insensitive`, `case_sensitive` |
| `UnderlineStyle` | TextModel | `double`, `none`, `single`, `wavy` |
| `ValueLabelsSelection` | ChartModel | `none`, `size`, `x`, `x_and_y`, `y` |
| `VerticalTextAlignment` | TextModel | `bottom`, `center`, `top` |
| `WritingDirection` | TextModel | `left_to_right`, `natural`, `right_to_left` |
