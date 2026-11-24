public import Foundation

extension JSONValue {
  /// Reads JSON text through Foundation's decoder; an object that holds a member name twice is refused.
  public init(parsing text: Data) throws(JSONTreeError) {
    if let repeated = MemberNameScan.firstRepeatedName(in: text) {
      throw .repeatedMember(name: repeated.name, at: repeated.path)
    }
    do {
      self = try JSONDecoder().decode(JSONValue.self, from: text)
    } catch {
      throw .malformed(underlying: error)
    }
  }

  /// Writes the tree as UTF-8 JSON text through Foundation's encoder, the members of each object by name.
  public func text(_ style: JSONStyle = .compact) throws(JSONTreeError) -> Data {
    let encoder = JSONEncoder()
    encoder.outputFormatting =
      style == .compact
      ? [.sortedKeys, .withoutEscapingSlashes] : [.sortedKeys, .withoutEscapingSlashes, .prettyPrinted]
    do {
      return try encoder.encode(self)
    } catch {
      throw .notRepresentable(underlying: error)
    }
  }
}
