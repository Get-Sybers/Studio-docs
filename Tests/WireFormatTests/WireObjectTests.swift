import Foundation
import GoldenFiles
import JSONTree
import Testing
import WireFormat

struct ObjectCase: Sendable, CustomTestStringConvertible {
  var name: String
  var json: String
  var testDescription: String { name }

  static let readable: [ObjectCase] = [
    ObjectCase(name: "the least an object holds", json: #"{"name": "ochre"}"#),
    ObjectCase(
      name: "every member",
      json: #"""
        {"type_identifier": "org.example.swatch", "version": "2.0", "preset_identifier": "warm", "identifier": "s-1",
         "name": "ochre", "weight": 3, "tint": 0.5, "gloss": true, "finish": "satin", "seal": "wax",
         "layers": [{"name": "under"}, {"name": "over", "tint": null}]}
        """#),
    ObjectCase(name: "a null clears an inheritable member", json: #"{"name": "ochre", "tint": null, "finish": null}"#),
    ObjectCase(name: "a null in an optional member stays", json: #"{"name": "ochre", "weight": null}"#),
    ObjectCase(
      name: "members the type does not model stay",
      json: #"{"name": "ochre", "sheen": {"depth": [1, 2.5, null]}, "x-note": "kept", "zeta": false}"#),
    ObjectCase(name: "a value the enumeration does not know stays", json: #"{"name": "ochre", "finish": "eggshell"}"#),
    ObjectCase(name: "a whole number may be written with a fraction", json: #"{"name": "ochre", "weight": 4.0}"#),
    ObjectCase(name: "a version that does not parse stays", json: #"{"name": "ochre", "version": "latest"}"#),
    ObjectCase(name: "a null preset identifier stays", json: #"{"name": "ochre", "preset_identifier": null}"#),
    ObjectCase(name: "an identifier that is no string stays", json: #"{"name": "ochre", "identifier": 12}"#),
  ]

  static let refused: [ObjectCase] = [
    ObjectCase(name: "a required member is absent", json: #"{"weight": 3}"#),
    ObjectCase(name: "a required member is null", json: #"{"name": null}"#),
    ObjectCase(name: "a member is of another kind", json: #"{"name": "ochre", "weight": "heavy"}"#),
    ObjectCase(name: "an integer has a fraction", json: #"{"name": "ochre", "weight": 3.5}"#),
    ObjectCase(name: "a Boolean is written as a string", json: #"{"name": "ochre", "gloss": "true"}"#),
    ObjectCase(
      name: "the object names another type", json: #"{"type_identifier": "org.example.other", "name": "ochre"}"#),
    ObjectCase(name: "the type identifier is no string", json: #"{"type_identifier": 7, "name": "ochre"}"#),
    ObjectCase(name: "the object declares a later major version", json: #"{"version": "3.0", "name": "ochre"}"#),
    ObjectCase(name: "the value is no object", json: #"["ochre"]"#),
    ObjectCase(
      name: "the fault lies three levels down",
      json: #"{"name": "a", "layers": [{"name": "b"}, {"name": "c", "layers": [{"name": 5}]}]}"#),
  ]
}

struct VersionCase: Sendable, CustomTestStringConvertible {
  var name: String
  var json: String
  var edit: @Sendable (inout Swatch) -> Void = { _ in }
  var testDescription: String { name }

  static let all: [VersionCase] = [
    VersionCase(name: "none declared: none written", json: #"{"name": "a"}"#),
    VersionCase(
      name: "none declared beside later members: none written", json: #"{"name": "a", "gloss": true, "finish": null}"#),
    VersionCase(name: "one declared: it is kept", json: #"{"name": "a", "version": "1.0"}"#),
    VersionCase(
      name: "one declared beyond the model: it is kept", json: #"{"name": "a", "version": "2.9", "later": 1}"#),
    VersionCase(
      name: "a member newer than the declared version is not read",
      json: #"{"name": "a", "version": "1.0", "gloss": true, "finish": "satin"}"#),
    VersionCase(
      name: "setting a later member raises the declared version",
      json: #"{"name": "a", "version": "1.0"}"#, edit: { $0.gloss = false }),
    VersionCase(
      name: "the latest of two later members counts",
      json: #"{"name": "a", "version": "1.0"}"#,
      edit: {
        $0.gloss = false
        $0.finish = .cleared
      }),
    VersionCase(
      name: "setting a later member replaces the unread one",
      json: #"{"name": "a", "version": "1.0", "gloss": true}"#, edit: { $0.gloss = false }),
    VersionCase(
      name: "an edit keeps a version declared beyond the model",
      json: #"{"name": "a", "version": "2.7", "later": 1}"#, edit: { $0.weight = 2 }),
    VersionCase(
      name: "a member of a later major version is always declared",
      json: #"{"name": "a", "later": 1}"#, edit: { $0.seal = "wax" }),
    VersionCase(
      name: "a member of a later major version read with none declared",
      json: #"{"name": "a", "seal": "wax"}"#),
  ]
}

@Suite struct WireObjectTests {
  let goldens: GoldenFile

  init() throws {
    goldens = try GoldenFile(named: "wire-format", in: .module)
  }

  static func readable(_ value: JSONValue) throws -> String {
    String(decoding: try value.text(.readable), as: UTF8.self)
  }

  @Test(arguments: ObjectCase.readable)
  func roundTrip(_ item: ObjectCase) throws {
    let tree = try JSONValue(parsing: Data(item.json.utf8))
    let swatch = try Swatch(wire: tree)
    let written = swatch.wireValue
    #expect(try Swatch(wire: written) == swatch)
    #expect(try Swatch(wire: written).wireValue == written)
    // Nothing is lost: what was read is all there, and only the type identifier may be new.
    var expected = try #require(tree.objectValue)
    expected["type_identifier"] = "org.example.swatch"
    if var layers = expected["layers"]?.arrayValue {
      for index in layers.indices {
        var layer = try #require(layers[index].objectValue)
        layer["type_identifier"] = "org.example.swatch"
        layers[index] = .object(layer)
      }
      expected["layers"] = .array(layers)
    }
    #expect(written == .object(expected))
    let got = try Self.readable(written)
    #expect(got == (try goldens.want("object: \(item.name)", got: got)))
  }

  @Test(arguments: ObjectCase.refused)
  func refuses(_ item: ObjectCase) throws {
    let tree = try JSONValue(parsing: Data(item.json.utf8))
    var got = "accepted"
    do throws(WireError) {
      _ = try Swatch(wire: tree)
    } catch {
      got = "\(error) at \(error.path)"
    }
    #expect(got == (try goldens.want("refused: \(item.name)", got: got)))
    #expect(got != "accepted")
  }

  @Test(arguments: VersionCase.all)
  func versions(_ item: VersionCase) throws {
    var swatch = try Swatch(wire: try JSONValue(parsing: Data(item.json.utf8)))
    let read = "gloss \(swatch.gloss.map(String.init) ?? "nil"), finish \(swatch.finish)"
    item.edit(&swatch)
    let written = swatch.wireValue
    #expect(try Swatch(wire: written).wireValue == written)
    let got = read + "\n" + String(decoding: try written.text(), as: UTF8.self)
    #expect(got == (try goldens.want("version: \(item.name)", got: got)))
  }

  @Test func foundationCodersUseTheNamesOfTheFormat() throws {
    var swatch = Swatch(name: "slate")
    swatch.tint = .cleared
    swatch.identifier = "s-9"
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.sortedKeys]
    let text = String(decoding: try encoder.encode(swatch), as: UTF8.self)
    #expect(text == #"{"identifier":"s-9","name":"slate","tint":null,"type_identifier":"org.example.swatch"}"#)
    #expect(try JSONDecoder().decode(Swatch.self, from: Data(text.utf8)) == swatch)
  }

  @Test func aClientPropertyTravelsWithTheObject() throws {
    let marks = ClientProperty<[String]>("x-marks")
    let pinned = ClientProperty<Bool>("x-pinned")
    var swatch = Swatch(name: "slate")
    #expect(try swatch.value(of: marks) == nil)
    swatch.setValue(["first", "second"], of: marks)
    swatch.setValue(true, of: pinned)
    let reread = try Swatch(wire: swatch.wireValue)
    #expect(try reread.value(of: marks) == ["first", "second"])
    #expect(try reread.value(of: pinned) == true)
    swatch.setValue(nil, of: pinned)
    #expect(swatch.wireValue["x-pinned"] == nil)
    #expect(throws: WireError.unexpectedKind(expected: .boolean, found: .array, at: JSONPath([.member("x-marks")]))) {
      _ = try reread.value(of: ClientProperty<Bool>("x-marks"))
    }
  }

  @Test func theEnvelopeLiteralsReadAsValues() {
    var swatch = Swatch(name: "slate")
    swatch.tint = 0.25
    swatch.finish = .value(.matte)
    #expect(swatch.tint == .value(0.25))
    #expect(swatch.tint.value == 0.25)
    #expect(Inheritable<Double>(nil).isInherited)
    #expect(Inheritable<Double>.cleared.isCleared)
    #expect(swatch.finish.value?.isModelled == true)
    #expect(!Finish(rawValue: "eggshell").isModelled)
  }
}
