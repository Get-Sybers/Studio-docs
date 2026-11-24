package import Foundation
import Synchronization

/// The expected outputs of one test target: a map from case name to text in `testdata/<name>.goldens.json`.
///
/// With `UPDATE_GOLDENS=1` in the environment, `want` records what a test produced into the source tree.
package struct GoldenFile: Sendable {
  private let name: String
  private let sourcePath: String
  private let isUpdating: Bool
  private let cases: [String: String]

  /// One writer at a time: every suite of a test target records into the same file.
  private static let recording = Mutex(())

  /// Loads the goldens of a test target; `anchor` is a source file directly inside that target.
  package init(named name: String, in bundle: Bundle, anchor: String = #filePath) throws(GoldenError) {
    self.name = name
    self.isUpdating = ProcessInfo.processInfo.environment["UPDATE_GOLDENS"] == "1"
    self.sourcePath =
      URL(fileURLWithPath: anchor).deletingLastPathComponent()
      .appendingPathComponent("testdata").appendingPathComponent("\(name).goldens.json").path
    guard !isUpdating else {
      self.cases = [:]
      return
    }
    let url = bundle.url(forResource: "\(name).goldens", withExtension: "json", subdirectory: "testdata")
    guard let url else { throw .fileMissing(name: name) }
    do {
      self.cases = try JSONDecoder().decode([String: String].self, from: Data(contentsOf: url))
    } catch {
      throw .unreadable(name: name, underlying: error)
    }
  }

  /// Returns the text expected for a case; when updating, records `got` as that text first.
  package func want(_ key: String, got: String) throws(GoldenError) -> String {
    guard isUpdating else {
      guard let text = cases[key] else { throw .caseMissing(name: name, key: key) }
      return text
    }
    let failure: GoldenError? = Self.recording.withLock { _ in
      let url = URL(fileURLWithPath: sourcePath)
      do {
        var recorded: [String: String] = [:]
        if FileManager.default.fileExists(atPath: sourcePath) {
          recorded = try JSONDecoder().decode([String: String].self, from: Data(contentsOf: url))
        }
        recorded[key] = got
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        var bytes = try encoder.encode(recorded)
        bytes.append(0x0A)
        try bytes.write(to: url, options: .atomic)
        return nil
      } catch {
        return .unwritable(path: sourcePath, underlying: error)
      }
    }
    if let failure { throw failure }
    return got
  }
}
