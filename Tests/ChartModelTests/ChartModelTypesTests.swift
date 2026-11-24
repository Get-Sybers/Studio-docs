import Appearance
import CanvasCommon
import ChartModel
import Foundation
import GoldenFiles
import JSONTree
import ModelFixtures
import TableModel
import Testing
import TextModel
import WireFormat

@Suite struct ChartModelTypesTests {
  static let types: [ModelledType] = [
    ModelledType(Area3DChart.self),
    ModelledType(AreaChart.self),
    ModelledType(Bar3DChart.self),
    ModelledType(BarChart.self),
    ModelledType(BarInteractiveChart.self),
    ModelledType(BubbleChart.self),
    ModelledType(BubbleInteractiveChart.self),
    ModelledType(ChartCategoryAxis.self),
    ModelledType(ChartColor.self),
    ModelledType(ChartData.self),
    ModelledType(ChartDataRow.self),
    ModelledType(ChartLegend.self),
    ModelledType(ChartSeries.self),
    ModelledType(ChartValueAxis.self),
    ModelledType(Column3DChart.self),
    ModelledType(ColumnChart.self),
    ModelledType(ColumnInteractiveChart.self),
    ModelledType(DonutChart.self),
    ModelledType(GenericCategoryComparisonChart.self),
    ModelledType(GenericChartAxisCommon.self),
    ModelledType(GenericChartCommon.self),
    ModelledType(GenericChartLabelFormatting.self),
    ModelledType(GenericCorrelationChart.self),
    ModelledType(Line3DChart.self),
    ModelledType(LineChart.self),
    ModelledType(MixedChart.self),
    ModelledType(Pie3DChart.self),
    ModelledType(PieChart.self),
    ModelledType(RadarChart.self),
    ModelledType(ScatterChart.self),
    ModelledType(ScatterInteractiveChart.self),
    ModelledType(StackedArea3DChart.self),
    ModelledType(StackedAreaChart.self),
    ModelledType(StackedBar3DChart.self),
    ModelledType(StackedBarChart.self),
    ModelledType(StackedColumn3DChart.self),
    ModelledType(StackedColumnChart.self),
    ModelledType(TwoAxisChart.self),
    ModelledType(AxisLabelOrientation.self),
    ModelledType(CategoryComparisonChart.self),
    ModelledType(Chart.self),
    ModelledType(ChartAxisCommon.self),
    ModelledType(ChartCommon.self),
    ModelledType(ChartDataValue.self),
    ModelledType(ChartLabelFormatting.self),
    ModelledType(CorrelationChart.self),
    ModelledType(LabelSpacing.self),
  ]

  let goldens: GoldenFile
  let fixtures: FixtureFile

  init() throws {
    goldens = try GoldenFile(named: "chart-model", in: .module)
    fixtures = try FixtureFile(named: "chart-model", in: .module)
  }

  @Test(arguments: types)
  func readsAndWritesEveryMember(_ type: ModelledType) throws {
    let result = ModelCheck.roundTrip(type, sample: try fixtures.sample(type.name))
    #expect(result.defects == [])
    let got = String(decoding: try result.written.text(.readable), as: UTF8.self)
    #expect(got == (try goldens.want("type: \(type.name)", got: got)))
  }

  @Test func theTableListsWhatTheTargetModels() {
    #expect(ModelCheck.agreement(types: Self.types, fixtures: fixtures, table: ChartModelFormat.table) == [])
  }

  @Test func theTableListsTheValuesOfEveryEnumeration() {
    let table = ChartModelFormat.table
    var defects: [String] = []
    defects += ModelCheck.agreement([AxisScale.linear, .log, .percent], table: table)
    defects += ModelCheck.agreement(
      [ChartDataSource.chartDataGrid, .tableFormulaReferences, .uninitialized], table: table)
    defects += ModelCheck.agreement([ConnectionLineType.curved, .off, .straight], table: table)
    defects += ModelCheck.agreement(
      [FillReuseRule.seriesFillUseSeriesStroke, .symbolFillUsesSeriesFill, .symbolFillUsesSeriesStroke], table: table)
    defects += ModelCheck.agreement([MixedSeriesType.area, .column, .line], table: table)
    defects += ModelCheck.agreement([PlotDirection.columnsAsSeries, .rowsAsSeries], table: table)
    defects += ModelCheck.agreement(
      [SeriesSymbolType.circle, .diamond, .off, .plus, .square, .triangle, .x, .yield], table: table)
    defects += ModelCheck.agreement(
      [
        SeriesValueLabelPosition.auto, .bottom, .bottomLeft, .bottomRight, .center, .inside, .insideBottom, .insideLeft,
        .insideRight, .insideTop, .left, .outside, .outsideTop, .right, .top, .topLeft, .topRight,
      ], table: table)
    defects += ModelCheck.agreement([ValueLabelsSelection.off, .size, .x, .xAndY, .y], table: table)
    #expect(defects == [])
    #expect(table.enumerations.count == 9)
  }

