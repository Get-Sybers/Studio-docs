import Foundation
import GoldenFiles
import Testing
import ZipArchives

struct HostileCase: Sendable, CustomTestStringConvertible {
  var name: String
  var limits = ZipLimits.standard
  var build: @Sendable (inout ArchiveForge) -> Void
  var damage: @Sendable (Data) -> Data = { $0 }
  var testDescription: String { name }

  static let all: [HostileCase] = [
    HostileCase(name: "name climbs out", build: { $0.add("../outside.txt", "x") }),
    HostileCase(name: "name climbs out from below", build: { $0.add("Data/../../outside.txt", "x") }),
    HostileCase(name: "name is absolute", build: { $0.add("/etc/hosts", "x") }),
    HostileCase(name: "name holds a backslash", build: { $0.add("Data\\picture.png", "x") }),
    HostileCase(name: "name holds a NUL", build: { $0.add("main.json\u{0}.png", "x") }),
    HostileCase(name: "name is empty", build: { $0.add("", "x") }),
    HostileCase(name: "name has an empty component", build: { $0.add("Data//picture.png", "x") }),
    HostileCase(name: "name is a dot", build: { $0.add("./main.json", "x") }),
    HostileCase(
      name: "name is not UTF-8",
      build: { $0.add("x", "x") { $0.name = Data([0xC3, 0x28]) } }),
    HostileCase(
      name: "two entries share a name",
      build: {
        $0.add("main.json", "{}")
        $0.add("main.json", "[]")
      }),
    HostileCase(
      name: "more entries than the limit", limits: ZipLimits(maximumEntryCount: 2),
      build: {
        $0.add("a", "1")
        $0.add("b", "2")
        $0.add("c", "3")
      }),
    HostileCase(
      name: "entry larger than the limit", limits: ZipLimits(maximumEntrySize: 8),
      build: { $0.add("main.json", "123456789") }),
    HostileCase(
      name: "entry declares an absurd size",
      build: { $0.add("main.json", "{}") { $0.declaredSize = 0x7FFF_FFFF } }),
    HostileCase(
      name: "entries larger than the limit together", limits: ZipLimits(maximumTotalSize: 10),
      build: {
        $0.add("a", "123456")
        $0.add("b", "123456")
      }),
    HostileCase(
      name: "ratio beyond the limit", limits: ZipLimits(maximumCompressionRatio: 50, ratioThreshold: 1000),
      build: { $0.add("main.json", String(repeating: "a", count: 100_000)) }),
    HostileCase(
      name: "two entries claim the same bytes",
      build: {
        // The first file holds, as its contents, a whole record that the second entry points into.
        let inner = (try? ArchiveForge.storedRecord("b", "inner")) ?? Data()
        $0.parts.append(ArchiveForge.Part(name: Data("a".utf8), contents: inner, method: 0))
        $0.add("b", "inner") {
          $0.method = 0
          $0.offset = 31
        }
      }),
    HostileCase(name: "entry is encrypted", build: { $0.add("main.json", "{}") { $0.flags = 0x0801 } }),
    HostileCase(name: "entry uses another method", build: { $0.add("main.json", "{}") { $0.method = 14 } }),
    HostileCase(
      name: "header and directory disagree on the name",
      build: { $0.add("main.json", "{}") { $0.localName = Data("Main.json".utf8) } }),
    HostileCase(
      name: "header and directory disagree on the size",
      build: { $0.add("main.json", "{}") { $0.declaredSize = 3 } },
      damage: { bytes in
        // Only the directory keeps the false size; the header says the true one.
        var bytes = bytes
        bytes[22] = 2
        return bytes
      }),
    HostileCase(
      name: "stored entry declares two sizes",
      build: {
        $0.add("main.json", "{}") {
          $0.method = 0
          $0.declaredSize = 5
        }
      }),
    HostileCase(
      name: "directory is not where the end record says",
      build: {
        $0.add("a", "1")
        $0.directoryShift = 1
      }),
    HostileCase(
      name: "end record counts an entry that is absent",
      build: {
        $0.add("a", "1")
        $0.declaredCount = 2
      }),
    HostileCase(
      name: "archive spans disks",
      build: {
        $0.add("a", "1")
        $0.disk = 1
      }),
    HostileCase(
      name: "bytes follow the end record",
      build: {
        $0.add("a", "1")
        $0.trailer = Data([0])
      }),
    HostileCase(name: "cut short", build: { $0.add("a", "1") }, damage: { $0.prefix(20) }),
    HostileCase(name: "not an archive", build: { _ in }, damage: { _ in Data("{\"slides\": []}".utf8) }),
    HostileCase(name: "empty file", build: { _ in }, damage: { _ in Data() }),
  ]
}

