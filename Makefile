# The gate and the upgrade of the package; docs/Conformance.md describes each target.
SWIFT_DIRS := Package.swift Sources Tests scripts
RESOLVE    ?=
GENERATED  := docs/Modelled-types.md

.PHONY: build test vet fmt fmt-check tidy generate conform upgrade

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

conform: fmt-check vet test generate
	sh scripts/structure-lint.sh

upgrade:
	swift package update
	$(MAKE) conform || { git checkout -- Package.resolved; exit 1; }