  // A value this large on the stack overflows a secondary thread once a few calls nest.
  @Test func theModelTypesStaySmallEnoughToPassByValue() {
    let sizes: [(String, Int)] = [
      ("Area3DChart", MemoryLayout<Area3DChart>.size),
      ("AreaChart", MemoryLayout<AreaChart>.size),
      ("Bar3DChart", MemoryLayout<Bar3DChart>.size),
      ("BarChart", MemoryLayout<BarChart>.size),
      ("BarInteractiveChart", MemoryLayout<BarInteractiveChart>.size),
      ("BubbleChart", MemoryLayout<BubbleChart>.size),
      ("BubbleInteractiveChart", MemoryLayout<BubbleInteractiveChart>.size),
      ("ChartCategoryAxis", MemoryLayout<ChartCategoryAxis>.size),
      ("ChartColor", MemoryLayout<ChartColor>.size),
      ("ChartData", MemoryLayout<ChartData>.size),
      ("ChartDataRow", MemoryLayout<ChartDataRow>.size),
      ("ChartLegend", MemoryLayout<ChartLegend>.size),
      ("ChartSeries", MemoryLayout<ChartSeries>.size),
      ("ChartValueAxis", MemoryLayout<ChartValueAxis>.size),
      ("Column3DChart", MemoryLayout<Column3DChart>.size),
      ("ColumnChart", MemoryLayout<ColumnChart>.size),
      ("ColumnInteractiveChart", MemoryLayout<ColumnInteractiveChart>.size),
      ("DonutChart", MemoryLayout<DonutChart>.size),
      ("GenericCategoryComparisonChart", MemoryLayout<GenericCategoryComparisonChart>.size),
      ("GenericChartAxisCommon", MemoryLayout<GenericChartAxisCommon>.size),
      ("GenericChartCommon", MemoryLayout<GenericChartCommon>.size),
      ("GenericChartLabelFormatting", MemoryLayout<GenericChartLabelFormatting>.size),
      ("GenericCorrelationChart", MemoryLayout<GenericCorrelationChart>.size),
      ("Line3DChart", MemoryLayout<Line3DChart>.size),
      ("LineChart", MemoryLayout<LineChart>.size),
      ("MixedChart", MemoryLayout<MixedChart>.size),
      ("Pie3DChart", MemoryLayout<Pie3DChart>.size),
      ("PieChart", MemoryLayout<PieChart>.size),
      ("RadarChart", MemoryLayout<RadarChart>.size),
      ("ScatterChart", MemoryLayout<ScatterChart>.size),
      ("ScatterInteractiveChart", MemoryLayout<ScatterInteractiveChart>.size),
      ("StackedArea3DChart", MemoryLayout<StackedArea3DChart>.size),
      ("StackedAreaChart", MemoryLayout<StackedAreaChart>.size),
      ("StackedBar3DChart", MemoryLayout<StackedBar3DChart>.size),
      ("StackedBarChart", MemoryLayout<StackedBarChart>.size),
      ("StackedColumn3DChart", MemoryLayout<StackedColumn3DChart>.size),
      ("StackedColumnChart", MemoryLayout<StackedColumnChart>.size),
      ("TwoAxisChart", MemoryLayout<TwoAxisChart>.size),
      ("AxisLabelOrientation", MemoryLayout<AxisLabelOrientation>.size),
      ("CategoryComparisonChart", MemoryLayout<CategoryComparisonChart>.size),
      ("Chart", MemoryLayout<Chart>.size),
      ("ChartAxisCommon", MemoryLayout<ChartAxisCommon>.size),
      ("ChartCommon", MemoryLayout<ChartCommon>.size),
      ("ChartDataValue", MemoryLayout<ChartDataValue>.size),
      ("ChartLabelFormatting", MemoryLayout<ChartLabelFormatting>.size),
      ("CorrelationChart", MemoryLayout<CorrelationChart>.size),
      ("LabelSpacing", MemoryLayout<LabelSpacing>.size),
    ]
    #expect(sizes.filter { $0.1 > 2048 }.map(\.0) == [])
  }
}
