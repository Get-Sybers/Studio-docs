# Changelog

All notable changes to this package are recorded in this file. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and the package follows
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- The targets `RawDeflate` and `ZipArchives`: a reader and a writer of ZIP archives over the system's
  zlib. The reader refuses names that leave the archive, repeated names, entries that share bytes, and
  sizes and ratios beyond its limits.
- The target `GoldenFiles`, which the tests share: one file of expected outputs for each test target.
- The gate `make tidy conform`, the structural lint `scripts/structure-lint.sh`, and the workflow
  `Swift CI`.
