import Foundation
import RawDeflate
import Testing

struct DeflateCase: Sendable, CustomTestStringConvertible {
  var name: String
  var bytes: Data
  var testDescription: String { name }

  static let all: [DeflateCase] = [
    DeflateCase(name: "empty", bytes: Data()),
    DeflateCase(name: "one byte", bytes: Data([0x41])),
    DeflateCase(name: "prose", bytes: Data("The tide went out and left the boats leaning.".utf8)),
    DeflateCase(name: "repetitive", bytes: Data(String(repeating: "tick tock ", count: 20_000).utf8)),
    DeflateCase(name: "noise", bytes: noise(count: 70_000, seed: 0x5EED)),
  ]

  // A fixed generator, so the bytes are the same on every run.
  static func noise(count: Int, seed: UInt64) -> Data {
    var state = seed
    var bytes = Data(capacity: count)
    for _ in 0..<count {
      state = state &* 6_364_136_223_846_793_005 &+ 1_442_695_040_888_963_407
      bytes.append(UInt8(truncatingIfNeeded: state >> 33))
    }
    return bytes
  }
}

struct DamagedCase: Sendable, CustomTestStringConvertible {
  var name: String
  var damage: @Sendable (Data) -> Data
  var count: Int
  var want: DeflateError
  var testDescription: String { name }

  static let source = Data(String(repeating: "a line of text\n", count: 400).utf8)

  static let all: [DamagedCase] = [
    DamagedCase(name: "cut short", damage: { $0.dropLast(4) }, count: source.count, want: .truncated),
    DamagedCase(
      name: "declares too little", damage: { $0 }, count: source.count - 1,
      want: .sizeMismatch(expected: source.count - 1)),
    DamagedCase(
      name: "declares too much", damage: { $0 }, count: source.count + 1,
      want: .sizeMismatch(expected: source.count + 1)),
    DamagedCase(
      name: "bytes after the end", damage: { $0 + Data([0, 0, 0]) }, count: source.count, want: .trailingBytes),
    DamagedCase(
      name: "not a stream", damage: { _ in Data([0xFF, 0xFF, 0xFF, 0xFF]) }, count: 4, want: .corrupt(status: -3)),
  ]
}

@Suite struct DeflateStreamTests {
  @Test(arguments: DeflateCase.all)
  func roundTrip(_ item: DeflateCase) throws {
    let packed = try DeflateStream.deflate(item.bytes)
    let got = try DeflateStream.inflate(packed, count: item.bytes.count)
    #expect(got == item.bytes)
  }

  @Test(arguments: DamagedCase.all)
  func refusesDamage(_ item: DamagedCase) throws {
    let packed = try DeflateStream.deflate(DamagedCase.source)
    #expect(throws: item.want) {
      _ = try DeflateStream.inflate(item.damage(packed), count: item.count)
    }
  }

  @Test func repetitionShrinks() throws {
    let source = DeflateCase.all[3].bytes
    let packed = try DeflateStream.deflate(source)
    #expect(packed.count * 100 < source.count)
  }

  @Test(arguments: [("", UInt32(0)), ("123456789", UInt32(0xCBF4_3926)), ("a", UInt32(0xE8B7_BE43))])
  func checksum(_ text: String, _ want: UInt32) {
    #expect(CyclicRedundancyCheck.checksum(Data(text.utf8)) == want)
  }

  @Test func checksumOfASliceIgnoresItsOffset() {
    let whole = Data("xx123456789yy".utf8)
    #expect(CyclicRedundancyCheck.checksum(whole[2..<11]) == 0xCBF4_3926)
  }
}
