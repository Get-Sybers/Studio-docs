import Foundation

/// The trim sizes of the book trade today, read once from the `page-sizes.json` that the target embeds.
public enum PageSizeCatalogue {
  private struct File: Decodable {
    var sizes: [PageSize]
  }

  /// Every size, in the order of the catalogue: the American, the British, the ISO and the Japanese.
  public static let all: [PageSize] = {
    do {
      return try JSONDecoder().decode(File.self, from: Data(PackageResources.page_sizes_json)).sizes
    } catch {
      preconditionFailure("the page sizes that PageSizes embeds do not decode: \(error)")
    }
  }()

  /// The size of a name, as the catalogue spells it.
  public static func named(_ name: String) -> PageSize? {
    all.first { $0.name == name }
  }

  /// The sizes of one trade, in the order of the catalogue.
  public static func sizes(in system: PageSizeSystem) -> [PageSize] {
    all.filter { $0.system == system }
  }
}
