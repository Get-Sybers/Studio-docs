# Conformance

A change is ready when `make tidy conform` is green. CI runs the same command.

## The gate

`make conform` runs these targets in order and stops at the first failure. It needs macOS with the Xcode
that `.xcode-version` names.

| Target | Runs | Catches |
| --- | --- | --- |
| `fmt-check` | `swift format lint --strict` over `Package.swift`, `Sources`, `Tests` and `scripts` | unformatted Swift |
| `vet` | `swift build --build-tests` | a broken build; every target treats a warning as an error |
| `test` | `swift test --parallel` | failing tests |
| `generate` | `scripts/generate-modelled-types.swift`, then `git diff --exit-code` on its output | a list of modelled types that differs from the format tables |
| `conform` | the four above, then `scripts/structure-lint.sh` | the structural rules below |

| Target | Does |
| --- | --- |
| `build` | builds the package |
| `fmt` | formats the package in place |
| `tidy` | runs `swift package resolve` and fails when `Package.resolved` changes |
| `upgrade` | runs `swift package update`, then `conform`; when `conform` fails it restores `Package.resolved` |

`RESOLVE=--disable-automatic-resolution` makes the build use the committed versions and nothing else. CI
passes it.

A test compares what it produced with the goldens of its target, the file `testdata/<name>.goldens.json`.
`UPDATE_GOLDENS=1 make test` writes what the tests produce into those files in the source tree.

## Structural lint

`scripts/structure-lint.sh` reads the file list from `git ls-files` and checks that:

- `LICENSE`, `NOTICE`, `README.md`, `CHANGELOG.md`, `AGENTS.md`, `.gitignore`, `.swift-format`,
  `.xcode-version`, `Makefile`, `Package.swift` and `Package.resolved` exist;
- `LICENSE` is the Apache License 2.0 and `README.md` declares the same identifier;
- the changelog has `## [Unreleased]`;
- no tracking marker stands in a tracked file;
- `README.md`, `AGENTS.md` and `docs/*.md` hold no plan or status wording and no tick boxes, outside
  fenced blocks and code spans;
- no run of more than three full-line comments stands in Swift, shell, YAML or the `Makefile`;
- no manifest names a package beside the repository with `path: "../`;
- no Swift function has a `get` prefix;
- a Swift file under `Sources/` declares one type that another file can name, and has its name, or
  only extends one type and is named `Type+Concern.swift`;
- no two tracked files are identical;
- every tracked JSON file parses.

Paths under a `testdata` directory are exempt from the checks on markers, comments and identical files.

## Version pins

| Pin | Lives in |
| --- | --- |
| Xcode, with its Swift toolchain and `swift-format` | `.xcode-version` |
| Swift packages | `Package.swift` and `Package.resolved` |
| GitHub Actions | the commit SHA and version comment on each `uses:` line |

## CI

`.github/workflows/swift-ci.yml` runs on pull requests, in a merge queue, on pushes to `main`, on demand
and every night, with read-only permissions.

| Job | Runs on | Does |
| --- | --- | --- |
| `changes` | `ubuntu-24.04` | lists the files that differ from the base commit and decides whether the build is needed; without a base commit it is |
| `changelog` | `ubuntu-24.04` | on a pull request, fails unless `CHANGELOG.md` changed |
| `build-test` | `xcode-27` | when the build is needed: `make tidy conform RESOLVE=--disable-automatic-resolution` |
| `CI OK` | `ubuntu-24.04` | fails when a job above ended as anything but success or skipped; the one check to require |

A change to the documents alone starts no macOS job. Dependabot raises the GitHub Actions pins weekly,
seven days after a release.
