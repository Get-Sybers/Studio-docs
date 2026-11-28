# ZipArchives

A ZIP reader and writer, with limits against hostile archives.

## What it provides

Reads a ZIP archive into named entries and writes entries back to one, Zip64 included, over the DEFLATE of
`RawDeflate`. Bounds guard against a hostile archive: an entry that inflates far beyond its stored size, a
name that climbs out of the tree, and a count or a total beyond a set limit are each refused rather than
trusted.

## Principal API

- `ZipReader` — reads an archive into its entries.
- `ZipWriter` — writes entries into an archive.
- `ZipEntry`, `ZipEntryName` — an entry and its checked name.
- `ZipCompression` — stored or deflated.
- `ZipLimits`, `Zip64Threshold` — the bounds a read and a write hold to.
- `ZipError` — a malformed or oversized archive.

## Resources

None.

## Depends on

`RawDeflate`, OrderedCollections. A product module of `StudioDocs`.
