/// A coding key for a member whose name is known only at run time.
struct JSONCodingKey: CodingKey {
  var stringValue: String
  var intValue: Int? { nil }

  init(_ name: String) {
    stringValue = name
  }

  init?(stringValue: String) {
    self.stringValue = stringValue
  }

  init?(intValue: Int) {
    nil
  }
}
