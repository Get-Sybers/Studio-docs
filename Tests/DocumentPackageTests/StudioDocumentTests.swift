import DocumentPackage
import DocumentValidation
import Foundation
import GoldenFiles
import JSONTree
import ModelFixtures
import PresetStyles
import ResourceReferences
import Testing
import TextModel
import WireFormat
import ZipArchives

@Suite struct StudioDocumentTests {
  let goldens: GoldenFile

  init() throws {
    goldens = try GoldenFile(named: "document-package", in: .module)
  }

  static let picture = Data((0..<600).map { UInt8(truncatingIfNeeded: $0 &* 37 &+ 11) })

  static func notebook() -> StudioDocument<Notebook> {
    var resources = ResourceStore()
    let cover = resources.add(picture, preferredName: "harbour.png")
    var stressed = CharacterProperties(italic: true)
    stressed.presetIdentifier = "stress"
    var first = Paragraph(contents: [.text("The tide went out "), .text("slowly", style: stressed), .text(".")])
    first.identifier = "p-1"
    var second = Paragraph("Non-breaking\u{00A0}space, line\u{2028}separator, e\u{301} and 😀 stay as they are.")
    second.identifier = "p-2"
    var entry = NotebookEntry(title: "Monday", text: .paragraphs([first, second]), picture: .indirect(cover))
    entry.identifier = "e-1"
    var document = StudioDocument(body: Notebook(entries: [entry]), resources: resources)
    document.presets = [
      Preset(identifier: "stress", properties: CharacterProperties(italic: true), displayName: "Stress")
    ]
    return document
  }

  @Test(arguments: [PackageLayout.archive, .directory], [JSONStyle.compact, .readable])
  func roundTrip(_ layout: PackageLayout, _ style: JSONStyle) throws {
    let scratch = try Scratch()
    let document = Self.notebook()
    let url = scratch.file(layout == .archive ? "notes.studio" : "notes.package")
    try document.write(to: url, as: layout, options: WriteOptions(style: style))
    let reopened = try StudioDocument<Notebook>(contentsOf: url)
    #expect(reopened.body == document.body)
    #expect(reopened.presets == document.presets)
    #expect(reopened.resources == document.resources)
    #expect(reopened.resources["harbour.png"] == Self.picture)
    #expect(reopened.manifest == document.manifest)
    #expect(reopened.unmodelledEntries.isEmpty)
    #expect(reopened.validate().findings == [])
  }

  @Test func writesTheThreeFilesAndTheData() throws {
    let scratch = try Scratch()
    let directory = scratch.file("notes.package")
    try Self.notebook().write(to: directory, as: .directory, options: WriteOptions(style: .readable))
    #expect(try scratch.listing(of: directory) == ["Data/harbour.png", "main.json", "manifest.json", "presets.json"])
    for name in ["main.json", "manifest.json", "presets.json"] {
      let got = try String(contentsOf: directory.appendingPathComponent(name), encoding: .utf8)
      #expect(got == (try goldens.want("written: \(name)", got: got)))
    }
    let reader = try ZipReader(try Self.notebook().archive())
    #expect(reader.entries.map(\.name) == ["main.json", "manifest.json", "presets.json", "Data/harbour.png"])
  }

  @Test func aDirectoryIsSavedStepByStep() throws {
    let scratch = try Scratch()
    let directory = scratch.file("notes.package")
    var document = Self.notebook()
    let first = try document.write(to: directory, as: .directory)
    #expect(first.written == ["manifest.json", "presets.json", "Data/harbour.png", "main.json"])
    #expect(first.unchanged.isEmpty && first.removed.isEmpty)

    let second = try document.write(to: directory, as: .directory)
    #expect(second.written.isEmpty)
    #expect(second.unchanged.count == 4)

    document.body.entries[0].title = "Tuesday"
    let third = try document.write(to: directory, as: .directory)
    #expect(third.written == ["main.json"])

    document.resources["chart.png"] = Data([1, 2, 3])
    document.resources["harbour.png"] = nil
    document.body.entries[0].picture = .indirect(IndirectResource(filename: "chart.png"))
    let fourth = try document.write(to: directory, as: .directory)
    #expect(fourth.written == ["Data/chart.png", "main.json"])
    #expect(fourth.removed == ["Data/harbour.png"])
    #expect(try scratch.listing(of: directory) == ["Data/chart.png", "main.json", "manifest.json", "presets.json"])
    #expect(try StudioDocument<Notebook>(contentsOf: directory).body == document.body)
  }

