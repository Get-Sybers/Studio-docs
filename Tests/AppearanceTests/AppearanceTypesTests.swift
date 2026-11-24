import Appearance
import Foundation
import GoldenFiles
import JSONTree
import ModelFixtures
import Testing
import WireFormat

@Suite struct AppearanceTypesTests {
  static let types: [ModelledType] = [
    ModelledType(ColorValue.self), ModelledType(RGBAColor.self), ModelledType(Fill.self),
    ModelledType(GradientFill.self), ModelledType(GradientStop.self), ModelledType(GradientFlavor.self),
    ModelledType(LinearFlavor.self), ModelledType(RadialFlavor.self), ModelledType(ImageFill.self),
    ModelledType(PositionValue.self), ModelledType(SizeValue.self), ModelledType(OffsetValue.self),
    ModelledType(Insets.self), ModelledType(Shadow.self), ModelledType(ContactShadow.self),
    ModelledType(CurvedShadow.self), ModelledType(DropShadow.self), ModelledType(Stroke.self),
    ModelledType(LineStroke.self), ModelledType(PictureFrame.self), ModelledType(TextStroke.self),
  ]

  let goldens: GoldenFile
  let fixtures: FixtureFile

  init() throws {
    goldens = try GoldenFile(named: "appearance", in: .module)
    fixtures = try FixtureFile(named: "appearance", in: .module)
  }

  @Test(arguments: types)
  func readsAndWritesEveryMember(_ type: ModelledType) throws {
    let result = ModelCheck.roundTrip(type, sample: try fixtures.sample(type.name))
    #expect(result.defects == [])
    let got = String(decoding: try result.written.text(.readable), as: UTF8.self)
    #expect(got == (try goldens.want("type: \(type.name)", got: got)))
  }

  @Test func theTableListsWhatTheTargetModels() {
    #expect(ModelCheck.agreement(types: Self.types, fixtures: fixtures, table: AppearanceFormat.table) == [])
  }

  @Test func theTableListsTheValuesOfEveryEnumeration() {
    let table = AppearanceFormat.table
    var defects = ModelCheck.agreement([RGBColorSpace.p3, .srgb], table: table)
    defects += ModelCheck.agreement(
      [ImageFillTechnique.naturalSize, .scaleToFill, .scaleToFit, .stretch, .tile], table: table)
    defects += ModelCheck.agreement(
      [
        StrokePattern.calligraphy, .chalk, .dryBrush, .featheredBrush, .longDash, .mediumDash, .pen, .roundDash,
        .shortDash, .solid,
      ], table: table)
    defects += ModelCheck.agreement(
      [
        PictureFrameName.antique, .crayonLine, .formalInset, .formalShadow, .graphPaper, .headlines, .jetSet,
        .photoPortfolio1, .portfolioInset, .pushpin, .renaissance1, .scrapbook2b, .storyboard, .vintageInset,
      ], table: table)
    #expect(defects == [])
    #expect(table.enumerations.count == 4)
  }

  @Test func aColourIsBuiltFromItsParts() throws {
    let fill = Fill.color(.rgba(RGBAColor(red: 0, green: 0.478, blue: 1, alpha: 1, colorSpace: .srgb)))
    let got = String(decoding: try fill.wireValue.text(), as: UTF8.self)
    #expect(got == (try goldens.want("built: a blue fill", got: got)))
  }

  @Test func aFormWithNoContentsIsItsNameAlone() {
    #expect(Stroke.empty.wireValue == "empty")
    #expect(TextStroke.unstroked.wireValue == "none")
    #expect(Shadow.unshadowed.wireValue == "none")
    #expect(
      TextStroke.stroke(.empty).wireValue == [
        "stroke": "empty", "type_identifier": "com.apple.apps.content-language.text-stroke",
      ])
  }

  @Test func aLaterMemberUnderAnEarlierVersionIsKeptUnread() throws {
    let colour = try RGBAColor(wire: ["red": 1, "headroom": 4, "version": "1.0"])
    #expect(colour.headroom == nil)
    #expect(colour.wireValue["headroom"] == 4)
    #expect(colour.wireValue["version"] == "1.0")
    #expect(try RGBAColor(wire: ["red": 1, "headroom": 4]).headroom == 4)
  }

  @Test func aUnionMayAdoptAPresetAndTakeNoForm() throws {
    let fill = try Fill(wire: ["preset_identifier": "paper"])
    #expect(fill.form == nil)
    #expect(fill.presetIdentifier == "paper")
    #expect(fill.wireValue["preset_identifier"] == "paper")
  }
}
