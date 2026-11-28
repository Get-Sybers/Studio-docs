# The gate and the upgrade of the package; docs/Conformance.md describes each target.
SWIFT_DIRS := Package.swift Sources Tests scripts
RESOLVE    ?=
GENERATED  := docs/Modelled-types.md
# The test targets whose breakage corrupts a document; `make check` runs these before a pull request leaves draft.
CRITICAL   ?= RawDeflateTests|ZipArchivesTests|JSONTreeTests|WireFormatTests|DocumentPackageTests|DocumentValidationTests|TextModelTests
PLATFORMS  := iOS tvOS visionOS watchOS
SIMULATOR  ?= iPhone 17
IPHONE     := platform=iOS Simulator,OS=latest,name=$(SIMULATOR)
# xcodebuild spells the switch of RESOLVE its own way, and its derived data stays apart from Xcode's.
XCODEBUILD := xcodebuild -scheme Studio-docs -derivedDataPath .build/xcode \
  $(if $(findstring --disable-automatic-resolution,$(RESOLVE)),-disableAutomaticPackageResolution)

.PHONY: build test test-critical vet fmt fmt-check lint tidy generate platforms test-ios check conform upgrade

build:
	swift build $(RESOLVE)

test:
	swift test $(RESOLVE) --parallel

# Only the critical targets; the build is whole-package, so a compile error in any target still fails here.
test-critical:
	swift test $(RESOLVE) --parallel --filter "$(CRITICAL)"

vet:
	swift build $(RESOLVE) --build-tests

fmt:
	swift format format --in-place --recursive --parallel $(SWIFT_DIRS)

fmt-check:
	swift format lint --strict --recursive --parallel $(SWIFT_DIRS)

# The checks that do not compile; pull-request CI runs the structural lint alone.
lint: fmt-check
	sh scripts/structure-lint.sh

tidy:
	swift package resolve
	git diff --exit-code -- Package.resolved

generate:
	swift scripts/generate-modelled-types.swift Sources $(GENERATED)
	git diff --exit-code -- $(GENERATED)

platforms:
	for platform in $(PLATFORMS); do \
	  $(XCODEBUILD) -quiet -destination "generic/platform=$$platform" build || exit; \
	done

# The build is quiet; the run prints every test and every issue, as `swift test` does.
test-ios:
	$(XCODEBUILD) -quiet -destination "$(IPHONE)" build-for-testing
	$(XCODEBUILD) -destination "$(IPHONE)" test-without-building

# The local gate before a pull request leaves draft: the lints, the generated list and the critical tests.
check: fmt-check generate test-critical
	sh scripts/structure-lint.sh

# The full gate; the release workflow runs it, by hand and at a release. It compiles and tests on every platform.
conform: fmt-check vet test generate platforms test-ios
	sh scripts/structure-lint.sh

upgrade:
	swift package update
	$(MAKE) conform || { git checkout -- Package.resolved; exit 1; }
