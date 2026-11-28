# RawDeflate

Raw DEFLATE streams over the system's zlib: the one target with C, a system library and unsafe pointers.

## What it provides

Compression and decompression of raw DEFLATE data over the system zlib, and the cyclic redundancy check
that a ZIP entry records. By the rule that C, system libraries and unsafe pointers stay in one place, this
target holds all of them for the package, so every other target is memory-safe Swift. `ZipArchives` builds
its compression on it.

## Principal API

- `DeflateStream` — compresses a buffer to a raw DEFLATE stream and inflates one back.
- `CyclicRedundancyCheck` — the CRC-32 of a run of bytes.
- `DeflateError` — a failure of the stream.

## Resources

None.

## Depends on

The system zlib. Not in the `StudioDocs` product.
