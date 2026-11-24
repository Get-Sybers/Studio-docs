public import Foundation

extension EmbeddedResource {
  /// Creates a resource that carries these bytes.
  public init(data: Data, filename: String) {
    self.init(string: data.base64EncodedString(), filename: filename)
  }

  /// Returns the bytes that the text spells.
  public func decodedData() throws(ResourceDataError) -> Data {
    guard let data = Data(base64Encoded: string) else { throw .notBase64(filename: filename) }
    return data
  }
}
