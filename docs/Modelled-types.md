# Modelled types

`make generate` writes this file from the format tables, `Sources/<Target>/Resources/format.json`.
It lists every type of the format that the library models, with the latest version of the type
that the library models and the members or cases it reads. A member or a case that a later
version than 1.0 introduced shows that version in brackets.

| Type identifier | Swift type | Target | Kind | Version | Members or cases |
| --- | --- | --- | --- | --- | --- |
| `com.apple.apps.content-language.resource.base64-encoded-resource` | `EmbeddedResource` | ResourceReferences | object | 2.0 | `string`, `filename`, `premium_resource_info` (2.0) |
| `com.apple.apps.content-language.resource.indirect-resource` | `IndirectResource` | ResourceReferences | object | 2.0 | `identifier`, `filename`, `premium_resource_info` (2.0) |
| `com.apple.apps.content-language.resource.premium-resource-info` | `PremiumResourceInfo` | ResourceReferences | object | 1.0 | `asset_uuid`, `is_derived_asset`, `may_need_watermark` |
| `com.apple.apps.content-language.resource` | `ResourceReference` | ResourceReferences | union | 1.0 | `base64_encoded`, `indirect` |

## Enumerations

A value outside its list is kept as it was read and written back.

| Swift type | Target | Values |
| --- | --- | --- |
