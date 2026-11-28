# GoldenFiles

The expected outputs of a test target, one file for each.

## What it provides

Reads and writes the golden file of a test target: the expected output a test compares with, a map from a
case name to its text. `UPDATE_GOLDENS=1 make test` rewrites it from what the tests produce. This target
supports the tests; no consumer imports it.

## Principal API

- `GoldenFile` — a golden file, read and rewritten.
- `GoldenError` — a malformed golden file.

## Resources

None.

## Depends on

Nothing. Not in the `StudioDocs` product; it supports the tests.
