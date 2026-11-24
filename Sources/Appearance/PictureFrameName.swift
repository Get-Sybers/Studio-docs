public import WireFormat

/// The name of a picture frame that the reader ships.
public struct PictureFrameName: WireEnumeration {
  /// The value as written.
  public let rawValue: String

  /// Creates a value from its text, whether the library knows it or not.
  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  /// The frame `antique`.
  public static let antique = PictureFrameName(rawValue: "antique")
  /// The frame `crayon_line`.
  public static let crayonLine = PictureFrameName(rawValue: "crayon_line")
  /// The frame `formal_inset`.
  public static let formalInset = PictureFrameName(rawValue: "formal_inset")
  /// The frame `formal_shadow`.
  public static let formalShadow = PictureFrameName(rawValue: "formal_shadow")
  /// The frame `graph_paper`.
  public static let graphPaper = PictureFrameName(rawValue: "graph_paper")
  /// The frame `headlines`.
  public static let headlines = PictureFrameName(rawValue: "headlines")
  /// The frame `jet_set`.
  public static let jetSet = PictureFrameName(rawValue: "jet_set")
  /// The frame `photo_portfolio1`.
  public static let photoPortfolio1 = PictureFrameName(rawValue: "photo_portfolio1")
  /// The frame `portfolio_inset`.
  public static let portfolioInset = PictureFrameName(rawValue: "portfolio_inset")
  /// The frame `pushpin`.
  public static let pushpin = PictureFrameName(rawValue: "pushpin")
  /// The frame `renaissance1`.
  public static let renaissance1 = PictureFrameName(rawValue: "renaissance1")
  /// The frame `scrapbook2b`.
  public static let scrapbook2b = PictureFrameName(rawValue: "scrapbook2b")
  /// The frame `storyboard`.
  public static let storyboard = PictureFrameName(rawValue: "storyboard")
  /// The frame `vintage_inset`.
  public static let vintageInset = PictureFrameName(rawValue: "vintage_inset")

  /// The values that the library knows, from the format table.
  public static let modelled = AppearanceFormat.table.values(of: "PictureFrameName").map(
    PictureFrameName.init(rawValue:))
}
