public import CanvasCommon
public import WireFormat

/// The type `playback-options` of the format.
public struct PlaybackOptions: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = CanvasModelFormat.table.object(named: "PlaybackOptions")

  /// The `volume` member; 1 when omitted.
  public var volume: Double?
  /// The `start_time` member.
  public var startTime: DurationValue?
  /// The `end_time` member.
  public var endTime: DurationValue?
  /// The `loop_option` member; "none" when omitted.
  public var loopOption: LoopOption?
  /// The `plays_across_slides` member; false when omitted.
  public var playsAcrossSlides: Bool?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    volume: Double? = nil, startTime: DurationValue? = nil, endTime: DurationValue? = nil,
    loopOption: LoopOption? = nil, playsAcrossSlides: Bool? = nil
  ) {
    self.volume = volume
    self.startTime = startTime
    self.endTime = endTime
    self.loopOption = loopOption
    self.playsAcrossSlides = playsAcrossSlides
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    volume = try reader.optional("volume")
    startTime = try reader.optional("start_time")
    endTime = try reader.optional("end_time")
    loopOption = try reader.optional("loop_option")
    playsAcrossSlides = try reader.optional("plays_across_slides")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("volume", volume)
    writer.optional("start_time", startTime)
    writer.optional("end_time", endTime)
    writer.optional("loop_option", loopOption)
    writer.optional("plays_across_slides", playsAcrossSlides)
  }
}
