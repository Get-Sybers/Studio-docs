import Appearance
import CanvasCommon
import Foundation
import GoldenFiles
import JSONTree
import ModelFixtures
import TableModel
import Testing
import TextModel
import WireFormat

@Suite struct TableModelTypesTests {
  static let types: [ModelledType] = [
    ModelledType(BaseFormat.self),
    ModelledType(BodyStrokeProperties.self),
    ModelledType(BoolFormat.self),
    ModelledType(CategoryRules.self),
    ModelledType(CellFormat.self),
    ModelledType(CellProperties.self),
    ModelledType(CellReference.self),
    ModelledType(CellStrokes.self),
    ModelledType(ColumnGroupLabel.self),
    ModelledType(ColumnHeader.self),
    ModelledType(ConditionalStyleRule.self),
    ModelledType(ConditionalStyleSet.self),
    ModelledType(CurrencyFormat.self),
    ModelledType(CustomFormat.self),
    ModelledType(CustomFormatCondition.self),
    ModelledType(DateTimeFormat.self),
    ModelledType(DurationFormat.self),
    ModelledType(FilterRule.self),
    ModelledType(FilterSet.self),
    ModelledType(FractionFormat.self),
    ModelledType(HeaderFooterStrokeProperties.self),
    ModelledType(IdBasedFormula.self),
    ModelledType(NumberFormat.self),
    ModelledType(NumberFormatData.self),
    ModelledType(OverallProperties.self),
    ModelledType(PivotRules.self),
    ModelledType(PredicateReference.self),
    ModelledType(RowColumnIdRange.self),
    ModelledType(RowGroupLabel.self),
    ModelledType(SortRule.self),
    ModelledType(StrokePreset.self),
    ModelledType(Table.self),
    ModelledType(TableCell.self),
    ModelledType(TableDate.self),
    ModelledType(TableFilter.self),
    ModelledType(TablePredicate.self),
    ModelledType(TableRow.self),
    ModelledType(TableSort.self),
    ModelledType(TableVisualProperties.self),
    ModelledType(TransformationInfo.self),
    ModelledType(CellFormula.self),
    ModelledType(CellRange.self),
    ModelledType(ColumnHeaderKind.self),
    ModelledType(PredicateValue.self),
    ModelledType(RowKind.self),
    ModelledType(TransformationStructure.self),
    ModelledType(UnformattedValue.self),
  ]

  let goldens: GoldenFile
  let fixtures: FixtureFile

  init() throws {
    goldens = try GoldenFile(named: "table-model", in: .module)
    fixtures = try FixtureFile(named: "table-model", in: .module)
  }

  @Test(arguments: types)
  func readsAndWritesEveryMember(_ type: ModelledType) throws {
    let result = ModelCheck.roundTrip(type, sample: try fixtures.sample(type.name))
    #expect(result.defects == [])
    let got = String(decoding: try result.written.text(.readable), as: UTF8.self)
    #expect(got == (try goldens.want("type: \(type.name)", got: got)))
  }

  @Test func theTableListsWhatTheTargetModels() {
    #expect(ModelCheck.agreement(types: Self.types, fixtures: fixtures, table: TableModelFormat.table) == [])
  }

  @Test func theTableListsTheValuesOfEveryEnumeration() {
    let table = TableModelFormat.table
    var defects: [String] = []
    defects += ModelCheck.agreement(
      [
        CellFormatType.automatic, .base, .boolean, .currency, .custom, .dateTime, .duration, .fraction, .number,
        .percentage, .scientific, .text,
      ], table: table)
    defects += ModelCheck.agreement([ColumnVisibility.userHidden, .visible], table: table)
    defects += ModelCheck.agreement(
      [
        ConditionalStylePreset.blueFill, .blueText, .bold, .custom, .grayText, .greenFill, .greenText, .italics,
        .orangeFill, .redFill, .redText, .tealFill, .yellowFill,
      ], table: table)
    defects += ModelCheck.agreement([CustomFormatType.dateTime, .number, .text], table: table)
    defects += ModelCheck.agreement(
      [DateQualifier.ago, .days, .fromNow, .months, .quarters, .weeks, .years], table: table)
    defects += ModelCheck.agreement(
      [DurationFormatUnit.day, .hour, .millisecond, .minute, .off, .second, .week], table: table)
    defects += ModelCheck.agreement([DurationStyle.compact, .long, .short], table: table)
    defects += ModelCheck.agreement([FilterCombination.and, .or], table: table)
    defects += ModelCheck.agreement(
      [FormatConditionType.equal, .greaterThan, .greaterThanOrEqualTo, .lessThan, .lessThanOrEqualTo], table: table)
    defects += ModelCheck.agreement(
      [
        FractionAccuracy.conflicting, .eighths, .halves, .hundredths, .quarters, .sixteenths, .tenths, .upToOneDigit,
        .upToThreeDigits, .upToTwoDigits,
      ], table: table)
    defects += ModelCheck.agreement(
      [NegativeNumberStyle.minus, .off, .parentheses, .red, .redAndParentheses], table: table)
    defects += ModelCheck.agreement(
      [PredicateDurationUnit.day, .hour, .millisecond, .minute, .second, .week], table: table)
    defects += ModelCheck.agreement(
      [
        PredicateType.dateAfterRelative, .dateBeforeRelative, .dateBetweenRelative, .dateInThis, .dateIsAfter,
        .dateIsBefore, .dateIsBetween, .dateIsExactly, .dateIsInTheLast, .dateIsInTheNext, .dateIsTheDate, .dateIsToday,
        .dateIsTomorrow, .dateIsYesterday, .distincts, .duplicates, .durationAboveAverage, .durationBelowAverage,
        .durationBottom, .durationIsBetween, .durationIsEqual, .durationIsGreaterThan, .durationIsGreaterThanOrEqual,
        .durationIsLessThan, .durationIsLessThanOrEqual, .durationIsNotBetween, .durationIsNotEqual, .durationTop,
        .formula, .inList, .isBlank, .isChecked, .isFalse, .isNegative, .isNotBlank, .isNotChecked, .isPositive,
        .isTrue, .notInList, .pivotSourceFilteredForColumn, .pivotSourceFilteredForRow, .textBeginsWith, .textContains,
        .textDoesNotContain, .textEndsWith, .textIs, .textIsNot, .textNotEndsWith, .textNotStartsWith, .uniques,
        .valueAboveAverage, .valueBelowAverage, .valueBetween, .valueBottom, .valueEqual, .valueGreaterThan,
        .valueGreaterThanOrEqual, .valueLessThan, .valueLessThanOrEqual, .valueNotBetween, .valueNotEqual, .valueTop,
      ], table: table)
    defects += ModelCheck.agreement([RowVisibility.filtered, .userHidden, .visible], table: table)
    defects += ModelCheck.agreement([SortDirection.ascending, .descending], table: table)
    defects += ModelCheck.agreement([SortScope.entireTable, .selectedRows], table: table)
    defects += ModelCheck.agreement([StrokeEdge.bottom, .horizontal, .left, .right, .top, .vertical], table: table)
    defects += ModelCheck.agreement([TextQualifier.caseInsensitive, .caseSensitive], table: table)
    #expect(defects == [])
    #expect(table.enumerations.count == 18)
  }

