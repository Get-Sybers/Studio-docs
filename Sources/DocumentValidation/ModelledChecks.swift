import Appearance
import Foundation
import JSONTree
import ResourceReferences
import TextModel
import WireFormat

/// For each modelled type, the check that an object naming it reads as it, and the rules of that type.
enum ModelledChecks {
  typealias Check = @Sendable (JSONValue, JSONPath, inout FindingCollector) -> Void

  static let registry: [TypeIdentifier: Check] = Dictionary(
    uniqueKeysWithValues: [
      union(ResourceReference.self), object(IndirectResource.self), object(PremiumResourceInfo.self, premium),
      object(EmbeddedResource.self, embedded),
      union(ColorValue.self), object(RGBAColor.self), union(Fill.self), object(GradientFill.self, gradient),
      object(GradientStop.self), union(GradientFlavor.self), object(LinearFlavor.self, linear),
      object(RadialFlavor.self), object(ImageFill.self), object(PositionValue.self), object(SizeValue.self),
      object(OffsetValue.self), object(Insets.self), union(Shadow.self), object(ContactShadow.self),
      object(CurvedShadow.self), object(DropShadow.self), union(Stroke.self), object(LineStroke.self),
      object(PictureFrame.self), union(TextStroke.self),
      union(TextBody.self, body), object(Paragraph.self, paragraph), union(ParagraphContent.self),
      object(HyperlinkField.self), union(Hyperlink.self, link), union(SlideTarget.self, target),
      object(TextRun.self), object(CharacterProperties.self), object(FontFeature.self),
      object(ParagraphProperties.self, paragraphProperties), object(LineSpacing.self),
      object(ParagraphBorders.self), object(TabStop.self, tabStop), object(ListProperties.self, list),
      object(ListLevel.self), union(ListLabel.self), object(ListNumberLabel.self), object(ListStringLabel.self),
      object(ListImageLabel.self), object(ListNumberFormat.self, numberFormat),
      object(TextLayoutProperties.self), union(ColumnMetrics.self), object(EqualColumns.self),
      object(UnequalColumns.self, unequalColumns), object(Stylesheet.self), object(NamedCharacterStyle.self),
      object(NamedParagraphStyle.self), object(NamedListStyle.self),
    ])

  private static func object<Object: WireObject>(
    _ type: Object.Type,
    _ rule: @escaping @Sendable (Object, JSONPath, inout FindingCollector) -> Void = { _, _, _ in }
  ) -> (TypeIdentifier, Check) {
    (Object.typeIdentifier, { value, path, collector in read(value, as: type, at: path, rule, into: &collector) })
  }

  private static func union<Union: WireUnion>(
    _ type: Union.Type,
    _ rule: @escaping @Sendable (Union, JSONPath, inout FindingCollector) -> Void = { _, _, _ in }
  ) -> (TypeIdentifier, Check) {
    (Union.typeIdentifier, { value, path, collector in read(value, as: type, at: path, rule, into: &collector) })
  }

  private static func read<Value: WireValue>(
    _ value: JSONValue, as type: Value.Type, at path: JSONPath,
    _ rule: (Value, JSONPath, inout FindingCollector) -> Void, into collector: inout FindingCollector
  ) {
    do throws(WireError) {
      rule(try Value(wire: value), path, &collector)
    } catch {
      // What an object lacks is the schema's finding, which knows that a preset may supply it.
      switch error {
      case .missingMember(_, .root), .nullMember(_, .root): return
      default: break
      }
      // A fault inside a nested object that names its own type is reported there, once.
      var inner = value
      for component in error.path.components {
        guard let next = inner[JSONPath([component])] else { break }
        inner = next
        if let name = inner["type_identifier"]?.stringValue, registry[TypeIdentifier(rawValue: name)] != nil { return }
      }
      guard let name = value["type_identifier"]?.stringValue else { return }
      let place = JSONPath(path.components + error.path.components)
      collector.report(.unreadable(type: TypeIdentifier(rawValue: name), error), at: place)
    }
  }

  private static let body: @Sendable (TextBody, JSONPath, inout FindingCollector) -> Void = { body, path, collector in
    guard case .paragraphs(let paragraphs) = body.form else { return }
    for (index, paragraph) in paragraphs.dropLast().enumerated() where paragraph.breakType == .unterminated {
      let place = path.member("paragraphs").index(index).member("break_type")
      collector.report(.unterminatedParagraphBeforeLast, at: place)
    }
  }

  private static let paragraph: @Sendable (Paragraph, JSONPath, inout FindingCollector) -> Void = {
    paragraph, path, collector in
    for (index, content) in (paragraph.contents ?? []).enumerated() {
      guard let run = content.textRun, let scalar = ParagraphSeparator.first(in: run.string) else { continue }
      var place = path.member("contents").index(index)
      if case .hyperlink = content.form { place = place.member("hyperlink") }
      collector.report(.paragraphSeparatorInRun(scalar: scalar.value), at: place.member("run").member("string"))
    }
    if let level = paragraph.listLevel, !(0...8).contains(level) {
      collector.report(.listLevelOutOfRange(level), at: path.member("list_level"))
    }
    if let start = paragraph.listStart, !(0...4_294_967_295).contains(start) {
      collector.report(.listStartOutOfRange(start), at: path.member("list_start"))
    }
  }

