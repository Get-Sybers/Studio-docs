# Contributor guide

These rules bind every contributor, human or agent. `make tidy conform` checks most of them.

## Rules

1. **The gate decides.** A change is ready when `make tidy conform` is green. CI runs the same command.
2. **Every change adds a line to `CHANGELOG.md`** under `## [Unreleased]`. No tracking marker stands in
   code, and no progress note stands in a document.
3. **Documents state present fact.** `README.md`, this file and `docs/` describe what the repository
   does now. The lint rejects plan and status wording and tick boxes.
4. **Comments are few and give a reason.** No comment block is longer than three lines, a documentation
   comment included. Every `public` declaration has a documentation comment.
5. **One type a file.** A file under `Sources/` declares one type and takes its name. A file that only
   extends a type is named `Type+Concern.swift`.
6. **One concern a target.** A target is named for its concern, never for a type it holds. C, system
   libraries and unsafe pointers stay in `RawDeflate`.
7. **Access is narrow.** A declaration is `internal`; `package` shares it between targets; `public` is
   for what a consumer imports. No public signature names a type of Swift Collections.
8. **Reference data is data.** The facts of the format, its type identifiers, versions, defaults and
   limits, live in `Sources/<Target>/Resources/format.json`, never in a Swift literal.
9. **Errors are typed.** Failure is `throws` with an `Error` enum. No force unwrap, no `try!`, no `as!`.
10. **British spelling** in prose and comments. A name that mirrors the format keeps the format's spelling.

## Tests

- Tests use Swift Testing and are table-driven: one `@Test(arguments:)` for each behaviour, each case named.
- Expected output lives in one file for each test target, `Tests/<Target>Tests/testdata/<name>.goldens.json`,
  a map from case name to text. `UPDATE_GOLDENS=1 make test` rewrites it. A second file there may hold fixtures.
- Fixtures hold invented text only.

## A public repository

- The code and every sentence are written for this repository. No text of Apple's documentation and no
  code of Apple's library is copied into it, and no file of Apple's is committed.
- No personal name and no email address stands in a file or in a commit message.
- `NOTICE` credits Apple's documentation and library as the reference for the format.
- Every commit on `main` carries a verified signature. A commit made through GitHub's API or web editor is
  signed by GitHub; one pushed from a machine without a signing key is refused.

## Where things live

| Path | Holds |
| --- | --- |
| `Sources/` | one directory for each target |
| `Sources/<Target>/Resources/format.json` | the format table of a target that models types of the format |
| `Tests/<Target>Tests/` | the tests of a target, with their goldens and fixtures in `testdata/` |
| `scripts/` | the structural lint and the generator of `docs/Modelled-types.md` |
| `docs/Architecture.md` | the targets, their concerns, their dependencies and the layers |
| `docs/Conformance.md` | the gate, the structural lint, the version pins and CI |
| `docs/Modelled-types.md` | the generated list of modelled types |
| `.github/workflows/` | `swift-ci.yml`, the CI that runs the gate, and `release.yml`, the release run by hand |
| `.github/dependabot.yml` | the weekly raising of the Actions pins and the Swift packages |
| `.github/pull_request_template.md` | the checklist of a pull request |
| `Makefile` | the gate `conform`, `tidy` and `upgrade` |
| `CHANGELOG.md` | every change, under `## [Unreleased]` until a release |
| `README.md` | what the package is, how to use it, what it models and where it departs from Apple's reader |
| `NOTICE` | the credits: Apple's documentation and library as the reference, and Swift Collections |
| `.xcode-version`, `.swift-format` | the pin of the toolchain and the configuration of the formatter |
| `.spi.yml` | the manifest of the Swift Package Index: the targets whose documentation the index builds, on macOS with Swift 6.4 |