  @Test func whatTheLibraryDoesNotKnowIsWrittenBack() throws {
    let main = #"""
      {"type_identifier": "org.example.notebook", "x-app": {"zoom": 1.25, "panes": [null, true]}, "version": "1.4",
       "entries": [{"title": "Monday", "later-member": [1, 2], "identifier": "e-1",
         "text": {"paragraphs": [{"identifier": "p-1", "x-mark": "kept", "contents": [
            {"run": {"string": "One."}}, {"footnote": {"number": 1}}, {"run": {"string": "Two.", "style": {"italic": true, "glow": 3}}}]}],
            "rich": {"blocks": []}, "primary_case": "rich"}}]}
      """#
    let scratch = try Scratch()
    let directory = scratch.file("source.package")
    try FileManager.default.createDirectory(
      at: directory.appendingPathComponent("Data/deep"), withIntermediateDirectories: true)
    try FileManager.default.createDirectory(
      at: directory.appendingPathComponent("Metadata"), withIntermediateDirectories: true)
    try Data(main.utf8).write(to: directory.appendingPathComponent("main.json"))
    try Data(#"{"package_version": "1.3", "generator": "another tool"}"#.utf8).write(
      to: directory.appendingPathComponent("manifest.json"))
    try Data(#"[{"identifier": "a", "properties": {"x": 1}, "x-origin": "import"}]"#.utf8).write(
      to: directory.appendingPathComponent("presets.json"))
    try Data([9, 9]).write(to: directory.appendingPathComponent("Data/picture.png"))
    try Data([7]).write(to: directory.appendingPathComponent("Data/deep/nested.bin"))
    try Data("{}".utf8).write(to: directory.appendingPathComponent("Metadata/info.json"))
    try Data([0]).write(to: directory.appendingPathComponent(".DS_Store"))
    try Data([0]).write(to: directory.appendingPathComponent("Data/.DS_Store"))

    let document = try StudioDocument<Notebook>(contentsOf: directory)
    #expect(document.resources.names == ["picture.png"])
    #expect(document.unmodelledEntries.map(\.name) == ["Data/deep/nested.bin", "Metadata/info.json"])
    #expect(document.manifest.packageVersion == FormatVersion(1, 3))

    let archive = scratch.file("copy.studio")
    try document.write(to: archive)
    let reader = try ZipReader(try Data(contentsOf: archive))
    let names = reader.entries.map(\.name)
    #expect(
      names == [
        "main.json", "manifest.json", "presets.json", "Data/picture.png", "Data/deep/nested.bin", "Metadata/info.json",
      ])
    var written: [String: JSONValue] = [:]
    for entry in reader.entries where entry.name.hasSuffix(".json") {
      written[entry.name] = try JSONValue(parsing: try reader.contents(of: entry))
    }
    // Every member is still there; the library has added only the type identifiers of the types it models.
    let original = try JSONValue(parsing: Data(main.utf8))
    let got = String(decoding: try #require(written["main.json"]).text(.readable), as: UTF8.self)
    #expect(got == (try goldens.want("preserved: main.json", got: got)))
    #expect(try #require(written["main.json"]).withoutTypeIdentifiers == original.withoutTypeIdentifiers)
    #expect(written["manifest.json"] == ["package_version": "1.3", "generator": "another tool"])
    #expect(written["presets.json"] == [["identifier": "a", "properties": ["x": 1], "x-origin": "import"]])

    let reopened = try StudioDocument<Notebook>(contentsOf: archive)
    #expect(reopened.body == document.body)
    #expect(reopened.unmodelledEntries == document.unmodelledEntries)
  }

  @Test func aPresentationOpensAndSavesAsItWas() throws {
    // The shape of a presentation, from Apple's documentation; the words are invented.
    let main = #"""
      {"type_identifier": "com.apple.apps.content-language.presentation",
       "theme": {"type_identifier": "com.apple.apps.content-language.keynote-theme", "name": "White"},
       "slide_size": {"type_identifier": "com.apple.apps.content-language.size", "width": 1920, "height": 1080},
       "slides": [{"type_identifier": "com.apple.apps.content-language.slide", "identifier": "slide-1", "depth": 1,
         "note": {"type_identifier": "com.apple.apps.content-language.text", "string": "Say where the boats went."},
         "contents": [{"type_identifier": "com.apple.apps.content-language.slide-object", "source_kind": "user",
           "object": {"type_identifier": "com.apple.apps.content-language.canvas-object",
             "textbox": {"type_identifier": "com.apple.apps.content-language.textbox", "preset_identifier": "theme-title",
               "geometry": {"type_identifier": "com.apple.apps.content-language.geometry",
                 "position": {"type_identifier": "com.apple.apps.content-language.position", "x": 160, "y": 120},
                 "size": {"type_identifier": "com.apple.apps.content-language.size", "width": 1600, "height": 160}},
               "stroke": "empty",
               "text": {"type_identifier": "com.apple.apps.content-language.text", "paragraphs": [
                 {"type_identifier": "com.apple.apps.content-language.paragraph", "contents": [
                   {"type_identifier": "com.apple.apps.content-language.paragraph.constituent",
                    "run": {"type_identifier": "com.apple.apps.content-language.text-run", "string": "Harbour notes"}}]}]}}}},
          {"type_identifier": "com.apple.apps.content-language.slide-object", "source_kind": "user",
           "object": {"type_identifier": "com.apple.apps.content-language.canvas-object",
             "image": {"type_identifier": "com.apple.apps.content-language.image",
               "resource": {"type_identifier": "com.apple.apps.content-language.resource",
                 "indirect": {"type_identifier": "com.apple.apps.content-language.resource.indirect-resource", "filename": "photo.jpg"}}}}}]}]}
      """#
    var writer = ZipWriter()
    try writer.add(Data(main.utf8), named: "main.json")
    try writer.add(Data([0xFF, 0xD8, 0xFF]), named: "Data/photo.jpg")
    let document = try StudioDocument<UntypedBody>(archive: writer.finish())
    #expect(document.body.typeIdentifier == "com.apple.apps.content-language.presentation")
    #expect(document.manifest.packageVersion == nil)
    #expect(document.validate().findings == [])

    let reopened = try StudioDocument<UntypedBody>(archive: try document.archive())
    #expect(reopened.body.tree == (try JSONValue(parsing: Data(main.utf8))))
    #expect(reopened.resources["photo.jpg"] == Data([0xFF, 0xD8, 0xFF]))
    #expect(reopened.manifest.packageVersion == Manifest.currentVersion)

    var edited = document
    edited.resources["photo.jpg"] = nil
    #expect(edited.validate().errors.map(\.kind) == [.missingResource(name: "photo.jpg")])
  }
}
