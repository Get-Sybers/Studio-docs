/// A failure to read the fixtures of a test target.
package enum FixtureError: Error, CustomStringConvertible {
  /// The bundle of the test target holds no fixtures file of this name.
  case fileMissing(name: String)
  /// The fixtures file is not a JSON object.
  case unreadable(name: String, underlying: any Error)
  /// The file holds no sample of this name.
  case sampleMissing(name: String, key: String)

  package var description: String {
    switch self {
    case .fileMissing(let name): "the test bundle holds no testdata/\(name).fixtures.json"
    case .unreadable(let name, let underlying): "testdata/\(name).fixtures.json is no JSON object: \(underlying)"
    case .sampleMissing(let name, let key): "\(name).fixtures.json has no sample \"\(key)\""
    }
  }
}
