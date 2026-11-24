/// The trade that a trim size belongs to.
public enum PageSizeSystem: String, Sendable, Hashable, Decodable, CaseIterable {
  /// The sizes of American publishing, quoted in inches.
  case us = "US"
  /// The sizes of British publishing, quoted in millimetres.
  case uk = "UK"
  /// The sizes of ISO 216, quoted in millimetres.
  case iso = "ISO"
  /// The sizes of Japanese publishing, quoted in millimetres.
  case japan = "Japan"
}
