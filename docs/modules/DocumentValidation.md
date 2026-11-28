# DocumentValidation

Typed findings and the checks that make them.

## What it provides

Checks a document against the format and the library's own rules and returns typed findings. A finding is
an error or a warning, and it carries the part of the package and the path it concerns. A document with an
error is refused on save unless the write options say otherwise, so a consumer sees why a document is
rejected rather than a bare failure.

## Principal API

- `DocumentValidator` — runs the checks over a document and gathers the findings.
- `ValidationFinding` — one finding: its kind, its part and its path.
- `ValidationReport` — the findings of a document.
- `ValidationInput` — what a check reads.
- `FindingKind` — an error or a warning.

## Resources

None.

## Depends on

`Appearance`, `DocumentIdentifiers`, `JSONTree`, `PresetStyles`, `ResourceReferences`, `TextModel`,
`WireFormat`. A product module of `StudioDocs`.
