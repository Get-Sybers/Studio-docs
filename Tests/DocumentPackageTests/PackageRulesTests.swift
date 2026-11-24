import DocumentPackage
import DocumentValidation
import Foundation
import GoldenFiles
import JSONTree
import PresetStyles
import ResourceReferences
import Testing
import TextModel
import WireFormat
import ZipArchives

struct ManifestCase: Sendable, CustomTestStringConvertible {
  var name: String
  var manifest: String?
  var testDescription: String { name }

  static let all: [ManifestCase] = [
    ManifestCase(name: "no manifest", manifest: nil),
    ManifestCase(name: "the current version", manifest: #"{"package_version": "1.0"}"#),
    ManifestCase(name: "a later minor version", manifest: #"{"package_version": "1.7"}"#),
    ManifestCase(name: "an earlier major version", manifest: #"{"package_version": "0.9"}"#),
    ManifestCase(name: "a later major version", manifest: #"{"package_version": "2.0"}"#),
    ManifestCase(name: "the version as a number", manifest: #"{"package_version": 1.0}"#),
    ManifestCase(name: "the version as a number with a fraction", manifest: #"{"package_version": 1.5}"#),
    ManifestCase(name: "the version as a later number", manifest: #"{"package_version": 3}"#),
    ManifestCase(name: "the version as two integers", manifest: #"{"package_version": {"major": 1, "minor": 2}}"#),
    ManifestCase(name: "the version as a major alone", manifest: #"{"package_version": {"major": 4}}"#),
    ManifestCase(name: "a version that does not parse", manifest: #"{"package_version": "one point oh"}"#),
    ManifestCase(name: "a version of the wrong kind", manifest: #"{"package_version": true}"#),
    ManifestCase(name: "a manifest with no version", manifest: #"{"generator": "another tool"}"#),
    ManifestCase(name: "a manifest that is no object", manifest: #"["1.0"]"#),
    ManifestCase(name: "a manifest that is not JSON", manifest: "version 1"),
  ]
}

struct BrokenCase: Sendable, CustomTestStringConvertible {
  var name: String
  var entries: [(String, String)]
  var testDescription: String { name }

  static let main = #"{"type_identifier": "org.example.notebook", "entries": []}"#

  static let all: [BrokenCase] = [
    BrokenCase(name: "no main.json", entries: [("presets.json", "[]")]),
    BrokenCase(name: "main.json under another case", entries: [("Main.json", main)]),
    BrokenCase(
      name: "main.json inside a folder beside other entries",
      entries: [("notes/main.json", main), ("presets.json", "[]")]),
    BrokenCase(name: "main.json is not JSON", entries: [("main.json", "{entries: []}")]),
    BrokenCase(
      name: "main.json is another type",
      entries: [("main.json", #"{"type_identifier": "org.example.other", "entries": []}"#)]),
    BrokenCase(
      name: "main.json lacks a required member",
      entries: [("main.json", #"{"type_identifier": "org.example.notebook"}"#)]),
    BrokenCase(
      name: "a fault deep in the text",
      entries: [
        (
          "main.json",
          #"{"entries": [{"title": "a", "text": {"paragraphs": [{"contents": [{"run": {"string": 4}}]}]}}]}"#
        )
      ]),
    BrokenCase(name: "presets.json is not JSON", entries: [("main.json", main), ("presets.json", "[")]),
    BrokenCase(name: "presets.json is no array", entries: [("main.json", main), ("presets.json", "{}")]),
    BrokenCase(
      name: "a preset has no properties", entries: [("main.json", main), ("presets.json", #"[{"identifier": "a"}]"#)]),
  ]
}

@Suite struct PackageRulesTests {
  let goldens: GoldenFile

  init() throws {
    goldens = try GoldenFile(named: "document-package", in: .module)
  }

  static func archive(_ entries: [(String, String)]) throws -> Data {
    var writer = ZipWriter()
    for (name, text) in entries {
      try writer.add(Data(text.utf8), named: name)
    }
    return writer.finish()
  }

  static func describe(_ error: DocumentError) -> String {
    switch error {
    case .fileSystem(_, let underlying): "fileSystem(\((underlying as NSError).domain) \((underlying as NSError).code))"
    case .malformedJSON(let entry, _): "malformedJSON(\(entry))"
    case .notAPackage: "notAPackage"
    case .destinationOccupied: "destinationOccupied"
    case .notAPackageDirectory: "notAPackageDirectory"
    case .invalid(let report): "invalid(\(report.errors.map(\.description).joined(separator: "; ")))"
    default: "\(error)"
    }
  }

  @Test(arguments: ManifestCase.all)
  func readsTheVersionOfThePackage(_ item: ManifestCase) throws {
    var entries = [("main.json", BrokenCase.main)]
    if let manifest = item.manifest { entries.append(("manifest.json", manifest)) }
    let archive = try Self.archive(entries)
    var document: StudioDocument<Notebook>?
    var got = ""
    do throws(DocumentError) {
      document = try StudioDocument<Notebook>(archive: archive)
    } catch {
      got = "refused: \(Self.describe(error))"
    }
    if let document {
      let reader = try ZipReader(try document.archive())
      let entry = try #require(reader.entries.first { $0.name == "manifest.json" })
      let written = try JSONValue(parsing: try reader.contents(of: entry))
      got =
        "read as \(document.manifest.effectiveVersion), written as \(String(decoding: try written.text(), as: UTF8.self))"
    }
    #expect(got == (try goldens.want("manifest: \(item.name)", got: got)))
  }

  @Test(arguments: BrokenCase.all)
  func refusesABrokenPackage(_ item: BrokenCase) throws {
    let archive = try Self.archive(item.entries)
    var got = "accepted"
    do throws(DocumentError) {
      _ = try StudioDocument<Notebook>(archive: archive)
    } catch {
      got = Self.describe(error)
    }
    #expect(got == (try goldens.want("broken: \(item.name)", got: got)))
    #expect(got != "accepted")
  }

  @Test func aPackageInsideOneFolderOpens() throws {
    let archive = try Self.archive([
      ("notes/main.json", BrokenCase.main), ("notes/Data/anchor.png", "png"), ("notes/extra.txt", "x"),
    ])
    let document = try StudioDocument<Notebook>(archive: archive)
    #expect(document.resources.names == ["anchor.png"])
    #expect(document.unmodelledEntries.map(\.name) == ["extra.txt"])
    let written = try ZipReader(try document.archive())
    #expect(
      written.entries.map(\.name) == ["main.json", "manifest.json", "presets.json", "Data/anchor.png", "extra.txt"])
  }

  @Test func refusesAHostileArchive() throws {
    var got: [String] = []
    let attempts: [(String, Data, ZipLimits)] = [
      ("not an archive", Data("plain text".utf8), .standard),
      ("cut short", try Self.archive([("main.json", BrokenCase.main)]).prefix(30), .standard),
      ("beyond the size limit", try Self.archive([("main.json", BrokenCase.main)]), ZipLimits(maximumEntrySize: 10)),
      (
        "beyond the entry limit", try Self.archive([("main.json", BrokenCase.main), ("a", ""), ("b", "")]),
        ZipLimits(maximumEntryCount: 2)
      ),
    ]
    for (name, bytes, limits) in attempts {
      do throws(DocumentError) {
        _ = try StudioDocument<Notebook>(archive: bytes, limits: limits)
        got.append("\(name): accepted")
      } catch {
        got.append("\(name): \(Self.describe(error))")
      }
    }
    let text = got.joined(separator: "\n")
    #expect(text == (try goldens.want("hostile archives through the document", got: text)))
  }

  @Test func refusesAHostileDirectory() throws {
    let scratch = try Scratch()
    let directory = scratch.file("notes.package")
    try FileManager.default.createDirectory(
      at: directory.appendingPathComponent("Data"), withIntermediateDirectories: true)
    try Data(BrokenCase.main.utf8).write(to: directory.appendingPathComponent("main.json"))
    let secret = scratch.file("secret.txt")
    try Data("outside the package".utf8).write(to: secret)
    try FileManager.default.createSymbolicLink(
      at: directory.appendingPathComponent("Data/link.png"), withDestinationURL: secret)
    var got = "accepted"
    do throws(DocumentError) {
      _ = try StudioDocument<Notebook>(contentsOf: directory)
    } catch {
      got = Self.describe(error)
    }
    #expect(got == "unsafeEntry(name: \"Data/link.png\")")

    try FileManager.default.removeItem(at: directory.appendingPathComponent("Data/link.png"))
    try Data(count: 64).write(to: directory.appendingPathComponent("Data/large.bin"))
    #expect(throws: DocumentError.self) {
      _ = try StudioDocument<Notebook>(contentsOf: directory, limits: ZipLimits(maximumEntrySize: 63))
    }
    #expect(throws: DocumentError.self) { _ = try StudioDocument<Notebook>(contentsOf: scratch.file("absent")) }
  }

  @Test func refusesToWriteWhereItShouldNot() throws {
    let scratch = try Scratch()
    let document = StudioDocument(body: Notebook(entries: []))
    var got: [String] = []
    let attempt = { (name: String, body: () throws(DocumentError) -> Void) in
      do throws(DocumentError) {
        try body()
        got.append("\(name): written")
      } catch {
        got.append("\(name): \(Self.describe(error))")
      }
    }
    let other = scratch.file("holiday-photos")
    try FileManager.default.createDirectory(at: other, withIntermediateDirectories: true)
    try Data([1]).write(to: other.appendingPathComponent("beach.jpg"))
    attempt("a directory that is no package") { () throws(DocumentError) in
      try document.write(to: other, as: .directory)
    }
    attempt("an archive over a directory") { () throws(DocumentError) in try document.write(to: other, as: .archive) }
    let file = scratch.file("notes.studio")
    attempt("an archive") { () throws(DocumentError) in try document.write(to: file) }
    attempt("a directory over a file") { () throws(DocumentError) in try document.write(to: file, as: .directory) }
    attempt("an archive below a missing directory") { () throws(DocumentError) in
      try document.write(to: scratch.file("absent/notes.studio"))
    }
    attempt("an empty directory") { () throws(DocumentError) in
      let empty = scratch.file("empty.package")
      do {
        try FileManager.default.createDirectory(at: empty, withIntermediateDirectories: true)
      } catch {
        throw .fileSystem(path: empty.path, underlying: error)
      }
      try document.write(to: empty, as: .directory)
    }
    #expect(try scratch.listing(of: other) == ["beach.jpg"])
    let text = got.joined(separator: "\n")
    #expect(text == (try goldens.want("destinations", got: text)))
  }

  @Test func anInvalidDocumentIsNotWritten() throws {
    let scratch = try Scratch()
    var document = StudioDocumentTests.notebook()
    document.resources["harbour.png"] = nil
    document.body.entries.append(NotebookEntry(title: "", text: .string("An entry with no title.")))
    let url = scratch.file("notes.studio")
    var got = "written"
    do throws(DocumentError) {
      try document.write(to: url)
    } catch {
      got = Self.describe(error)
    }
    #expect(got == (try goldens.want("an invalid document is not written", got: got)))
    #expect(!FileManager.default.fileExists(atPath: url.path))
    try document.write(to: url, options: WriteOptions(refusesInvalid: false))
    #expect(try StudioDocument<Notebook>(contentsOf: url).body == document.body)
  }

  @Test func resourcesThatAFileSystemHoldsAsOneAreNotWrittenToADirectory() throws {
    let scratch = try Scratch()
    var document = StudioDocument(body: Notebook(entries: []))
    document.resources["Chart.png"] = Data([1])
    document.resources["chart.png"] = Data([2])
    #expect(document.validate().warnings.map(\.kind) == [.resourceNamesCollide("Chart.png", "chart.png")])
    var got = "written"
    do throws(DocumentError) {
      try document.write(to: scratch.file("notes.package"), as: .directory)
    } catch {
      got = Self.describe(error)
    }
    #expect(got == "resourceNamesCollide(\"Data/Chart.png\", \"Data/chart.png\")")
    try document.write(to: scratch.file("notes.studio"))
    #expect(try StudioDocument<Notebook>(contentsOf: scratch.file("notes.studio")).resources.count == 2)
  }

  @Test func aStoreGivesANameThatIsFree() {
    var store: ResourceStore = ["logo.png": Data([1]), "notes": Data([2]), ".hidden": Data([3])]
    #expect(store.uniqueName(basedOn: "cover.png") == "cover.png")
    #expect(store.uniqueName(basedOn: "logo.png") == "logo 2.png")
    #expect(store.uniqueName(basedOn: "notes") == "notes 2")
    #expect(store.uniqueName(basedOn: ".hidden") == ".hidden 2")
    let second = store.add(Data([4]), preferredName: "logo.png")
    #expect(second.identifier == "logo 2.png")
    #expect(second.filename == "logo.png")
    #expect(store.data(for: second) == Data([4]))
    #expect(store.uniqueName(basedOn: "logo.png") == "logo 3.png")
    #expect(store.names == ["logo.png", "notes", ".hidden", "logo 2.png"])
    #expect(store.add(Data([5]), preferredName: "new.png").identifier == nil)
    #expect(store["cafe\u{301}.png"] == nil)
    store["caf\u{E9}.png"] = Data([6])
    #expect(store["cafe\u{301}.png"] == Data([6]))
  }
}
