import JSONTree

/// Gathers findings, and what the trees refer to, as the checks walk a document.
struct FindingCollector {
  var findings: [ValidationFinding] = []
  var part = ValidationFinding.Part.main
  /// The presets that objects adopt, with the place of each use.
  var adoptions: [(name: String, part: ValidationFinding.Part, path: JSONPath)] = []
  /// The identifiers that slide links name.
  var references: [(identifier: String, path: JSONPath)] = []
  /// The preset identifiers that named styles of a stylesheet define.
  var styleNames: Set<String> = []

  mutating func report(_ kind: FindingKind, at path: JSONPath) {
    findings.append(ValidationFinding(kind, in: part, at: path))
  }
}
