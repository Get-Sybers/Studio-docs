# Changelog

All notable changes to this package are recorded in this file. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and the package follows
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- The targets `RawDeflate` and `ZipArchives`: a reader and a writer of ZIP archives over the system's
  zlib. The reader refuses names that leave the archive, repeated names, entries that share bytes, and
  sizes and ratios beyond its limits.
- The target `JSONTree`: a JSON value tree that reads and writes through Foundation's coders, keeps
  whole numbers exact, and treats the order of an object's members as without meaning.
- The target `WireFormat`: type identifiers, versions, the envelope of an object, tagged unions, the
  three states of an inheritable member, and readers and writers that keep every member a type does
  not model. A client adds members of its own to a type of the library with `ClientProperty`.
- The target `ModelFixtures`, which the tests share: the fixtures of a test target, and the checks that a
  type reads and writes every member that its format table lists.
- The target `ResourceReferences`: the resource union, the indirect and the embedded resource, and the
  marks of a premium resource, with the format table that states their members.
- The target `Appearance`: colours, fills, gradients, image fills, shadows, strokes and the small
  geometric values they use.
- The target `GoldenFiles`, which the tests share: one file of expected outputs for each test target.
- The gate `make tidy conform`, the structural lint `scripts/structure-lint.sh`, and the workflow
  `Swift CI`.
