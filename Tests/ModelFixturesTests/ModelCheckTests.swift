import Foundation
import JSONTree
import ModelFixtures
import Testing
import WireFormat

/// A type of the tests' own that reads one of its two members, so that the check has something to find.
struct Careless: WireObject {
  static let schema = ObjectSchema(typeIdentifier: "org.example.careless", members: [.init("kept"), .init("dropped")])

  var kept: String?
  var envelope = ObjectEnvelope()

  init(reading reader: inout ObjectReader) throws(WireError) {
    kept = try reader.optional("kept")
  }

  func write(to writer: inout ObjectWriter) {
    writer.optional("kept", kept)
  }
}

@Suite struct ModelCheckTests {
  @Test func findsAMemberThatATypeDoesNotRead() {
    let result = ModelCheck.roundTrip(ModelledType(Careless.self), sample: ["kept": "a", "dropped": "b"])
    #expect(result.defects == ["Careless leaves [\"dropped\"] unread"])
    #expect(result.written == ["kept": "a", "dropped": "b", "type_identifier": "org.example.careless"])
  }

  @Test func findsAMemberThatTheSampleLacks() {
    let result = ModelCheck.roundTrip(ModelledType(Careless.self), sample: ["kept": "a"])
    #expect(result.defects == ["the sample of Careless holds [\"kept\"]; the table lists [\"dropped\", \"kept\"]"])
  }

  @Test func findsASampleOfAnotherKind() {
    let result = ModelCheck.roundTrip(ModelledType(Careless.self), sample: ["kept": 3, "dropped": "b"])
    #expect(result.defects.count == 1)
    #expect(result.defects.first?.hasPrefix("Careless: unexpectedKind") == true)
  }

  @Test func stripsTypeIdentifiersAtEveryDepth() {
    let tree: JSONValue = [
      "type_identifier": "a", "list": [["type_identifier": "b", "x": 1]], "y": ["type_identifier": "c"],
    ]
    #expect(tree.withoutTypeIdentifiers == ["list": [["x": 1]], "y": [:]])
  }

  @Test func readsTheFixturesOfATestTarget() throws {
    let fixtures = try FixtureFile(named: "model-fixtures", in: .module)
    #expect(try fixtures.sample("careless") == ["kept": "a", "dropped": "b"])
    #expect(throws: FixtureError.self) { _ = try fixtures.sample("absent") }
    #expect(throws: FixtureError.self) { _ = try FixtureFile(named: "no-such-file", in: .module) }
  }
}
