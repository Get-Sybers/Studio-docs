extension FormatVersion: Codable {
  /// Reads a version from its text.
  public init(from decoder: any Decoder) throws {
    let single = try decoder.singleValueContainer()
    let text = try single.decode(String.self)
    guard let version = FormatVersion(text) else {
      throw DecodingError.dataCorruptedError(in: single, debugDescription: "\(text) is no major.minor version")
    }
    self = version
  }

  /// Writes the version as its text.
  public func encode(to encoder: any Encoder) throws {
    var single = encoder.singleValueContainer()
    try single.encode(description)
  }
}
