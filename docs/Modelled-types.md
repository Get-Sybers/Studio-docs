# Modelled types

`make generate` writes this file from the format tables, `Sources/<Target>/Resources/format.json`.
It lists every type of the format that the library models, with the latest version of the type
that the library models and the members or cases it reads. A member or a case that a later
version than 1.0 introduced shows that version in brackets.

| Type identifier | Swift type | Target | Kind | Version | Members or cases |
| --- | --- | --- | --- | --- | --- |
| `com.apple.apps.content-language.character-properties.font-features-type` | `FontFeature` | TextModel | object | 1.0 | `feature`, `selector` |
| `com.apple.apps.content-language.character-properties` | `CharacterProperties` | TextModel | object | 1.0 | `background_color`, `baseline`, `baseline_shift`, `bold`, `capitalization`, `character_fill`, `character_fill_should_fill_container`, `compatibility_font_name`, `emphasis_mark`, `font_features`, `font_name`, `font_size`, `is_named_point_size`, `italic`, `language`, `ligatures`, `shadow`, `strikethrough`, `strikethrough_color`, `strikethrough_width`, `stroke`, `tracking`, `underline`, `underline_color`, `word_strikethrough`, `word_underline`, `writing_direction` |
| `com.apple.apps.content-language.color.rgba` | `RGBAColor` | Appearance | object | 1.1 | `red`, `green`, `blue`, `alpha`, `color_space`, `headroom` (1.1) |
| `com.apple.apps.content-language.color` | `ColorValue` | Appearance | union | 1.0 | `rgba` |
| `com.apple.apps.content-language.column-metrics.equal-columns-description` | `EqualColumns` | TextModel | object | 1.0 | `count`, `gutter_width` |
| `com.apple.apps.content-language.column-metrics.unequal-columns-description` | `UnequalColumns` | TextModel | object | 1.0 | `column_widths`, `gutter_widths` |
| `com.apple.apps.content-language.column-metrics` | `ColumnMetrics` | TextModel | union | 1.0 | `equal`, `single`, `unequal` |
| `com.apple.apps.content-language.contact-shadow` | `ContactShadow` | Appearance | object | 1.0 | `opacity`, `color`, `offset`, `radius`, `height` |
| `com.apple.apps.content-language.curved-shadow` | `CurvedShadow` | Appearance | object | 1.0 | `angle`, `opacity`, `color`, `offset`, `radius`, `curve` |
| `com.apple.apps.content-language.drop-shadow` | `DropShadow` | Appearance | object | 1.0 | `angle`, `opacity`, `color`, `offset`, `radius` |
| `com.apple.apps.content-language.fill.gradient.flavor.linear` | `LinearFlavor` | Appearance | object | 1.1 | `angle`, `start_point` (1.1), `end_point` (1.1), `base_natural_size` (1.1) |
| `com.apple.apps.content-language.fill.gradient.flavor.radial` | `RadialFlavor` | Appearance | object | 1.0 | `start_point`, `end_point`, `base_natural_size` |
| `com.apple.apps.content-language.fill.gradient.flavor` | `GradientFlavor` | Appearance | union | 1.0 | `linear`, `radial` |
| `com.apple.apps.content-language.fill.gradient.stop` | `GradientStop` | Appearance | object | 1.0 | `color`, `fraction`, `inflection` |
| `com.apple.apps.content-language.fill.gradient` | `GradientFill` | Appearance | object | 1.1 | `is_advanced` (1.1), `stops`, `opacity`, `flavor` |
| `com.apple.apps.content-language.fill.image-fill` | `ImageFill` | Appearance | object | 1.0 | `resource`, `technique`, `scale_percent`, `tint_color` |
| `com.apple.apps.content-language.fill` | `Fill` | Appearance | union | 1.0 | `color`, `gradient`, `image` |
| `com.apple.apps.content-language.hyperlink.slide-target` | `SlideTarget` | TextModel | union | 1.0 | `by_identifier`, `first`, `last`, `last_viewed`, `next`, `previous` |
| `com.apple.apps.content-language.hyperlink` | `Hyperlink` | TextModel | union | 1.0 | `file`, `program`, `slide_jump`, `url` |
| `com.apple.apps.content-language.insets` | `Insets` | Appearance | object | 1.0 | `top`, `bottom`, `left`, `right` |
| `com.apple.apps.content-language.layout-properties` | `TextLayoutProperties` | TextModel | object | 1.0 | `columns`, `continuous`, `margins`, `padding`, `shrink_to_fit`, `vertical_alignment`, `vertical_text`, `writing_direction` |
| `com.apple.apps.content-language.line-spacing-type` | `LineSpacing` | TextModel | object | 1.0 | `kind`, `value` |
| `com.apple.apps.content-language.list-label-type.list-image-label` | `ListImageLabel` | TextModel | object | 1.0 | `scale`, `offset`, `resource` |
| `com.apple.apps.content-language.list-label-type.list-number-label` | `ListNumberLabel` | TextModel | object | 1.0 | `number_format`, `scale`, `tiered` |
| `com.apple.apps.content-language.list-label-type.list-string-label` | `ListStringLabel` | TextModel | object | 1.0 | `string`, `scale`, `offset` |
| `com.apple.apps.content-language.list-label-type` | `ListLabel` | TextModel | union | 1.0 | `image`, `none`, `null_image`, `number`, `string` |
| `com.apple.apps.content-language.list-level-type` | `ListLevel` | TextModel | object | 1.0 | `label_indent`, `text_indent`, `label` |
| `com.apple.apps.content-language.list-properties` | `ListProperties` | TextModel | object | 1.0 | `font_color`, `font_name`, `writing_direction`, `shadow`, `levels` |
| `com.apple.apps.content-language.number-format-type` | `ListNumberFormat` | TextModel | object | 1.0 | `kind`, `upper`, `formal`, `format` |
| `com.apple.apps.content-language.offset` | `OffsetValue` | Appearance | object | 1.0 | `dx`, `dy` |
| `com.apple.apps.content-language.paragraph-properties.border-style-type` | `ParagraphBorders` | TextModel | object | 1.0 | `stroke`, `width`, `offset`, `rounded`, `no_borders`, `all_borders`, `before`, `after`, `leading`, `trailing` |
| `com.apple.apps.content-language.paragraph-properties` | `ParagraphProperties` | TextModel | object | 1.0 | `alignment`, `decimal_tab`, `default_tabs`, `fill`, `first_line_indent`, `following_style`, `hyphenate`, `list_style`, `keep_lines_together`, `keep_with_next`, `left_indent`, `line_spacing`, `outline_level`, `start_on_new_page`, `borders`, `right_indent`, `space_after`, `space_before`, `tabs`, `prevent_widow`, `show_in_bookmarks`, `show_in_tocnavigator`, `character_properties` |
| `com.apple.apps.content-language.paragraph.constituent` | `ParagraphContent` | TextModel | union | 1.0 | `hyperlink`, `inline_object`, `run` |
| `com.apple.apps.content-language.paragraph.hyperlink-field` | `HyperlinkField` | TextModel | object | 1.0 | `target`, `run` |
| `com.apple.apps.content-language.paragraph` | `Paragraph` | TextModel | object | 1.0 | `style`, `list_style`, `list_start`, `list_level`, `writing_direction`, `contents`, `break_type` |
| `com.apple.apps.content-language.position` | `PositionValue` | Appearance | object | 1.0 | `x`, `y` |
| `com.apple.apps.content-language.resource.base64-encoded-resource` | `EmbeddedResource` | ResourceReferences | object | 2.0 | `string`, `filename`, `premium_resource_info` (2.0) |
| `com.apple.apps.content-language.resource.indirect-resource` | `IndirectResource` | ResourceReferences | object | 2.0 | `identifier`, `filename`, `premium_resource_info` (2.0) |
| `com.apple.apps.content-language.resource.premium-resource-info` | `PremiumResourceInfo` | ResourceReferences | object | 1.0 | `asset_uuid`, `is_derived_asset`, `may_need_watermark` |
| `com.apple.apps.content-language.resource` | `ResourceReference` | ResourceReferences | union | 1.0 | `base64_encoded`, `indirect` |
| `com.apple.apps.content-language.shadow` | `Shadow` | Appearance | union | 1.1 | `contactShadow`, `curvedShadow`, `dropShadow`, `none` (1.1) |
| `com.apple.apps.content-language.size` | `SizeValue` | Appearance | object | 1.0 | `width`, `height` |
| `com.apple.apps.content-language.stroke.frame` | `PictureFrame` | Appearance | object | 1.0 | `name`, `scale_percent` |
| `com.apple.apps.content-language.stroke.line` | `LineStroke` | Appearance | object | 1.0 | `color`, `width`, `pattern` |
| `com.apple.apps.content-language.stroke` | `Stroke` | Appearance | union | 1.0 | `empty`, `frame`, `line` |
| `com.apple.apps.content-language.stylesheet.character-style` | `NamedCharacterStyle` | TextModel | object | 1.0 | `name`, `properties` |
| `com.apple.apps.content-language.stylesheet.list-style` | `NamedListStyle` | TextModel | object | 1.0 | `name`, `properties` |
| `com.apple.apps.content-language.stylesheet.paragraph-style` | `NamedParagraphStyle` | TextModel | object | 1.0 | `name`, `properties` |
| `com.apple.apps.content-language.stylesheet` | `Stylesheet` | TextModel | object | 1.0 | `character_styles`, `paragraph_styles`, `list_styles` |
| `com.apple.apps.content-language.tab-stop-type` | `TabStop` | TextModel | object | 1.0 | `position`, `kind`, `leader` |
| `com.apple.apps.content-language.text-run` | `TextRun` | TextModel | object | 1.0 | `string`, `style` |
| `com.apple.apps.content-language.text-stroke` | `TextStroke` | Appearance | union | 1.0 | `none`, `stroke` |
| `com.apple.apps.content-language.text` | `TextBody` | TextModel | union | 1.0 | `paragraphs`, `string`, `text_runs` |

