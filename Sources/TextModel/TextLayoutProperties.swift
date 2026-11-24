public import Appearance
public import WireFormat

/// How text is laid out in its container: columns, padding and vertical alignment.
public struct TextLayoutProperties: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = TextFormat.table.object(named: "TextLayoutProperties")

  /// The columns; one of full width when unset.
  public var columns: Inheritable<ColumnMetrics>
  /// Whether text in this layout goes on down the page.
  public var continuous: Inheritable<Bool>
  /// The space between the container and its column layout, in points.
  public var margins: Inheritable<Insets>
  /// The space between the container and its text, in points.
  public var padding: Inheritable<Insets>
  /// Whether the text is scaled down to fit the container.
  public var shrinkToFit: Inheritable<Bool>
  /// Where the text sits between top and bottom.
  public var verticalAlignment: Inheritable<VerticalTextAlignment>
  /// Whether the text runs vertically.
  public var verticalText: Inheritable<Bool>
  /// The direction of the text.
  public var writingDirection: Inheritable<WritingDirection>
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates layout properties; a member left out is absent from the JSON.
  public init(
    columns: Inheritable<ColumnMetrics> = .inherited, continuous: Inheritable<Bool> = .inherited,
    margins: Inheritable<Insets> = .inherited, padding: Inheritable<Insets> = .inherited,
    shrinkToFit: Inheritable<Bool> = .inherited, verticalAlignment: Inheritable<VerticalTextAlignment> = .inherited,
    verticalText: Inheritable<Bool> = .inherited, writingDirection: Inheritable<WritingDirection> = .inherited
  ) {
    self.columns = columns
    self.continuous = continuous
    self.margins = margins
    self.padding = padding
    self.shrinkToFit = shrinkToFit
    self.verticalAlignment = verticalAlignment
    self.verticalText = verticalText
    self.writingDirection = writingDirection
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    columns = try reader.inheritable("columns")
    continuous = try reader.inheritable("continuous")
    margins = try reader.inheritable("margins")
    padding = try reader.inheritable("padding")
    shrinkToFit = try reader.inheritable("shrink_to_fit")
    verticalAlignment = try reader.inheritable("vertical_alignment")
    verticalText = try reader.inheritable("vertical_text")
    writingDirection = try reader.inheritable("writing_direction")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.inheritable("columns", columns)
    writer.inheritable("continuous", continuous)
    writer.inheritable("margins", margins)
    writer.inheritable("padding", padding)
    writer.inheritable("shrink_to_fit", shrinkToFit)
    writer.inheritable("vertical_alignment", verticalAlignment)
    writer.inheritable("vertical_text", verticalText)
    writer.inheritable("writing_direction", writingDirection)
  }
}
