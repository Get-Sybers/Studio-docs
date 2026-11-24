public import Appearance
public import WireFormat

/// The borders or rules of a paragraph.
public struct ParagraphBorders: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TextFormat.table.object(named: "ParagraphBorders")

  /// The stroke that draws them.
  public var stroke: Inheritable<TextStroke>
  /// The length of a rule as a fraction of the paragraph's width.
  public var width: Inheritable<Double>
  /// The offset of the border or rule.
  public var offset: Inheritable<OffsetValue>
  /// Whether the corners are rounded.
  public var rounded: Inheritable<Bool>
  /// Whether the paragraph has no border at all; it outweighs the five members below.
  public var noBorders: Bool?
  /// Whether every side has a border.
  public var allBorders: Bool?
  /// Whether a rule or border stands above.
  public var before: Bool?
  /// Whether a rule or border stands below.
  public var after: Bool?
  /// Whether a rule or border stands on the leading side.
  public var leading: Bool?
  /// Whether a rule or border stands on the trailing side.
  public var trailing: Bool?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates paragraph borders; a member left out is absent from the JSON.
  public init(
    stroke: Inheritable<TextStroke> = .inherited, width: Inheritable<Double> = .inherited,
    offset: Inheritable<OffsetValue> = .inherited, rounded: Inheritable<Bool> = .inherited, noBorders: Bool? = nil,
    allBorders: Bool? = nil, before: Bool? = nil, after: Bool? = nil, leading: Bool? = nil, trailing: Bool? = nil
  ) {
    self.stroke = stroke
    self.width = width
    self.offset = offset
    self.rounded = rounded
    self.noBorders = noBorders
    self.allBorders = allBorders
    self.before = before
    self.after = after
    self.leading = leading
    self.trailing = trailing
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    stroke = try reader.inheritable("stroke")
    width = try reader.inheritable("width")
    offset = try reader.inheritable("offset")
    rounded = try reader.inheritable("rounded")
    noBorders = try reader.optional("no_borders")
    allBorders = try reader.optional("all_borders")
    before = try reader.optional("before")
    after = try reader.optional("after")
    leading = try reader.optional("leading")
    trailing = try reader.optional("trailing")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.inheritable("stroke", stroke)
    writer.inheritable("width", width)
    writer.inheritable("offset", offset)
    writer.inheritable("rounded", rounded)
    writer.optional("no_borders", noBorders)
    writer.optional("all_borders", allBorders)
    writer.optional("before", before)
    writer.optional("after", after)
    writer.optional("leading", leading)
    writer.optional("trailing", trailing)
  }
}
