import Appearance
import CanvasCommon
import CanvasModel
import ChartModel
import DocumentPackage
import DocumentValidation
import Foundation
import GoldenFiles
import JSONTree
import PresentationModel
import TableModel
import Testing
import TextModel
import WireFormat

struct RuleCase: Sendable, CustomTestStringConvertible {
  var name: String
  var presentation: @Sendable () -> Presentation
  var testDescription: String { name }

  static func slide(_ objects: [CanvasObject], layout: String? = nil) -> Slide {
    Slide(layout: layout, contents: objects.map { SlideObject(object: $0) })
  }

  static func named<Object: WireObject>(_ object: Object, _ identifier: ObjectID) -> Object {
    var object = object
    object.identifier = identifier
    return object
  }

  static let theme = KeynoteTheme(slideLayouts: [SlideLayout(name: "Title & Subtitle"), SlideLayout(name: "Blank")])

  static let all: [RuleCase] = [
    RuleCase(name: "a layout the theme does not hold") {
      Presentation(theme: theme, slides: [slide([], layout: "Photo")])
    },
    RuleCase(name: "a layout matched without regard to case or diacritics") {
      Presentation(theme: theme, slides: [slide([], layout: "title & subtítle")])
    },
    RuleCase(name: "no theme, so any layout name passes") {
      Presentation(slides: [slide([], layout: "Photo")])
    },
    RuleCase(name: "two placeholders of one kind") {
      var first = SlideObject(object: .textbox(Textbox()))
      first.placeholderInfo = .defined(PlaceholderDefinition(kind: .title))
      var second = SlideObject(object: .textbox(Textbox()))
      second.placeholderInfo = .defined(PlaceholderDefinition(kind: .title))
      return Presentation(slides: [Slide(contents: [first, second])])
    },
    RuleCase(name: "a connection line without an end point, anchored beside and beyond its siblings") {
      let tail = ConnectionEnd(anchor: ConnectionAnchor(objectId: "box-1"))
      let head = ConnectionEnd(endPoint: PositionValue(x: 10, y: 10), anchor: ConnectionAnchor(objectId: "elsewhere"))
      let line = ConnectionLine(tail: tail, head: head)
      return Presentation(slides: [slide([.textbox(named(Textbox(), "box-1")), .connectionLine(line)])])
    },
    RuleCase(name: "a connection line inside a group anchored to its sibling") {
      let end = ConnectionEnd(endPoint: PositionValue(x: 0, y: 0), anchor: ConnectionAnchor(objectId: "shape-1"))
      let group = Group(children: [
        .shape(named(Shape(), "shape-1")), .connectionLine(ConnectionLine(tail: end, head: end)),
      ])
      return Presentation(slides: [slide([.group(group)])])
    },
    RuleCase(name: "table rows out of range and not rising, with a repeated column") {
      var table = Table(numberOfColumns: 2, numberOfRows: 2)
      table.columnHeaders = [ColumnHeader(columnIdentifier: "c"), ColumnHeader(columnIdentifier: "c")]
      table.content = [
        TableRow(rowIndex: 1, cells: [TableCell(columnIndex: 0), TableCell(columnIndex: 0), TableCell()]),
        TableRow(rowIndex: 1), TableRow(),
      ]
      return Presentation(slides: [slide([.table(table)])])
    },
    RuleCase(name: "a cell naming a style set and a custom format the table lacks") {
      var cell = TableCell(conditionalStyleSetIdentifier: "stripes")
      cell.cellFormat = Indirect(CellFormat(formatType: .custom, customFormatIdentifier: "tides"))
      var table = Table(numberOfColumns: 1, numberOfRows: 1)
      table.content = [TableRow(cells: [cell])]
      return Presentation(slides: [slide([.table(table)])])
    },
    RuleCase(name: "a merge beyond the rows and columns of the table") {
      var table = Table(numberOfColumns: 1, numberOfRows: 1)
      table.columnHeaders = [ColumnHeader(columnIdentifier: "c-1")]
      table.content = [TableRow(rowIdentifier: "r-1")]
      table.merges = [
        .rowColumnIdRange(
          RowColumnIdRange(
            topLeftRowIdentifier: "r-1", topLeftColumnIdentifier: "c-1", bottomRightRowIdentifier: "r-9",
            bottomRightColumnIdentifier: "c-9"))
      ]
      return Presentation(slides: [slide([.table(table)])])
    },
    RuleCase(name: "a two-axis series selecting a third axis") {
      let chart = TwoAxisChart(series: [ChartSeries(yAxisSelection: 1), ChartSeries(yAxisSelection: 2)])
      return Presentation(slides: [slide([.chart(.twoAxis(chart))])])
    },
  ]
}

@Suite struct PresentationRulesTests {
  let goldens: GoldenFile

  init() throws {
    goldens = try GoldenFile(named: "presentation-model", in: .module)
  }

  @Test(arguments: RuleCase.all)
  func findsWhatBreaksTheRules(_ item: RuleCase) throws {
    let report = StudioDocument(body: item.presentation()).validate()
    let got = report.findings.map(\.description).joined(separator: "\n")
    #expect(got == (try goldens.want("rules: \(item.name)", got: got)))
  }

  @Test func anObjectASlideTakesFromItsLayoutMayRepeatTheLayoutsIdentifier() {
    let box = RuleCase.named(Textbox(), "layout-title")
    let layout = SlideLayout(name: "Title", contents: [SlideObject(object: .textbox(box))])
    var copy = SlideObject(object: .textbox(box))
    copy.sourceKind = .layout
    var own = SlideObject(object: .textbox(box))
    own.sourceKind = .user
    let theme = KeynoteTheme(slideLayouts: [layout])
    let accepted = Presentation(theme: theme, slides: [Slide(layout: "Title", contents: [copy])])
    #expect(StudioDocument(body: accepted).validate().findings == [])
    let repeated = Presentation(theme: theme, slides: [Slide(layout: "Title", contents: [own])])
    #expect(
      StudioDocument(body: repeated).validate().errors.map(\.kind) == [
        .duplicateIdentifier(
          "layout-title",
          first: JSONPath.root.member("theme").member("slide_layouts").index(0).member("contents").index(0).member(
            "object"
          ).member("textbox"))
      ])
  }
}
