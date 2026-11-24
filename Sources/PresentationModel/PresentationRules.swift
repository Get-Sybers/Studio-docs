import CanvasCommon
import CanvasModel
import ChartModel
import DocumentValidation
import Foundation
import JSONTree
import TableModel
import WireFormat

/// The rules of a presentation beyond its schemas: layouts, placeholders, connection lines, tables and charts.
enum PresentationRules {
  static func findings(of presentation: Presentation) -> [ValidationFinding] {
    var findings: [ValidationFinding] = []
    let layouts = presentation.theme?.slideLayouts ?? []
    for (index, layout) in layouts.enumerated() {
      let path = JSONPath.root.member("theme").member("slide_layouts").index(index)
      check(placeholders: layout.contents, at: path, into: &findings)
      check(
        objects: layout.contents?.map { $0.object } ?? [], at: path.member("contents"), inSlide: true, into: &findings)
    }
    for (index, slide) in presentation.slides.enumerated() {
      let path = JSONPath.root.member("slides").index(index)
      if let name = slide.layout, !layouts.isEmpty, !layouts.contains(where: { Self.matches($0, name) }) {
        findings.append(ValidationFinding(.unknownSlideLayout(name), in: .main, at: path.member("layout")))
      }
      check(placeholders: slide.contents, at: path, into: &findings)
      check(
        objects: slide.contents?.map { $0.object } ?? [], at: path.member("contents"), inSlide: true, into: &findings)
    }
    return findings
  }

  /// A layout is named by its identifier or by its name, with no regard to case, width or diacritics.
  private static func matches(_ layout: SlideLayout, _ name: String) -> Bool {
    layout.identifier?.rawValue == name
      || layout.name.compare(name, options: [.caseInsensitive, .diacriticInsensitive, .widthInsensitive])
        == .orderedSame
  }

  private static func check(placeholders: [SlideObject]?, at path: JSONPath, into findings: inout [ValidationFinding]) {
    var kinds: Set<String> = []
    for (index, object) in (placeholders ?? []).enumerated() {
      guard case .defined(let definition) = object.placeholderInfo?.form else { continue }
      guard kinds.insert(definition.kind.rawValue).inserted else {
        let place = path.member("contents").index(index).member("placeholder_info").member("defined").member("kind")
        findings.append(ValidationFinding(.repeatedPlaceholderKind(definition.kind.rawValue), in: .main, at: place))
        continue
      }
    }
  }

  /// Checks the objects that stand together on a slide, a layout or in a group; `inSlide` says each sits in a slide object.
  private static func check(
    objects: [CanvasObject], at path: JSONPath, inSlide: Bool, into findings: inout [ValidationFinding]
  ) {
    var siblings: Set<String> = []
    var places: [(JSONPath, CanvasObject.Form)] = []
    for (index, object) in objects.enumerated() {
      guard let form = object.form else { continue }
      let (name, _) = CanvasObject.member(for: form)
      let place = (inSlide ? path.index(index).member("object") : path.index(index)).member(name)
      if let identifier = Self.identifier(of: form) { siblings.insert(identifier) }
      places.append((place, form))
    }
    for (place, form) in places {
      switch form {
      case .connectionLine(let line):
        for (end, name) in [(line.tail.value, "tail"), (line.head.value, "head")] {
          if end.endPoint == nil {
            findings.append(
              ValidationFinding(.connectionLineEndWithoutPoint, in: .main, at: place.member(name).member("end_point")))
          }
          if let anchor = end.anchor, !siblings.contains(anchor.objectId) {
            let at = place.member(name).member("anchor").member("object_id")
            findings.append(
              ValidationFinding(.anchorNotASibling(ObjectID(rawValue: anchor.objectId)), in: .main, at: at))
          }
        }
      case .group(let group):
        check(objects: group.children, at: place.member("children"), inSlide: false, into: &findings)
      case .table(let table):
        TableRules.check(table, at: place, into: &findings)
      case .chart(let chart):
        if case .twoAxis(let twoAxis) = chart.form {
          for (index, series) in (twoAxis.series ?? []).enumerated() {
            guard let selection = series.yAxisSelection, selection != 0, selection != 1 else { continue }
            let at = place.member("two_axis").member("series").index(index).member("y_axis_selection")
            findings.append(ValidationFinding(.yAxisSelectionOutOfRange(selection), in: .main, at: at))
          }
        }
      case .audio, .genericCanvasObject, .image, .movie, .shape, .textbox:
        break
      }
    }
  }

  private static func identifier(of form: CanvasObject.Form) -> String? {
    switch form {
    case .audio(let object): object.identifier?.rawValue
    case .chart(let chart): chart.envelope.identifier?.rawValue
    case .connectionLine(let object): object.identifier?.rawValue
    case .genericCanvasObject(let object): object.identifier?.rawValue
    case .group(let object): object.identifier?.rawValue
    case .image(let object): object.identifier?.rawValue
    case .movie(let object): object.identifier?.rawValue
    case .shape(let object): object.identifier?.rawValue
    case .table(let object): object.identifier?.rawValue
    case .textbox(let object): object.identifier?.rawValue
    }
  }
}