struct CorruptCase: Sendable, CustomTestStringConvertible {
  var name: String
  var change: @Sendable (inout ArchiveForge.Part) -> Void
  var testDescription: String { name }

  static let all: [CorruptCase] = [
    CorruptCase(name: "checksum is wrong", change: { $0.checksum = 0xDEAD_BEEF }),
    CorruptCase(name: "stream expands beyond its declared size", change: { $0.declaredSize = 10 }),
    CorruptCase(name: "stream expands short of its declared size", change: { $0.declaredSize = 100_000 }),
    CorruptCase(name: "stream is not deflate", change: { $0.stored = Data([0xFF, 0xFF, 0xFF, 0xFF]) }),
    CorruptCase(name: "stream is cut short", change: { $0.stored = Data([0x4B]) }),
  ]
}

@Suite struct ZipReaderTests {
  let goldens: GoldenFile

  init() throws {
    goldens = try GoldenFile(named: "zip-archives", in: .module)
  }

  @Test(arguments: HostileCase.all)
  func refuses(_ item: HostileCase) throws {
    var forge = ArchiveForge()
    item.build(&forge)
    let bytes = item.damage(try forge.bytes())
    var got = "accepted"
    do throws(ZipError) {
      _ = try ZipReader(bytes, limits: item.limits)
    } catch {
      got = String(describing: error)
    }
    #expect(got == (try goldens.want("refuses: \(item.name)", got: got)))
    #expect(got != "accepted")
  }

  @Test(arguments: CorruptCase.all)
  func refusesCorruptContents(_ item: CorruptCase) throws {
    var forge = ArchiveForge()
    forge.add("main.json", String(repeating: "{\"key\": \"value\"}", count: 64), item.change)
    let reader = try ZipReader(try forge.bytes())
    let entry = try #require(reader.entries.first)
    var got = "accepted"
    do throws(ZipError) {
      _ = try reader.contents(of: entry)
    } catch {
      got = String(describing: error)
    }
    #expect(got == (try goldens.want("corrupt: \(item.name)", got: got)))
    #expect(got != "accepted")
  }

  @Test func readsWhatAnotherToolWrote() throws {
    var forge = ArchiveForge()
    forge.add("main.json", "{\"slides\": []}")
    forge.add("Data/", "") { $0.method = 0 }
    forge.add("Data/picture.png", "not really a picture") { $0.method = 0 }
    forge.comment = Data("a comment".utf8)
    let reader = try ZipReader(try forge.bytes())
    #expect(reader.entries.map(\.name) == ["main.json", "Data/picture.png"])
    #expect(try reader.contents(of: reader.entries[1]) == Data("not really a picture".utf8))
  }

  @Test func readsZip64Records() throws {
    var forge = ArchiveForge()
    forge.add("main.json", "{\"slides\": []}")
    forge.add("Data/picture.png", "not really a picture")
    forge.usesZip64 = true
    let reader = try ZipReader(try forge.bytes())
    #expect(reader.entries.map(\.name) == ["main.json", "Data/picture.png"])
    #expect(try reader.contents(of: reader.entries[1]) == Data("not really a picture".utf8))
  }

  @Test func readsASliceOfALargerBuffer() throws {
    var forge = ArchiveForge()
    forge.add("main.json", "{}")
    let archive = try forge.bytes()
    let padded = Data([1, 2, 3]) + archive
    let reader = try ZipReader(padded[3...])
    #expect(try reader.contents(of: reader.entries[0]) == Data("{}".utf8))
  }
}
