/// A failure to turn the text of an embedded resource into bytes.
public enum ResourceDataError: Error, Sendable, Hashable {
  /// The text of the resource with this filename is not Base64.
  case notBase64(filename: String)
}
