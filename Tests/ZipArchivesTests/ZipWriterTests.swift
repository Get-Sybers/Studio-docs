import Foundation
import GoldenFiles
import Testing
import ZipArchives

struct WrittenCase: Sendable, CustomTestStringConvertible {
  var name: String
  var files: [(name: String, contents: Data, compression: ZipCompression)]
  var testDescription: String { name }

  static let all: [WrittenCase] = [
    WrittenCase(name: "no entries", files: []),
    WrittenCase(name: "one empty file", files: [("main.json", Data(), .deflated)]),
    WrittenCase(
      name: "a document",
      files: [
        ("main.json", Data(String(repeating: "{\"type_identifier\": \"example\"}", count: 40).utf8), .deflated),
        ("manifest.json", Data("{\"package_version\":\"1.0\"}".utf8), .deflated),
        ("Data/naïve café ☕️.png", Data([0x89, 0x50, 0x4E, 0x47, 0, 1, 2, 3]), .stored),
      ]),
    WrittenCase(
      name: "bytes that do not shrink",
      files: [("Data/noise.bin", Data((0..<64).map { UInt8(truncatingIfNeeded: $0 &* 151 &+ 17) }), .deflated)]),
  ]
}

@Suite struct ZipWriterTests {
  let goldens: GoldenFile

  init() throws {
    goldens = try GoldenFile(named: "zip-archives", in: .module)
  }

  @Test(arguments: WrittenCase.all)
  func roundTrip(_ item: WrittenCase) throws {
    var writer = ZipWriter()
    for file in item.files {
      try writer.add(file.contents, named: file.name, compression: file.compression)
    }
    let archive = writer.finish()
    let reader = try ZipReader(archive)
    #expect(reader.entries.map(\.name) == item.files.map(\.name))
    for (entry, file) in zip(reader.entries, item.files) {
      #expect(try reader.contents(of: entry) == file.contents)
    }
    let listing = reader.entries.map { "\($0.name) \($0.compression) \($0.storedSize)/\($0.size)" }
    let got = (listing + ["\(archive.count) bytes"]).joined(separator: "\n")
    #expect(got == (try goldens.want("written: \(item.name)", got: got)))
  }

  @Test func equalContentsGiveEqualBytes() throws {
    var first = ZipWriter()
    var second = ZipWriter()
    try first.add(Data("{}".utf8), named: "main.json")
    try second.add(Data("{}".utf8), named: "main.json")
    let got = first.finish().map { String($0, radix: 16) }.joined(separator: " ")
    #expect(first.finish() == second.finish())
    #expect(got == (try goldens.want("bytes of the smallest archive", got: got)))
  }

  @Test func zip64RecordsAreWrittenWhereASizeOrACountNeedsThem() throws {
    var writer = ZipWriter(zip64Threshold: Zip64Threshold(size: 16, count: 2))
    let files = [
      ("a.txt", Data(repeating: 0x61, count: 20)), ("b.txt", Data("short".utf8)),
      ("c.txt", Data(repeating: 0x63, count: 40)),
    ]
    for (name, contents) in files {
      try writer.add(contents, named: name, compression: .stored)
    }
    let archive = writer.finish()
    let reader = try ZipReader(archive)
    #expect(reader.entries.map(\.name) == files.map(\.0))
    for (entry, file) in zip(reader.entries, files) {
      #expect(try reader.contents(of: entry) == file.1)
    }
    let got = archive.map { String($0, radix: 16) }.joined(separator: " ")
    #expect(got == (try goldens.want("bytes of a Zip64 archive", got: got)))
  }

  @Test func moreEntriesThanAnEndRecordCountsAreReadBack() throws {
    var writer = ZipWriter()
    for index in 0..<65_536 {
      try writer.add(Data(), named: "entries/\(index)", compression: .stored)
    }
    let reader = try ZipReader(writer.finish(), limits: ZipLimits(maximumEntryCount: 70_000))
    #expect(reader.entries.count == 65_536)
    #expect(reader.entries.last?.name == "entries/65535")
  }

  @Test(arguments: ["../up.txt", "/root.txt", "Data/", "", "a\\b"])
  func refusesAnUnsafeName(_ name: String) {
    var writer = ZipWriter()
    #expect(throws: ZipError.hostile(.unsafeEntryName(name))) { try writer.add(Data(), named: name) }
  }

  @Test func refusesARepeatedName() throws {
    var writer = ZipWriter()
    try writer.add(Data(), named: "main.json")
    #expect(throws: ZipError.hostile(.duplicateEntry("main.json"))) { try writer.add(Data(), named: "main.json") }
  }
}
