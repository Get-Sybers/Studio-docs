package import Foundation
package import JSONTree

/// The inputs of one test target: a map from name to a JSON sample in `testdata/<name>.fixtures.json`.
package struct FixtureFile: Sendable {
  private let name: String
  /// Every sample, by name.
  package let samples: JSONObject

  /// Loads the fixtures of a test target.
  package init(named name: String, in bundle: Bundle) throws(FixtureError) {
    self.name = name
    guard let url = bundle.url(forResource: "\(name).fixtures", withExtension: "json", subdirectory: "testdata")
    else { throw .fileMissing(name: name) }
    do {
      guard let samples = try JSONValue(parsing: Data(contentsOf: url)).objectValue else {
        throw FixtureError.sampleMissing(name: name, key: "<root>")
      }
      self.samples = samples
    } catch {
      throw .unreadable(name: name, underlying: error)
    }
  }

  /// Returns the sample of a name.
  package func sample(_ key: String) throws(FixtureError) -> JSONValue {
    guard let sample = samples[key] else { throw .sampleMissing(name: name, key: key) }
    return sample
  }
}
