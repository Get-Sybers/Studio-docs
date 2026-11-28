# DocumentIdentifiers

An index of object identifiers and a mint.

## What it provides

Indexes every object identifier in a document tree, so an object is reached by its identifier, and mints
new identifiers that do not collide with those a document already holds. A consumer that adds an object to a
document draws its identifier from the mint.

## Principal API

- `IdentifierIndex` — every object identifier of a tree, for lookup.
- `IdentifierMint` — new identifiers that do not repeat one already in use.

## Resources

None.

## Depends on

`JSONTree`, `WireFormat`, HashTreeCollections. A product module of `StudioDocs`.
