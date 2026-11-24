public import WireFormat

/// The type `reflection` of the format.
public struct Reflection: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = CanvasCommonFormat.table.object(named: "Reflection")

  /// The `opacity` member; 1 when omitted.
  public var opacity: Double?
  /// The `fade_acceleration` member; 1 when omitted.
  public var fadeAcceleration: Double?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(opacity: Double? = nil, fadeAcceleration: Double? = nil) {
    self.opacity = opacity
    self.fadeAcceleration = fadeAcceleration
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    opacity = try reader.optional("opacity")
    fadeAcceleration = try reader.optional("fade_acceleration")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("opacity", opacity)
    writer.optional("fade_acceleration", fadeAcceleration)
  }
}
