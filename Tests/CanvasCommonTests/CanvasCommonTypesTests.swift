import Appearance
import CanvasCommon
import Foundation
import GoldenFiles
import JSONTree
import ModelFixtures
import Testing
import TextModel
import WireFormat

@Suite struct CanvasCommonTypesTests {
  static let types: [ModelledType] = [
    ModelledType(GenericCaptionOwning.self),
    ModelledType(GenericPlaceableTitleOwning.self),
    ModelledType(GenericTitleOwning.self),
    ModelledType(Geometry.self),
    ModelledType(Label.self),
    ModelledType(Reflection.self),
    ModelledType(CaptionOwning.self),
    ModelledType(DurationValue.self),
    ModelledType(PlaceableTitleOwning.self),
    ModelledType(TitleOwning.self),
  ]

  let goldens: GoldenFile
  let fixtures: FixtureFile

  init() throws {
    goldens = try GoldenFile(named: "canvas-common", in: .module)
    fixtures = try FixtureFile(named: "canvas-common", in: .module)
  }

  @Test(arguments: types)
  func readsAndWritesEveryMember(_ type: ModelledType) throws {
    let result = ModelCheck.roundTrip(type, sample: try fixtures.sample(type.name))
    #expect(result.defects == [])
    let got = String(decoding: try result.written.text(.readable), as: UTF8.self)
    #expect(got == (try goldens.want("type: \(type.name)", got: got)))
  }

  @Test func theTableListsWhatTheTargetModels() {
    #expect(ModelCheck.agreement(types: Self.types, fixtures: fixtures, table: CanvasCommonFormat.table) == [])
  }

  @Test func theTableListsTheValuesOfEveryEnumeration() {
    let table = CanvasCommonFormat.table
    var defects: [String] = []
    defects += ModelCheck.agreement(
      [
        LineEnd.filledArrow, .filledCircle, .filledDiamond, .filledSquare, .invertedArrow, .line, .off, .openArrow,
        .openCircle, .openSquare, .simpleArrow,
      ], table: table)
    #expect(defects == [])
    #expect(table.enumerations.count == 1)
  }

  // A value this large on the stack overflows a secondary thread once a few calls nest.
  @Test func theModelTypesStaySmallEnoughToPassByValue() {
    let sizes: [(String, Int)] = [
      ("GenericCaptionOwning", MemoryLayout<GenericCaptionOwning>.size),
      ("GenericPlaceableTitleOwning", MemoryLayout<GenericPlaceableTitleOwning>.size),
      ("GenericTitleOwning", MemoryLayout<GenericTitleOwning>.size),
      ("Geometry", MemoryLayout<Geometry>.size),
      ("Label", MemoryLayout<Label>.size),
      ("Reflection", MemoryLayout<Reflection>.size),
      ("CaptionOwning", MemoryLayout<CaptionOwning>.size),
      ("DurationValue", MemoryLayout<DurationValue>.size),
      ("PlaceableTitleOwning", MemoryLayout<PlaceableTitleOwning>.size),
      ("TitleOwning", MemoryLayout<TitleOwning>.size),
    ]
    #expect(sizes.filter { $0.1 > 2048 }.map(\.0) == [])
  }
}
