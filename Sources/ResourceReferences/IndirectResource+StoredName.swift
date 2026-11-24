extension IndirectResource {
  /// The name of the file in `Data` that holds the bytes: the identifier, or else the filename.
  public var storedName: String {
    identifier ?? filename
  }
}
