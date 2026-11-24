/// The four bytes that open each kind of record.
enum ZipSignature {
  static let localHeader: UInt64 = 0x0403_4B50
  static let directoryHeader: UInt64 = 0x0201_4B50
  static let endRecord: UInt64 = 0x0605_4B50
  static let zip64EndRecord: UInt64 = 0x0606_4B50
  static let zip64Locator: UInt64 = 0x0706_4B50
}
