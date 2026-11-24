# Modelled types

`make generate` writes this file from the format tables, `Sources/<Target>/Resources/format.json`.
It lists every type of the format that the library models, with the version of the type that
the library writes and the members or cases it reads. A member or a case that a later version
than 1.0 introduced shows that version in brackets.

| Type identifier | Swift type | Target | Kind | Version | Members or cases |
| --- | --- | --- | --- | --- | --- |
