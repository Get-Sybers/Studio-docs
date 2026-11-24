public import CanvasCommon
public import ResourceReferences
public import WireFormat

/// The type `audio` of the format.
public struct Audio: WireObject {
  /// The facts of the type, from the format table.
  public static let schema = CanvasModelFormat.table.object(named: "Audio")

  /// The `geometry` member.
  public var geometry: Geometry?
  /// The `aspect_ratio_locked` member; false when omitted.
  public var aspectRatioLocked: Bool?
  /// The `description` member.
  public var description: String?
  /// The `resource` member.
  public var resource: ResourceReference
  /// The `playback_options` member.
  public var playbackOptions: PlaybackOptions
  /// The `native_audio_recording` member; false when omitted.
  public var nativeAudioRecording: Bool?
  /// The identifier, version and preset of the object, and the members the type does not model.
  public var envelope = ObjectEnvelope()

  /// Creates a value; a member left out is absent from the JSON.
  public init(
    geometry: Geometry? = nil, aspectRatioLocked: Bool? = nil, description: String? = nil, resource: ResourceReference,
    playbackOptions: PlaybackOptions, nativeAudioRecording: Bool? = nil
  ) {
    self.geometry = geometry
    self.aspectRatioLocked = aspectRatioLocked
    self.description = description
    self.resource = resource
    self.playbackOptions = playbackOptions
    self.nativeAudioRecording = nativeAudioRecording
  }

  /// Reads the members of the type.
  public init(reading reader: inout ObjectReader) throws(WireError) {
    geometry = try reader.optional("geometry")
    aspectRatioLocked = try reader.optional("aspect_ratio_locked")
    description = try reader.optional("description")
    resource = try reader.required("resource")
    playbackOptions = try reader.required("playback_options")
    nativeAudioRecording = try reader.optional("native_audio_recording")
  }

  /// Writes the members of the type.
  public func write(to writer: inout ObjectWriter) {
    writer.optional("geometry", geometry)
    writer.optional("aspect_ratio_locked", aspectRatioLocked)
    writer.optional("description", description)
    writer.required("resource", resource)
    writer.required("playback_options", playbackOptions)
    writer.optional("native_audio_recording", nativeAudioRecording)
  }
}
