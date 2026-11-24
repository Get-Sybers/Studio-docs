public import Appearance
public import WireFormat

/// The properties of a paragraph: alignment, indents, spacing, tabs and the rest.
///
/// A member left `.inherited` comes from the preset; `.cleared` writes `null`.
public struct ParagraphProperties: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TextFormat.table.object(named: "ParagraphProperties")

  /// The horizontal alignment.
  public var alignment: Inheritable<ParagraphAlignment>
  /// The character that text lines up on at a decimal tab stop.
  public var decimalTab: Inheritable<String>
  /// The distance between the automatic tab stops, in points.
  public var defaultTabs: Inheritable<Double>
  /// The colour behind the paragraph.
  public var fill: Inheritable<ColorValue>
  /// The indent of the first line, in points, in place of the left indent.
  public var firstLineIndent: Inheritable<Double>
  /// The paragraph style of the paragraph made after this one, by identifier or name.
  public var followingStyle: Inheritable<String>
  /// Whether long words may be hyphenated at the end of a line.
  public var hyphenate: Inheritable<Bool>
  /// The list style that text in this paragraph style starts with, by identifier or name.
  public var listStyle: Inheritable<String>
  /// Whether the lines stay on one page.
  public var keepLinesTogether: Inheritable<Bool>
  /// Whether the paragraph stays on the page of the next one.
  public var keepWithNext: Inheritable<Bool>
  /// The indent of the left edge, in points.
  public var leftIndent: Inheritable<Double>
  /// The spacing between lines.
  public var lineSpacing: Inheritable<LineSpacing>
  /// The depth in the outline, from 0; -1 for body text.
  public var outlineLevel: Inheritable<Int>
  /// Whether the paragraph starts a page.
  public var startOnNewPage: Inheritable<Bool>
  /// The borders or rules of the paragraph.
  public var borders: ParagraphBorders?
  /// The indent of the right edge, in points.
  public var rightIndent: Inheritable<Double>
  /// The space after the paragraph, in points.
  public var spaceAfter: Inheritable<Double>
  /// The space before the paragraph, in points.
  public var spaceBefore: Inheritable<Double>
  /// The tab stops.
  public var tabs: Inheritable<[TabStop]>
  /// Whether a single line may stand alone at the top or bottom of a page.
  public var preventWidow: Inheritable<Bool>
  /// Whether the paragraph shows in the list of bookmarks.
  public var showInBookmarks: Inheritable<Bool>
  /// Whether the paragraph shows in the table of contents.
  public var showInTOCNavigator: Inheritable<Bool>
  /// The character properties that the paragraph gives its text.
  public var characterProperties: CharacterProperties?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates paragraph properties; a member left out is absent from the JSON.
  public init(
    alignment: Inheritable<ParagraphAlignment> = .inherited, decimalTab: Inheritable<String> = .inherited,
    defaultTabs: Inheritable<Double> = .inherited, fill: Inheritable<ColorValue> = .inherited,
    firstLineIndent: Inheritable<Double> = .inherited, followingStyle: Inheritable<String> = .inherited,
    hyphenate: Inheritable<Bool> = .inherited, listStyle: Inheritable<String> = .inherited,
    keepLinesTogether: Inheritable<Bool> = .inherited, keepWithNext: Inheritable<Bool> = .inherited,
    leftIndent: Inheritable<Double> = .inherited, lineSpacing: Inheritable<LineSpacing> = .inherited,
    outlineLevel: Inheritable<Int> = .inherited, startOnNewPage: Inheritable<Bool> = .inherited,
    borders: ParagraphBorders? = nil, rightIndent: Inheritable<Double> = .inherited,
    spaceAfter: Inheritable<Double> = .inherited, spaceBefore: Inheritable<Double> = .inherited,
    tabs: Inheritable<[TabStop]> = .inherited, preventWidow: Inheritable<Bool> = .inherited,
    showInBookmarks: Inheritable<Bool> = .inherited, showInTOCNavigator: Inheritable<Bool> = .inherited,
    characterProperties: CharacterProperties? = nil
  ) {
    self.alignment = alignment
    self.decimalTab = decimalTab
    self.defaultTabs = defaultTabs
    self.fill = fill
    self.firstLineIndent = firstLineIndent
    self.followingStyle = followingStyle
    self.hyphenate = hyphenate
    self.listStyle = listStyle
    self.keepLinesTogether = keepLinesTogether
    self.keepWithNext = keepWithNext
    self.leftIndent = leftIndent
    self.lineSpacing = lineSpacing
    self.outlineLevel = outlineLevel
    self.startOnNewPage = startOnNewPage
    self.borders = borders
    self.rightIndent = rightIndent
    self.spaceAfter = spaceAfter
    self.spaceBefore = spaceBefore
    self.tabs = tabs
    self.preventWidow = preventWidow
    self.showInBookmarks = showInBookmarks
    self.showInTOCNavigator = showInTOCNavigator
    self.characterProperties = characterProperties
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    alignment = try reader.inheritable("alignment")
    decimalTab = try reader.inheritable("decimal_tab")
    defaultTabs = try reader.inheritable("default_tabs")
    fill = try reader.inheritable("fill")
    firstLineIndent = try reader.inheritable("first_line_indent")
    followingStyle = try reader.inheritable("following_style")
    hyphenate = try reader.inheritable("hyphenate")
    listStyle = try reader.inheritable("list_style")
    keepLinesTogether = try reader.inheritable("keep_lines_together")
    keepWithNext = try reader.inheritable("keep_with_next")
    leftIndent = try reader.inheritable("left_indent")
    lineSpacing = try reader.inheritable("line_spacing")
    outlineLevel = try reader.inheritable("outline_level")
    startOnNewPage = try reader.inheritable("start_on_new_page")
    borders = try reader.optional("borders")
    rightIndent = try reader.inheritable("right_indent")
    spaceAfter = try reader.inheritable("space_after")
    spaceBefore = try reader.inheritable("space_before")
    tabs = try reader.inheritable("tabs")
    preventWidow = try reader.inheritable("prevent_widow")
    showInBookmarks = try reader.inheritable("show_in_bookmarks")
    showInTOCNavigator = try reader.inheritable("show_in_tocnavigator")
    characterProperties = try reader.optional("character_properties")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.inheritable("alignment", alignment)
    writer.inheritable("decimal_tab", decimalTab)
    writer.inheritable("default_tabs", defaultTabs)
    writer.inheritable("fill", fill)
    writer.inheritable("first_line_indent", firstLineIndent)
    writer.inheritable("following_style", followingStyle)
    writer.inheritable("hyphenate", hyphenate)
    writer.inheritable("list_style", listStyle)
    writer.inheritable("keep_lines_together", keepLinesTogether)
    writer.inheritable("keep_with_next", keepWithNext)
    writer.inheritable("left_indent", leftIndent)
    writer.inheritable("line_spacing", lineSpacing)
    writer.inheritable("outline_level", outlineLevel)
    writer.inheritable("start_on_new_page", startOnNewPage)
    writer.optional("borders", borders)
    writer.inheritable("right_indent", rightIndent)
    writer.inheritable("space_after", spaceAfter)
    writer.inheritable("space_before", spaceBefore)
    writer.inheritable("tabs", tabs)
    writer.inheritable("prevent_widow", preventWidow)
    writer.inheritable("show_in_bookmarks", showInBookmarks)
    writer.inheritable("show_in_tocnavigator", showInTOCNavigator)
    writer.optional("character_properties", characterProperties)
  }
}
