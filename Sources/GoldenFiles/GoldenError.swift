/// A failure to read or write the goldens of a test target.
package enum GoldenError: Error, CustomStringConvertible {
  /// The bundle of the test target holds no goldens file of this name.
  case fileMissing(name: String)
  /// The goldens file is not a JSON map from case name to text.
  case unreadable(name: String, underlying: any Error)
  /// The file holds no expectation for this case.
  case caseMissing(name: String, key: String)
  /// The goldens file in the source tree was not written.
  case unwritable(path: String, underlying: any Error)

  package var description: String {
    switch self {
    case .fileMissing(let name):
      "the test bundle holds no testdata/\(name).goldens.json"
    case .unreadable(let name, let underlying):
      "testdata/\(name).goldens.json is not a map from case name to text: \(underlying)"
    case .caseMissing(let name, let key):
      "\(name).goldens.json has no case \"\(key)\"; UPDATE_GOLDENS=1 make test records it"
    case .unwritable(let path, let underlying):
      "\(path) was not written: \(underlying)"
    }
  }
}