  // A value this large on the stack overflows a secondary thread once a few calls nest.
  @Test func theModelTypesStaySmallEnoughToPassByValue() {
    let sizes: [(String, Int)] = [
      ("BaseFormat", MemoryLayout<BaseFormat>.size),
      ("BodyStrokeProperties", MemoryLayout<BodyStrokeProperties>.size),
      ("BoolFormat", MemoryLayout<BoolFormat>.size),
      ("CategoryRules", MemoryLayout<CategoryRules>.size),
      ("CellFormat", MemoryLayout<CellFormat>.size),
      ("CellProperties", MemoryLayout<CellProperties>.size),
      ("CellReference", MemoryLayout<CellReference>.size),
      ("CellStrokes", MemoryLayout<CellStrokes>.size),
      ("ColumnGroupLabel", MemoryLayout<ColumnGroupLabel>.size),
      ("ColumnHeader", MemoryLayout<ColumnHeader>.size),
      ("ConditionalStyleRule", MemoryLayout<ConditionalStyleRule>.size),
      ("ConditionalStyleSet", MemoryLayout<ConditionalStyleSet>.size),
      ("CurrencyFormat", MemoryLayout<CurrencyFormat>.size),
      ("CustomFormat", MemoryLayout<CustomFormat>.size),
      ("CustomFormatCondition", MemoryLayout<CustomFormatCondition>.size),
      ("DateTimeFormat", MemoryLayout<DateTimeFormat>.size),
      ("DurationFormat", MemoryLayout<DurationFormat>.size),
      ("FilterRule", MemoryLayout<FilterRule>.size),
      ("FilterSet", MemoryLayout<FilterSet>.size),
      ("FractionFormat", MemoryLayout<FractionFormat>.size),
      ("HeaderFooterStrokeProperties", MemoryLayout<HeaderFooterStrokeProperties>.size),
      ("IdBasedFormula", MemoryLayout<IdBasedFormula>.size),
      ("NumberFormat", MemoryLayout<NumberFormat>.size),
      ("NumberFormatData", MemoryLayout<NumberFormatData>.size),
      ("OverallProperties", MemoryLayout<OverallProperties>.size),
      ("PivotRules", MemoryLayout<PivotRules>.size),
      ("PredicateReference", MemoryLayout<PredicateReference>.size),
      ("RowColumnIdRange", MemoryLayout<RowColumnIdRange>.size),
      ("RowGroupLabel", MemoryLayout<RowGroupLabel>.size),
      ("SortRule", MemoryLayout<SortRule>.size),
      ("StrokePreset", MemoryLayout<StrokePreset>.size),
      ("Table", MemoryLayout<Table>.size),
      ("TableCell", MemoryLayout<TableCell>.size),
      ("TableDate", MemoryLayout<TableDate>.size),
      ("TableFilter", MemoryLayout<TableFilter>.size),
      ("TablePredicate", MemoryLayout<TablePredicate>.size),
      ("TableRow", MemoryLayout<TableRow>.size),
      ("TableSort", MemoryLayout<TableSort>.size),
      ("TableVisualProperties", MemoryLayout<TableVisualProperties>.size),
      ("TransformationInfo", MemoryLayout<TransformationInfo>.size),
      ("CellFormula", MemoryLayout<CellFormula>.size),
      ("CellRange", MemoryLayout<CellRange>.size),
      ("ColumnHeaderKind", MemoryLayout<ColumnHeaderKind>.size),
      ("PredicateValue", MemoryLayout<PredicateValue>.size),
      ("RowKind", MemoryLayout<RowKind>.size),
      ("TransformationStructure", MemoryLayout<TransformationStructure>.size),
      ("UnformattedValue", MemoryLayout<UnformattedValue>.size),
    ]
    #expect(sizes.filter { $0.1 > 2048 }.map(\.0) == [])
  }
}
