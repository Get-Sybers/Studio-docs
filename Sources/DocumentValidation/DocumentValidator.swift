import JSONTree
import PresetStyles
import WireFormat

/// Checks a document against the rules of the format that a schema alone does not state.
public enum DocumentValidator {
  /// Returns every finding: the presets, the names in `Data`, the tree of `main.json`, then what they refer to.
  public static func validate(_ input: ValidationInput) -> ValidationReport {
    var collector = FindingCollector()
    PresetRules.check(input.presets, into: &collector)
    ResourceRules.check(input.resourceNames, into: &collector)
    let resolver = PresetResolver(input.presets)

    collector.part = .main
    TreeRules.walk(input.main, below: .root, input: input, resolver: resolver, into: &collector)
    collector.part = .presets
    for (index, preset) in input.presets.presets.enumerated() {
      let prefix = JSONPath([.index(index), .member("properties")])
      // The properties name no type of their own; each value among them is checked as what it names.
      for (name, value) in preset.properties {
        TreeRules.walk(value, below: prefix.member(name), input: input, resolver: resolver, into: &collector)
      }
    }

    guard input.isSelfContained else { return ValidationReport(collector.findings) }
    for adoption in collector.adoptions
    where input.presets[adoption.name] == nil && !collector.styleNames.contains(adoption.name) {
      collector.part = adoption.part
      collector.report(.unknownPreset(adoption.name), at: adoption.path.member("preset_identifier"))
    }
    IdentifierRules.check(input.main, into: &collector)
    return ValidationReport(collector.findings)
  }

  /// The type identifiers that have a check of their own: every type that the library models.
  package static var checkedTypes: [String] {
    ModelledChecks.registry.keys.map(\.rawValue).sorted()
  }
}