  private static let paragraphProperties: @Sendable (ParagraphProperties, JSONPath, inout FindingCollector) -> Void = {
    properties, path, collector in
    if let level = properties.outlineLevel.value, !(-1...999).contains(level) {
      collector.report(.outlineLevelOutOfRange(level), at: path.member("outline_level"))
    }
  }

  private static let tabStop: @Sendable (TabStop, JSONPath, inout FindingCollector) -> Void = { stop, path, collector in
    if stop.position <= 0 { collector.report(.tabStopNotPositive, at: path.member("position")) }
  }

  private static let list: @Sendable (ListProperties, JSONPath, inout FindingCollector) -> Void = {
    list, path, collector in
    if let levels = list.levels.value, levels.count > 9 {
      collector.report(.tooManyListLevels(levels.count), at: path.member("levels"))
    }
  }

  private static let link: @Sendable (Hyperlink, JSONPath, inout FindingCollector) -> Void = { link, path, collector in
    switch link.form {
    case .url(let text):
      if text.allSatisfy(\.isWhitespace) {
        collector.report(.emptyLinkTarget, at: path.member("url"))
      } else if text.lowercased().hasPrefix("file:") {
        collector.report(.fileURLAsLinkURL, at: path.member("url"))
      }
    case .file(let text):
      if text.allSatisfy(\.isWhitespace) { collector.report(.emptyLinkTarget, at: path.member("file")) }
    case .program, .slideJump, nil:
      break
    }
  }

  private static let target: @Sendable (SlideTarget, JSONPath, inout FindingCollector) -> Void = {
    target, path, collector in
    if case .byIdentifier(let identifier) = target.form {
      collector.references.append((identifier.rawValue, path.member("by_identifier")))
    }
  }

  private static let unequalColumns: @Sendable (UnequalColumns, JSONPath, inout FindingCollector) -> Void = {
    columns, path, collector in
    let gutters = columns.gutterWidths ?? []
    if gutters.count != columns.columnWidths.count - 1 {
      collector.report(
        .columnGuttersMismatch(columns: columns.columnWidths.count, gutters: gutters.count),
        at: path.member("gutter_widths"))
    }
    let total = (columns.columnWidths + gutters).reduce(0, +)
    if abs(total - 100) > 0.000_001 { collector.report(.columnWidthsTotal(total), at: path.member("column_widths")) }
  }

  private static let gradient: @Sendable (GradientFill, JSONPath, inout FindingCollector) -> Void = {
    gradient, path, collector in
    if gradient.stops.count < 2 {
      collector.report(.tooFewGradientStops(gradient.stops.count), at: path.member("stops"))
    }
    for (index, pair) in zip(gradient.stops, gradient.stops.dropFirst()).enumerated()
    where pair.1.fraction < pair.0.fraction {
      collector.report(.gradientStopsOutOfOrder, at: path.member("stops").index(index + 1).member("fraction"))
    }
  }

  private static let linear: @Sendable (LinearFlavor, JSONPath, inout FindingCollector) -> Void = {
    linear, path, collector in
    let given = [linear.startPoint != nil, linear.endPoint != nil, linear.baseNaturalSize != nil]
    if given.contains(true), given.contains(false) { collector.report(.incompleteLinearGradient, at: path) }
  }

  private static let numberFormat: @Sendable (ListNumberFormat, JSONPath, inout FindingCollector) -> Void = {
    format, path, collector in
    let kind = format.kind ?? .numeric
    let takesCapitals = kind == .roman || kind == .alpha
    let hasFormalForm = kind == .japanese || kind == .simplifiedChinese || kind == .traditionalChinese
    let decoration = format.format ?? .decimal
    if (format.upper == true && !takesCapitals) || (format.formal == true && !hasFormalForm)
      || (decoration == .circled && kind != .numeric) || (decoration == .standard && kind != .hebrewBiblical)
    {
      collector.report(.unsupportedNumberFormat, at: path)
    }
  }

  private static let premium: @Sendable (PremiumResourceInfo, JSONPath, inout FindingCollector) -> Void = {
    info, path, collector in
    if UUID(uuidString: info.assetUUID) == nil { collector.report(.invalidAssetUUID, at: path.member("asset_uuid")) }
  }

  private static let embedded: @Sendable (EmbeddedResource, JSONPath, inout FindingCollector) -> Void = {
    resource, path, collector in
    if (try? resource.decodedData()) == nil || resource.string.isEmpty {
      collector.report(.invalidBase64, at: path.member("string"))
    }
    if resource.filename.allSatisfy(\.isWhitespace) {
      collector.report(.blankResourceName(member: "filename"), at: path.member("filename"))
    }
  }
}
