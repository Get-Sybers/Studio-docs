# Conformance

A change is ready when `make tidy conform` is green. CI runs the same command.

## The gates

The package has three gates, each running its targets in order and stopping at the first failure. `make
lint` and the structural lint do not compile. `make check` is the local gate before a pull request leaves
draft. `make conform` is the full gate that the release workflow runs, by hand and at a release.

| Gate | Runs | For |
| --- | --- | --- |
| `lint` | `fmt-check`, then the structural lint | the checks that do not compile |
| `check` | `fmt-check`, `generate`, `test-critical`, then the structural lint | a pull request about to leave draft |
| `conform` | `fmt-check`, `vet`, `test`, `generate`, `platforms`, `test-ios`, then the structural lint | the release workflow, by hand and at a release |

`conform` needs macOS with the Xcode that `.xcode-version` names, the iOS, tvOS, visionOS and watchOS
platforms of that Xcode, and the iOS simulator that `SIMULATOR` names, `iPhone 17` unless it is set.
`check` builds the whole package, so a compile error in any target fails it, and then runs the critical
tests; nothing on a pull request compiles.

| Target | Runs | Catches |
| --- | --- | --- |
| `fmt-check` | `swift format lint --strict` over `Package.swift`, `Sources`, `Tests` and `scripts` | unformatted Swift |
| `vet` | `swift build --build-tests` | a broken build; every target treats a warning as an error |
| `test` | `swift test --parallel` | failing tests |
| `test-critical` | `swift test --parallel --filter "$(CRITICAL)"` | a failing critical test; its build is the whole package |
| `generate` | `scripts/generate-modelled-types.swift`, then `git diff --exit-code` on its output | a list of modelled types that differs from the format tables |
| `platforms` | `xcodebuild build` for a generic iOS, tvOS, visionOS and watchOS device | a build that breaks or warns on one of those platforms |
| `test-ios` | `xcodebuild build-for-testing`, then `test-without-building`, on that simulator at the newest iOS of the Xcode | failing tests on iOS |
| the structural lint | `scripts/structure-lint.sh` | the structural rules below |

The critical targets that `check` runs, which `CRITICAL` names in the `Makefile`, are `RawDeflateTests`,
`ZipArchivesTests`, `JSONTreeTests`, `WireFormatTests`, `DocumentPackageTests`, `DocumentValidationTests`
and `TextModelTests`: the layer whose breakage corrupts a document. The rest run in `test`, inside
`conform`.

| Target | Does |
| --- | --- |
| `build` | builds the package |
| `fmt` | formats the package in place |
| `lint` | the format lint and the structural lint |
| `tidy` | runs `swift package resolve` and fails when `Package.resolved` changes |
| `upgrade` | runs `swift package update`, then `conform`; when `conform` fails it restores `Package.resolved` |

`RESOLVE=--disable-automatic-resolution` makes the build use the committed versions and nothing else. CI
passes it. `platforms` and `test-ios` hand it to `xcodebuild` as `-disableAutomaticPackageResolution`, and
`xcodebuild` keeps its build in `.build/xcode`.

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

`.github/workflows/swift-ci.yml` runs on pull requests, in a merge queue, on pushes to `main` and on
demand, with read-only permissions. Nothing it runs compiles, so it needs no macOS and no toolchain.

| Job | Runs on | Does |
| --- | --- | --- |
| `lint` | `ubuntu-24.04` | `sh scripts/structure-lint.sh`: the structural rules and that every JSON file parses |
| `changelog` | `ubuntu-24.04` | on a pull request, fails unless `CHANGELOG.md` changed |
| `CI OK` | `ubuntu-24.04` | fails when a job above ended as anything but success or skipped; the one check to require |

The full gate — the build, the tests and the platform builds — is in the release workflow, which runs it
by hand and at a release, never on a pull request. Dependabot raises the GitHub Actions pins and the Swift
packages weekly, seven days after a release, each group in one pull request.

## Release

`.github/workflows/release.yml` runs by hand. A pull request cuts the version first: it
moves the entries under `## [Unreleased]` to `## [x.y.z] - date` in `CHANGELOG.md`. Then the workflow runs
on `main` with `publish` set. The version is never an input.

| Job | Runs on | Does |
| --- | --- | --- |
| `gate` | `xcode-27` | reads the newest version `CHANGELOG.md` names, refuses one whose tag exists, runs `make tidy conform RESOLVE=--disable-automatic-resolution`, and keeps the section of that version as the release notes, in the run artifact `Studio-docs-v<version>` |
| `publish` | `ubuntu-24.04` | with `publish` set, in the environment `release`: creates the tag `<version>` and the GitHub release `Studio-docs v<version>` with those notes; it runs no code of the repository |

Without `publish` the workflow runs the gate alone and resolves the version 0.0.0, which is no release.

## Rules on GitHub

The ruleset `protect-main` applies to the default branch: nobody deletes or force-pushes it, every commit on it
carries a verified signature, and a change reaches it through a pull request, merged by merge commit, squash
or rebase, once the status check `CI OK` has passed. A commit made through GitHub's API or web editor is signed
by GitHub and passes; a commit pushed from a machine without a signing key does not.

The environment `release` has the owner as its required reviewer and `main` as its only branch; the job
`publish` runs in it.
