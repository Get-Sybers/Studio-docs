import Foundation
import GoldenFiles
import JSONTree
import ModelFixtures
import ResourceReferences
import Testing
import WireFormat

@Suite struct ResourceTypesTests {
  static let types: [ModelledType] = [
    ModelledType(ResourceReference.self), ModelledType(IndirectResource.self), ModelledType(EmbeddedResource.self),
    ModelledType(PremiumResourceInfo.self),
  ]

  let goldens: GoldenFile
  let fixtures: FixtureFile

  init() throws {
    goldens = try GoldenFile(named: "resource-references", in: .module)
    fixtures = try FixtureFile(named: "resource-references", in: .module)
  }

  @Test(arguments: types)
  func readsAndWritesEveryMember(_ type: ModelledType) throws {
    let result = ModelCheck.roundTrip(type, sample: try fixtures.sample(type.name))
    #expect(result.defects == [])
    let got = String(decoding: try result.written.text(.readable), as: UTF8.self)
    #expect(got == (try goldens.want("type: \(type.name)", got: got)))
  }

  @Test func theTableListsWhatTheTargetModels() {
    #expect(ModelCheck.agreement(types: Self.types, fixtures: fixtures, table: ResourceFormat.table) == [])
  }

  @Test func aPremiumResourceDeclaresItsMajorVersion() throws {
    var resource = IndirectResource(filename: "harbour.png")
    #expect(resource.wireValue["version"] == nil)
    resource.premiumResourceInfo = PremiumResourceInfo(
      assetUUID: "5B7C1D0E-8A4F-4C21-9E3B-6D2F0A1C4E77", isDerivedAsset: false, mayNeedWatermark: true)
    #expect(resource.wireValue["version"] == "2.0")
    #expect(throws: WireError.self) {
      _ = try IndirectResource(wire: ["filename": "a.png", "version": "3.0"])
    }
  }

  @Test func theStoredNameIsTheIdentifierOrElseTheFilename() {
    #expect(IndirectResource(filename: "Beach.jpg").storedName == "Beach.jpg")
    #expect(IndirectResource(filename: "Beach.jpg", identifier: "3F2A9C.jpg").storedName == "3F2A9C.jpg")
  }

  @Test func theIdentifierOfAnIndirectResourceIsItsFileName() throws {
    let resource = try IndirectResource(wire: ["filename": "Beach.jpg", "identifier": "3F2A9C.jpg"])
    #expect(resource.identifier == "3F2A9C.jpg")
    #expect(resource.envelope.identifier == nil)
  }

  @Test func embeddedBytesComeBack() throws {
    let bytes = Data([0x89, 0x50, 0x4E, 0x47, 0x00, 0xFF])
    let resource = EmbeddedResource(data: bytes, filename: "dot.png")
    #expect(resource.string == "iVBORwD/")
    #expect(try resource.decodedData() == bytes)
    #expect(throws: ResourceDataError.notBase64(filename: "dot.png")) {
      _ = try EmbeddedResource(string: "not base64!", filename: "dot.png").decodedData()
    }
  }
}
