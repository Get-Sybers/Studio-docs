public import JSONTree
public import WireFormat

/// What a finding reports. An error breaks a rule of the format; a warning is read otherwise than it was written.
public enum FindingKind: Sendable, Hashable {
  /// The manifest declares a major version of the package that the library does not write.
  case unsupportedPackageVersion(FormatVersion)
  /// A resource's name is empty, is `.` or `..`, or holds a path separator or a NUL.
  case unsafeResourceName(String)
  /// Two resources have names that a file system which ignores case or composition holds as one.
  case resourceNamesCollide(String, String)
  /// An indirect resource names a file that `Data` does not hold.
  case missingResource(name: String)
  /// A resource's `identifier` or `filename` is empty or blank.
  case blankResourceName(member: String)
  /// The text of an embedded resource is not Base64.
  case invalidBase64

  /// A preset has an empty identifier.
  case emptyPresetIdentifier
  /// Two presets share this identifier.
  case duplicatePresetIdentifier(String)
  /// The parents of presets, or the presets their values adopt, lead back to where they began.
  case presetCycle([String])
  /// A preset names a parent that the document does not hold; a reader treats the parent as empty.
  case unknownParentPreset(parent: String)
  /// An object adopts a preset that the document does not hold; a reader falls back to the defaults.
  case unknownPreset(String)

  /// Two objects carry this identifier; the value is the place of the first.
  case duplicateIdentifier(ObjectID, first: JSONPath)
  /// An object's identifier is the empty string.
  case emptyIdentifier
  /// A link names an identifier that no object of the document carries.
  case unresolvedReference(ObjectID)

  /// A member that the type requires is absent.
  case missingMember(type: TypeIdentifier, member: String)
  /// A member that may not be `null` is `null`.
  case nullNotPermitted(type: TypeIdentifier, member: String)
  /// A number lies outside the range that the format gives its member.
  case numberOutOfRange(type: TypeIdentifier, member: String, value: Double)
  /// An array has fewer or more elements than the format gives its member.
  case countOutOfRange(type: TypeIdentifier, member: String, count: Int)
  /// A number is infinite or not a number, which JSON text cannot spell.
  case nonFiniteNumber
  /// A `version` member is not `major.minor`.
  case malformedVersion(String)
  /// An object declares a later minor version than the library models; what is newer is kept and not read.
  case newerVersion(type: TypeIdentifier, declared: FormatVersion, modelled: FormatVersion)
  /// A union names as primary a case that the library does not model, and is read by another case.
  case unmodelledPrimaryCase(type: TypeIdentifier, name: String)
  /// A union holds no case and adopts no preset.
  case unionWithoutForm(type: TypeIdentifier)
  /// An object that names a modelled type does not read as that type.
  case unreadable(type: TypeIdentifier, WireError)

  /// A run inside a paragraph holds U+000A, U+000D or U+2029, where a reader of flat text ends the paragraph.
  case paragraphSeparatorInRun(scalar: UInt32)
  /// A paragraph before the last has no break; a reader puts a paragraph break there.
  case unterminatedParagraphBeforeLast
  /// A list level lies outside 0 to 8; a reader moves it to the nearest level.
  case listLevelOutOfRange(Int)
  /// A list start is negative or beyond 4294967295; a reader clamps it.
  case listStartOutOfRange(Int)
  /// An outline level lies outside -1 to 999; a reader clamps it.
  case outlineLevelOutOfRange(Int)
  /// A list has more than nine levels; a reader ignores the rest.
  case tooManyListLevels(Int)
  /// A tab stop stands at 0 or less; a reader drops it.
  case tabStopNotPositive
  /// A link's URL or file is empty or blank.
  case emptyLinkTarget
  /// A link's URL has the scheme `file`, which belongs in the `file` form.
  case fileURLAsLinkURL
  /// Unequal columns need one gutter fewer than columns.
  case columnGuttersMismatch(columns: Int, gutters: Int)
  /// The widths of unequal columns and their gutters do not total 100.
  case columnWidthsTotal(Double)
  /// A gradient has fewer than two stops; a reader pads it.
  case tooFewGradientStops(Int)
  /// A gradient stop stands before the one ahead of it.
  case gradientStopsOutOfOrder
  /// A number format combines a numbering system with a setting it does not have; a reader falls back.
  case unsupportedNumberFormat
  /// A linear gradient gives some of its two points and its size but not all three; a reader ignores them.
  case incompleteLinearGradient
  /// The asset UUID of a premium resource is no UUID; a reader ignores it.
  case invalidAssetUUID

  /// A slide names a layout that the theme does not hold; a reader uses the theme's first layout.
  case unknownSlideLayout(String)
  /// Two placeholders of one slide or layout are of one kind.
  case repeatedPlaceholderKind(String)
  /// An end of a connection line has no end point.
  case connectionLineEndWithoutPoint
  /// An end of a connection line is anchored to an object that does not stand beside the line.
  case anchorNotASibling(ObjectID)
  /// Two rows, columns, custom formats or conditional style sets of one table carry one name.
  case repeatedTableName(member: String, value: String)
  /// A row or a column index lies outside the table.
  case tableIndexOutOfRange(member: String, index: Int, count: Int)
  /// A row or a column index does not rise above the one before it.
  case tableIndexNotRising(member: String, index: Int)
  /// A cell or a merge names a row, a column, a custom format or a conditional style set that the table lacks.
  case unknownTableReference(member: String, value: String)
  /// A series of a two-axis chart selects a value axis other than the first or the second.
  case yAxisSelectionOutOfRange(Int)

  /// A finding of a client's own rule.
  case custom(name: String, detail: String)

  /// Whether the finding breaks a rule of the format, or is only read otherwise than written.
  public var severity: ValidationFinding.Severity {
    switch self {
    case .unsupportedPackageVersion, .unsafeResourceName, .missingResource, .blankResourceName, .invalidBase64,
      .emptyPresetIdentifier, .duplicatePresetIdentifier, .presetCycle, .duplicateIdentifier, .missingMember,
      .nullNotPermitted, .numberOutOfRange, .countOutOfRange, .nonFiniteNumber, .malformedVersion,
      .unionWithoutForm, .unreadable, .emptyLinkTarget, .fileURLAsLinkURL, .columnGuttersMismatch,
      .columnWidthsTotal, .repeatedPlaceholderKind, .connectionLineEndWithoutPoint, .anchorNotASibling,
      .repeatedTableName, .tableIndexOutOfRange, .tableIndexNotRising, .unknownTableReference,
      .yAxisSelectionOutOfRange, .custom:
      .error
    case .resourceNamesCollide, .unknownParentPreset, .unknownPreset, .emptyIdentifier, .unresolvedReference,
      .newerVersion, .unmodelledPrimaryCase, .paragraphSeparatorInRun, .unterminatedParagraphBeforeLast,
      .listLevelOutOfRange, .listStartOutOfRange, .outlineLevelOutOfRange, .tooManyListLevels,
      .tabStopNotPositive, .tooFewGradientStops, .gradientStopsOutOfOrder, .unsupportedNumberFormat,
      .incompleteLinearGradient, .invalidAssetUUID, .unknownSlideLayout:
      .warning
    }
  }
}
