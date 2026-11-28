# ModelFixtures

The fixtures of a test target, and the checks that a type and its table agree.

## What it provides

The fixtures a test target reads, and the checks that a modelled type and its format table agree: that
every member the table names the type reads, and that the type reads no member the table does not name.
This target supports the tests; no consumer imports it.

## Principal API

- `FixtureFile` — a fixture, read for a test.
- `ModelledType` — a type as its table describes it.
- `ModelCheck` — the check that a type and its table agree.
- `FixtureError` — a malformed fixture.

## Resources

None.

## Depends on

`JSONTree`, `WireFormat`. Not in the `StudioDocs` product; it supports the tests.
