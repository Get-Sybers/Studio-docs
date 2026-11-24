public import WireFormat

/// A fill that blends between colours.
public struct GradientFill: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = AppearanceFormat.table.object(named: "GradientFill")

  /// Whether the reader's editor treats the gradient as an advanced one; a member of version 1.1.
  public var isAdvanced: Bool?
  /// The colours and their places, from the start of the gradient to its end; at least two.
  public var stops: [GradientStop]
  /// The opacity of the whole gradient, from 0 to 1; 1 when omitted.
  public var opacity: Double?
  /// Whether the gradient runs along a line or out from a centre.
  public var flavor: GradientFlavor
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a gradient; a member left out is absent from the JSON.
  public init(stops: [GradientStop], flavor: GradientFlavor, isAdvanced: Bool? = nil, opacity: Double? = nil) {
    self.isAdvanced = isAdvanced
    self.stops = stops
    self.opacity = opacity
    self.flavor = flavor
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    isAdvanced = try reader.optional("is_advanced")
    stops = try reader.required("stops")
    opacity = try reader.optional("opacity")
    flavor = try reader.required("flavor")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("is_advanced", isAdvanced)
    writer.required("stops", stops)
    writer.optional("opacity", opacity)
    writer.required("flavor", flavor)
  }
}