## Enumerations

A value outside its list is kept as it was read and written back.

| Swift type | Target | Values |
| --- | --- | --- |
| `Baseline` | TextModel | `default`, `subscript`, `superscript` |
| `Capitalization` | TextModel | `all_caps`, `none`, `small_caps`, `start`, `title` |
| `ImageFillTechnique` | Appearance | `natural_size`, `scale_to_fill`, `scale_to_fit`, `stretch`, `tile` |
| `Ligatures` | TextModel | `all`, `required`, `standard` |
| `LineSpacingKind` | TextModel | `between`, `exact`, `maximum`, `minimum`, `relative` |
| `NumberDecoration` | TextModel | `circled`, `decimal`, `double_paren`, `paren`, `standard` |
| `NumberingSystem` | TextModel | `alpha`, `arabian`, `arabian_abjad`, `arabian_alpha`, `hebrew`, `hebrew_biblical`, `hiragana`, `hiragana_iroha`, `japanese`, `katakana`, `katakana_iroha`, `korean`, `numeric`, `roman`, `simplified_chinese`, `traditional_chinese` |
| `ParagraphAlignment` | TextModel | `center`, `justified`, `left`, `natural`, `right` |
| `ParagraphBreak` | TextModel | `column`, `none`, `nontopic`, `page`, `para`, `section` |
| `PictureFrameName` | Appearance | `antique`, `crayon_line`, `formal_inset`, `formal_shadow`, `graph_paper`, `headlines`, `jet_set`, `photo_portfolio1`, `portfolio_inset`, `pushpin`, `renaissance1`, `scrapbook2b`, `storyboard`, `vintage_inset` |
| `RGBColorSpace` | Appearance | `p3`, `srgb` |
| `StrikethroughStyle` | TextModel | `double`, `none`, `single` |
| `StrokePattern` | Appearance | `calligraphy`, `chalk`, `dry_brush`, `feathered_brush`, `long_dash`, `medium_dash`, `pen`, `round_dash`, `short_dash`, `solid` |
| `TabAlignment` | TextModel | `center`, `decimal`, `left`, `right` |
| `UnderlineStyle` | TextModel | `double`, `none`, `single`, `wavy` |
| `VerticalTextAlignment` | TextModel | `bottom`, `center`, `top` |
| `WritingDirection` | TextModel | `left_to_right`, `natural`, `right_to_left` |
