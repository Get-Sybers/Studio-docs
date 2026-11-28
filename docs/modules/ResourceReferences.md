# ResourceReferences

The resource union, indirect and embedded resources, and premium marks.

## What it provides

Models how an object points at a resource: an indirect resource, named by a file in the package's `Data`
folder, or a resource embedded in the tree. A `ResourceReference` is the union of the two, and a premium
resource carries its mark.

## Principal API

- `ResourceReference` — the union of an indirect and an embedded resource.
- `IndirectResource` — a resource named by a file in `Data`.
- `EmbeddedResource` — a resource carried in the tree.
- `PremiumResourceInfo` — the mark of a premium resource.
- `ResourceFormat` — the format table of this target.
- `ResourceDataError` — a malformed reference.

## Resources

`Resources/format.json`, the format table of the resource types.

## Depends on

`JSONTree`, `WireFormat`. A product module of `StudioDocs`.
