# Modelled types

`make generate` writes this file from the format tables, `Sources/<Target>/Resources/format.json`.
It lists every type of the format that the library models, with the latest version of the type
that the library models and the members or cases it reads. A member or a case that a later
version than 1.0 introduced shows that version in brackets.

| Type identifier | Swift type | Target | Kind | Version | Members or cases |
| --- | --- | --- | --- | --- | --- |
| `com.apple.apps.content-language.color.rgba` | `RGBAColor` | Appearance | object | 1.1 | `red`, `green`, `blue`, `alpha`, `color_space`, `headroom` (1.1) |
| `com.apple.apps.content-language.color` | `ColorValue` | Appearance | union | 1.0 | `rgba` |
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
| `com.apple.apps.content-language.insets` | `Insets` | Appearance | object | 1.0 | `top`, `bottom`, `left`, `right` |
| `com.apple.apps.content-language.offset` | `OffsetValue` | Appearance | object | 1.0 | `dx`, `dy` |
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
| `com.apple.apps.content-language.text-stroke` | `TextStroke` | Appearance | union | 1.0 | `none`, `stroke` |

## Enumerations

A value outside its list is kept as it was read and written back.

| Swift type | Target | Values |
| --- | --- | --- |
| `ImageFillTechnique` | Appearance | `natural_size`, `scale_to_fill`, `scale_to_fit`, `stretch`, `tile` |
| `PictureFrameName` | Appearance | `antique`, `crayon_line`, `formal_inset`, `formal_shadow`, `graph_paper`, `headlines`, `jet_set`, `photo_portfolio1`, `portfolio_inset`, `pushpin`, `renaissance1`, `scrapbook2b`, `storyboard`, `vintage_inset` |
| `RGBColorSpace` | Appearance | `p3`, `srgb` |
| `StrokePattern` | Appearance | `calligraphy`, `chalk`, `dry_brush`, `feathered_brush`, `long_dash`, `medium_dash`, `pen`, `round_dash`, `short_dash`, `solid` |
