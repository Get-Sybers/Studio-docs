import Appearance
import Foundation
import GoldenFiles
import PageSizes
import Testing

@Suite struct PageSizesTests {
  let goldens: GoldenFile

  init() throws {
    goldens = try GoldenFile(named: "page-sizes", in: .module)
  }

  @Test func theCatalogueNamesEverySizeOnceWithItsPoints() throws {
    let sizes = PageSizeCatalogue.all
    #expect(Set(sizes.map(\.name)).count == sizes.count)
    #expect(sizes.allSatisfy { $0.width > 0 && $0.height > 0 })
    #expect(PageSizeSystem.allCases.allSatisfy { !PageSizeCatalogue.sizes(in: $0).isEmpty })
    let got = sizes.map { size in
      let points = size.size
      return "\(size.name) (\(size.system.rawValue)): \(size.width) x \(size.height) \(size.unit.rawValue) = "
        + "\(points.width.formatted(.number.precision(.fractionLength(1)))) x "
        + "\(points.height.formatted(.number.precision(.fractionLength(1)))) pt"
    }.joined(separator: "\n")
    #expect(got == (try goldens.want("the catalogue", got: got)))
  }

  @Test(arguments: [
    (LengthUnit.inch, 6.0, 432.0), (LengthUnit.millimetre, 25.4, 72.0), (LengthUnit.millimetre, 210, 595.2755905511812),
  ])
  func pointsFollowTheUnit(_ unit: LengthUnit, _ length: Double, _ points: Double) {
    #expect(unit.points(length) == points)
  }

  @Test func aSizeIsFoundByItsName() {
    #expect(PageSizeCatalogue.named("US Trade")?.size == SizeValue(width: 432, height: 648))
    #expect(PageSizeCatalogue.named("Royal")?.system == .uk)
    #expect(PageSizeCatalogue.named("Folio") == nil)
  }
}
