# JSONTree

A JSON value tree through Foundation's coders, whole numbers exact, members in file order.

## What it provides

Parses the bytes of a JSON entry into a value tree and writes the tree back to bytes. A whole number keeps
its exact value rather than passing through a binary floating-point number, and the members of an object
keep the order in which they were read, so a document written back matches the bytes that were read where
nothing changed.

## Principal API

- `JSONValue` — a node of the tree: an object, an array, a string, a number, a boolean or null.
- `JSONObject` — an object whose members keep their file order.
- `JSONNumber` — a number that holds a whole value exactly.
- `JSONPath` — the path to a node, for a reader to report where a value stands.
- `JSONKind`, `JSONStyle` — the kind of a value and how it is written out.
- `JSONTreeError` — a failure to parse or to encode.

## Resources

None.

## Depends on

OrderedCollections. A product module of `StudioDocs`.
