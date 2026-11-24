# Modelled types

`make generate` writes this file from the format tables, `Sources/<Target>/Resources/format.json`.
It lists every type of the format that the library models, with the latest version of the type
that the library models and the members or cases it reads. A member or a case that a later
version than 1.0 introduced shows that version in brackets.

| Type identifier | Swift type | Target | Kind | Version | Members or cases |
| --- | --- | --- | --- | --- | --- |

## Enumerations

A value outside its list is kept as it was read and written back.

| Swift type | Target | Values |
| --- | --- | --- |
