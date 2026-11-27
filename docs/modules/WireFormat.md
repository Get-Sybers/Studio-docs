# WireFormat

Type identifiers, versions, the envelope, unions, `Inheritable`, `ClientProperty`, readers, writers,
format tables and schema registries.

## What it provides

The wire layer between a JSON tree and a modelled type. A reader checks the type identifier and the version
of an object, hands each modelled member to the type, and keeps every other member in the object's envelope,
so a member the library does not model is written back unchanged. A writer reverses this.

`ClientProperty<Value>` adds a member of a consumer's own to any `WireObject`, read with `value(of:)` and
written with `setValue(_:of:)`; because an unmodelled member is kept in the envelope, such a property
survives a round trip through a reader that knows nothing of it. `Inheritable<Value>` marks a value that an
object takes from what it inherits when it is unset. A `FormatTable` holds the identifiers, versions and
members of a target's types, and a `SchemaRegistry` resolves a union case by its identifier.

## Principal API

- `WireValue`, `WireObject`, `WireUnion`, `WireEnumeration` — the protocols a modelled type conforms to.
- `ObjectEnvelope` — the members of an object, modelled and kept alike.
- `ObjectReader`, `ObjectWriter` — read a type from a tree and write it back.
- `ObjectID` — the identifier of an object.
- `ClientProperty` — a consumer's own member on a `WireObject`.
- `Inheritable` — a value an object inherits when unset.
- `TypeIdentifier`, `FormatVersion` — the identity and the version of a type.
- `FormatTable`, `ObjectSchema`, `UnionSchema`, `SchemaRegistry` — the facts of the format and their lookup.
- `WireError` — a wrong identifier, a later major version, or a malformed object.

## Resources

None; a format table lives in each target that models types.

## Depends on

`JSONTree`, BitCollections. A product module of `StudioDocs`.
