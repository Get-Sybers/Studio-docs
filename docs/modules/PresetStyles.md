# PresetStyles

The presets of `presets.json`, their inheritance, and the resolver of effective properties.

## What it provides

Reads the `presets.json` of a package into a library of presets, follows what one preset inherits from
another, and resolves the effective properties of an object once its inheritance is applied. An object that
leaves a property unset takes the value from the preset it inherits.

## Principal API

- `PresetLibrary` — the presets of a package, by identifier.
- `Preset` — one preset and what it inherits.
- `PresetResolver` — the effective value of a property after inheritance.
- `PresetError` — a malformed or circular set of presets.

## Resources

None; `presets.json` is an entry of the package a consumer opens.

## Depends on

`JSONTree`, `WireFormat`, OrderedCollections. A product module of `StudioDocs`.
