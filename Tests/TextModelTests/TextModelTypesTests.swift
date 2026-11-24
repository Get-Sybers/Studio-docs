import Foundation
import GoldenFiles
import JSONTree
import ModelFixtures
import Testing
import TextModel
import WireFormat

@Suite struct TextModelTypesTests {
  static let types: [ModelledType] = [
    ModelledType(TextBody.self), ModelledType(Paragraph.self), ModelledType(ParagraphContent.self),
    ModelledType(HyperlinkField.self), ModelledType(Hyperlink.self), ModelledType(SlideTarget.self),
    ModelledType(TextRun.self), ModelledType(CharacterProperties.self), ModelledType(FontFeature.self),
    ModelledType(ParagraphProperties.self), ModelledType(LineSpacing.self), ModelledType(ParagraphBorders.self),
    ModelledType(TabStop.self), ModelledType(ListProperties.self), ModelledType(ListLevel.self),
    ModelledType(ListLabel.self), ModelledType(ListNumberLabel.self), ModelledType(ListStringLabel.self),
    ModelledType(ListImageLabel.self), ModelledType(ListNumberFormat.self), ModelledType(TextLayoutProperties.self),
    ModelledType(ColumnMetrics.self), ModelledType(EqualColumns.self), ModelledType(UnequalColumns.self),
    ModelledType(Stylesheet.self), ModelledType(NamedCharacterStyle.self), ModelledType(NamedParagraphStyle.self),
    ModelledType(NamedListStyle.self),
  ]

  let goldens: GoldenFile
  let fixtures: FixtureFile

  init() throws {
    goldens = try GoldenFile(named: "text-model", in: .module)
    fixtures = try FixtureFile(named: "text-model", in: .module)
  }

  @Test(arguments: types)
  func readsAndWritesEveryMember(_ type: ModelledType) throws {
    let result = ModelCheck.roundTrip(type, sample: try fixtures.sample(type.name))
    #expect(result.defects == [])
    let got = String(decoding: try result.written.text(.readable), as: UTF8.self)
    #expect(got == (try goldens.want("type: \(type.name)", got: got)))
  }

  @Test func theTableListsWhatTheTargetModels() {
    #expect(ModelCheck.agreement(types: Self.types, fixtures: fixtures, table: TextFormat.table) == [])
  }

  @Test func theTableListsTheValuesOfEveryEnumeration() {
    let table = TextFormat.table
    var defects = ModelCheck.agreement([Baseline.normal, .subscripted, .superscripted], table: table)
    defects += ModelCheck.agreement([Capitalization.allCaps, .asWritten, .smallCaps, .start, .title], table: table)
    defects += ModelCheck.agreement([Ligatures.all, .required, .standard], table: table)
    defects += ModelCheck.agreement([StrikethroughStyle.double, .off, .single], table: table)
    defects += ModelCheck.agreement([UnderlineStyle.double, .off, .single, .wavy], table: table)
    defects += ModelCheck.agreement([WritingDirection.leftToRight, .natural, .rightToLeft], table: table)
    defects += ModelCheck.agreement([ParagraphAlignment.center, .justified, .left, .natural, .right], table: table)
    defects += ModelCheck.agreement([LineSpacingKind.between, .exact, .maximum, .minimum, .relative], table: table)
    defects += ModelCheck.agreement([TabAlignment.center, .decimal, .left, .right], table: table)
    defects += ModelCheck.agreement(
      [ParagraphBreak.column, .unterminated, .nontopic, .page, .paragraph, .section], table: table)
    defects += ModelCheck.agreement(
      [
        NumberingSystem.alpha, .arabian, .arabianAbjad, .arabianAlpha, .hebrew, .hebrewBiblical, .hiragana,
        .hiraganaIroha, .japanese, .katakana, .katakanaIroha, .korean, .numeric, .roman, .simplifiedChinese,
        .traditionalChinese,
      ], table: table)
    defects += ModelCheck.agreement(
      [NumberDecoration.circled, .decimal, .doubleParen, .paren, .standard], table: table)
    defects += ModelCheck.agreement([VerticalTextAlignment.bottom, .center, .top], table: table)
    #expect(defects == [])
    #expect(table.enumerations.count == 13)
  }
}
