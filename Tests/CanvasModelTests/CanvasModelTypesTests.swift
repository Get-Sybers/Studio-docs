import Appearance
import CanvasCommon
import CanvasModel
import ChartModel
import Foundation
import GoldenFiles
import JSONTree
import ModelFixtures
import ResourceReferences
import TableModel
import Testing
import TextModel
import WireFormat

@Suite struct CanvasModelTypesTests {
  static let types: [ModelledType] = [
    ModelledType(Audio.self),
    ModelledType(BezierPath.self),
    ModelledType(ConnectionAnchor.self),
    ModelledType(ConnectionEnd.self),
    ModelledType(ConnectionLine.self),
    ModelledType(GenericCanvasObject.self),
    ModelledType(Group.self),
    ModelledType(Image.self),
    ModelledType(ImageMask.self),
    ModelledType(InstantAlphaPath.self),
    ModelledType(Movie.self),
    ModelledType(PlaybackOptions.self),
    ModelledType(Rect.self),
    ModelledType(Shape.self),
    ModelledType(Textbox.self),
    ModelledType(AnchorMagnet.self),
    ModelledType(CanvasObject.self),
    ModelledType(ConnectionLineKind.self),
    ModelledType(Path.self),
  ]

  let goldens: GoldenFile
  let fixtures: FixtureFile

  init() throws {
    goldens = try GoldenFile(named: "canvas-model", in: .module)
    fixtures = try FixtureFile(named: "canvas-model", in: .module)
  }

  @Test(arguments: types)
  func readsAndWritesEveryMember(_ type: ModelledType) throws {
    let result = ModelCheck.roundTrip(type, sample: try fixtures.sample(type.name))
    #expect(result.defects == [])
    let got = String(decoding: try result.written.text(.readable), as: UTF8.self)
    #expect(got == (try goldens.want("type: \(type.name)", got: got)))
  }

  @Test func theTableListsWhatTheTargetModels() {
    #expect(ModelCheck.agreement(types: Self.types, fixtures: fixtures, table: CanvasModelFormat.table) == [])
  }

  @Test func theTableListsTheValuesOfEveryEnumeration() {
    let table = CanvasModelFormat.table
    var defects: [String] = []
    defects += ModelCheck.agreement([LoopOption.backAndForth, .off, .repeating], table: table)
    #expect(defects == [])
    #expect(table.enumerations.count == 1)
  }

  // A value this large on the stack overflows a secondary thread once a few calls nest.
  @Test func theModelTypesStaySmallEnoughToPassByValue() {
    let sizes: [(String, Int)] = [
      ("Audio", MemoryLayout<Audio>.size),
      ("BezierPath", MemoryLayout<BezierPath>.size),
      ("ConnectionAnchor", MemoryLayout<ConnectionAnchor>.size),
      ("ConnectionEnd", MemoryLayout<ConnectionEnd>.size),
      ("ConnectionLine", MemoryLayout<ConnectionLine>.size),
      ("GenericCanvasObject", MemoryLayout<GenericCanvasObject>.size),
      ("Group", MemoryLayout<Group>.size),
      ("Image", MemoryLayout<Image>.size),
      ("ImageMask", MemoryLayout<ImageMask>.size),
      ("InstantAlphaPath", MemoryLayout<InstantAlphaPath>.size),
      ("Movie", MemoryLayout<Movie>.size),
      ("PlaybackOptions", MemoryLayout<PlaybackOptions>.size),
      ("Rect", MemoryLayout<Rect>.size),
      ("Shape", MemoryLayout<Shape>.size),
      ("Textbox", MemoryLayout<Textbox>.size),
      ("AnchorMagnet", MemoryLayout<AnchorMagnet>.size),
      ("CanvasObject", MemoryLayout<CanvasObject>.size),
      ("ConnectionLineKind", MemoryLayout<ConnectionLineKind>.size),
      ("Path", MemoryLayout<Path>.size),
    ]
    #expect(sizes.filter { $0.1 > 2048 }.map(\.0) == [])
  }
}
