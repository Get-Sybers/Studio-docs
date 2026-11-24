import Appearance
import CanvasCommon
import CanvasModel
import DocumentPackage
import Foundation
import GoldenFiles
import JSONTree
import ModelFixtures
import PresentationModel
import TableModel
import Testing
import TextModel
import WireFormat

@Suite struct PresentationModelTypesTests {
  static let types: [ModelledType] = [
    ModelledType(BodyStrokeStyle.self),
    ModelledType(CellStyle.self),
    ModelledType(HeaderFooterStrokeStyle.self),
    ModelledType(KeynoteTheme.self),
    ModelledType(MediaProperties.self),
    ModelledType(MediaStyle.self),
    ModelledType(OverallStyle.self),
    ModelledType(PlaceholderDefinition.self),
    ModelledType(Presentation.self),
    ModelledType(ShapeProperties.self),
    ModelledType(ShapeStyle.self),
    ModelledType(Slide.self),
    ModelledType(SlideLayout.self),
    ModelledType(SlideObject.self),
    ModelledType(TableStyleCollection.self),
    ModelledType(PlaceholderInfo.self),
    ModelledType(SlideBackground.self),
  ]

  let goldens: GoldenFile
  let fixtures: FixtureFile

  init() throws {
    goldens = try GoldenFile(named: "presentation-model", in: .module)
    fixtures = try FixtureFile(named: "presentation-model", in: .module)
  }

  @Test(arguments: types)
  func readsAndWritesEveryMember(_ type: ModelledType) throws {
    let result = ModelCheck.roundTrip(type, sample: try fixtures.sample(type.name))
    #expect(result.defects == [])
    let got = String(decoding: try result.written.text(.readable), as: UTF8.self)
    #expect(got == (try goldens.want("type: \(type.name)", got: got)))
  }

  @Test func theTableListsWhatTheTargetModels() {
    #expect(ModelCheck.agreement(types: Self.types, fixtures: fixtures, table: PresentationModelFormat.table) == [])
  }

  @Test func theTableListsTheValuesOfEveryEnumeration() {
    let table = PresentationModelFormat.table
    var defects: [String] = []
    defects += ModelCheck.agreement([PlaceholderKind.body, .object, .slideNumber, .title], table: table)
    defects += ModelCheck.agreement([SourceKind.layout, .placeholder, .user], table: table)
    #expect(defects == [])
    #expect(table.enumerations.count == 2)
  }

  // A value this large on the stack overflows a secondary thread once a few calls nest.
  @Test func theModelTypesStaySmallEnoughToPassByValue() {
    let sizes: [(String, Int)] = [
      ("BodyStrokeStyle", MemoryLayout<BodyStrokeStyle>.size),
      ("CellStyle", MemoryLayout<CellStyle>.size),
      ("HeaderFooterStrokeStyle", MemoryLayout<HeaderFooterStrokeStyle>.size),
      ("KeynoteTheme", MemoryLayout<KeynoteTheme>.size),
      ("MediaProperties", MemoryLayout<MediaProperties>.size),
      ("MediaStyle", MemoryLayout<MediaStyle>.size),
      ("OverallStyle", MemoryLayout<OverallStyle>.size),
      ("PlaceholderDefinition", MemoryLayout<PlaceholderDefinition>.size),
      ("Presentation", MemoryLayout<Presentation>.size),
      ("ShapeProperties", MemoryLayout<ShapeProperties>.size),
      ("ShapeStyle", MemoryLayout<ShapeStyle>.size),
      ("Slide", MemoryLayout<Slide>.size),
      ("SlideLayout", MemoryLayout<SlideLayout>.size),
      ("SlideObject", MemoryLayout<SlideObject>.size),
      ("TableStyleCollection", MemoryLayout<TableStyleCollection>.size),
      ("PlaceholderInfo", MemoryLayout<PlaceholderInfo>.size),
      ("SlideBackground", MemoryLayout<SlideBackground>.size),
    ]
    #expect(sizes.filter { $0.1 > 2048 }.map(\.0) == [])
  }
}
