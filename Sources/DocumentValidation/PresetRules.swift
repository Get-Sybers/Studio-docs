import JSONTree
import PresetStyles

/// The rules of `presets.json`: distinct identifiers, known parents, and no way back to a preset from itself.
enum PresetRules {
  static func check(_ library: PresetLibrary, into collector: inout FindingCollector) {
    collector.part = .presets
    var edges: [String: [String]] = [:]
    var order: [String] = []
    for (index, preset) in library.presets.enumerated() {
      let path = JSONPath([.index(index)])
      if preset.identifier.isEmpty { collector.report(.emptyPresetIdentifier, at: path.member("identifier")) }
      if edges[preset.identifier] != nil {
        collector.report(.duplicatePresetIdentifier(preset.identifier), at: path.member("identifier"))
        continue
      }
      var targets: [String] = []
      if let parent = preset.parentIdentifier, !parent.isEmpty {
        targets.append(parent)
        if library[parent] == nil {
          collector.report(.unknownParentPreset(parent: parent), at: path.member("parent_identifier"))
        }
      }
      // A value inside the properties may adopt a preset of its own; the properties themselves adopt none.
      for (_, value) in preset.properties {
        value.walk { nested, _ in
          if let adopted = nested["preset_identifier"]?.stringValue, !adopted.isEmpty { targets.append(adopted) }
        }
      }
      edges[preset.identifier] = targets
      order.append(preset.identifier)
    }
    var settled: Set<String> = []
    for start in order where !settled.contains(start) {
      var trail: [String] = []
      if let cycle = cycle(from: start, edges: edges, trail: &trail, settled: &settled) {
        let index = library.presets.firstIndex { $0.identifier == cycle[0] } ?? 0
        collector.report(.presetCycle(cycle), at: JSONPath([.index(index)]))
      }
    }
  }

  private static func cycle(
    from node: String, edges: [String: [String]], trail: inout [String], settled: inout Set<String>
  ) -> [String]? {
    if let start = trail.firstIndex(of: node) { return Array(trail[start...]) + [node] }
    guard !settled.contains(node), let targets = edges[node] else { return nil }
    trail.append(node)
    defer {
      trail.removeLast()
      settled.insert(node)
    }
    for target in targets {
      if let found = cycle(from: target, edges: edges, trail: &trail, settled: &settled) { return found }
    }
    return nil
  }
}
