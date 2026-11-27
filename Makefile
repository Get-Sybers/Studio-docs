# The gate and the upgrade of the package; docs/Conformance.md describes each target.
SWIFT_DIRS := Package.swift Sources Tests scripts
RESOLVE    ?=
GENERATED  := docs/Modelled-types.md
PLATFORMS  := iOS tvOS visionOS watchOS
SIMULATOR  ?= iPhone 17
IPHONE     := platform=iOS Simulator,OS=latest,name=$(SIMULATOR)
# xcodebuild spells the switch of RESOLVE its own way, and its derived data stays apart from Xcode's.
XCODEBUILD := xcodebuild -scheme Studio-docs -derivedDataPath .build/xcode \
  $(if $(findstring --disable-automatic-resolution,$(RESOLVE)),-disableAutomaticPackageResolution)

.PHONY: build test vet fmt fmt-check tidy generate platforms test-ios conform upgrade

build:
	swift build $(RESOLVE)

test:
	swift test $(RESOLVE) --parallel

vet:
	swift build $(RESOLVE) --build-tests

fmt:
	swift format format --in-place --recursive --parallel $(SWIFT_DIRS)

fmt-check:
	swift format lint --strict --recursive --parallel $(SWIFT_DIRS)

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

conform: fmt-check vet test generate platforms test-ios
	sh scripts/structure-lint.sh

upgrade:
	swift package update
	$(MAKE) conform || { git checkout -- Package.resolved; exit 1; }
