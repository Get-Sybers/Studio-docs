import Foundation
import GoldenFiles
import Testing

@Suite struct GoldenFileTests {
  @Test(arguments: ["first", "second"])
  func returnsTheRecordedText(_ key: String) throws {
    let goldens = try GoldenFile(named: "golden-files", in: .module)
    let got = "the text of the \(key) case\nwith a second line"
    #expect(try goldens.want(key, got: got) == got)
  }

  @Test func refusesAnUnknownFile() {
    guard ProcessInfo.processInfo.environment["UPDATE_GOLDENS"] != "1" else { return }
    #expect(throws: GoldenError.self) { _ = try GoldenFile(named: "no-such-file", in: .module) }
  }

  @Test func refusesAnUnknownCase() throws {
    guard ProcessInfo.processInfo.environment["UPDATE_GOLDENS"] != "1" else { return }
    let goldens = try GoldenFile(named: "golden-files", in: .module)
    #expect(throws: GoldenError.self) { _ = try goldens.want("a case nobody recorded", got: "") }
  }
}
