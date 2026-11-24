import Foundation
import JSONTree

/// The rules of the names in `Data`: one flat, safe name each, and no two that a file system holds as one.
enum ResourceRules {
  static func isSafe(_ name: String) -> Bool {
    !name.isEmpty && name != "." && name != ".."
      && !name.unicodeScalars.contains { $0 == "/" || $0 == "\\" || $0.value == 0 }
  }

  /// The form of a name on a file system that ignores case and composition.
  static func folded(_ name: String) -> String {
    name.precomposedStringWithCanonicalMapping.lowercased()
  }

  static func check(_ names: [String], into collector: inout FindingCollector) {
    collector.part = .resources
    var seen: [String: String] = [:]
    for name in names {
      if !isSafe(name) { collector.report(.unsafeResourceName(name), at: .root) }
      let key = folded(name)
      if let earlier = seen[key] {
        collector.report(.resourceNamesCollide(earlier, name), at: .root)
      } else {
        seen[key] = name
      }
    }
  }
}
