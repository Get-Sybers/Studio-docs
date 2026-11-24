// swift-tools-version: 6.4
import PackageDescription

let native: [SwiftSetting] = [
  .swiftLanguageMode(.v6),
  .enableUpcomingFeature("ExistentialAny"),
  .enableUpcomingFeature("InternalImportsByDefault"),
  .enableUpcomingFeature("MemberImportVisibility"),
  .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
  .strictMemorySafety(),
  .treatAllWarnings(as: .error),
]

let ordered: Target.Dependency = .product(name: "OrderedCollections", package: "swift-collections")
let bits: Target.Dependency = .product(name: "BitCollections", package: "swift-collections")

// A library of one concern; `table` says that it embeds a format table, Resources/format.json.
func library(_ name: String, needs dependencies: [Target.Dependency] = [], table: Bool = false) -> Target {
  .target(
    name: name, dependencies: dependencies, resources: table ? [.embedInCode("Resources/format.json")] : [],
    swiftSettings: native)
}

// The tests of a library; `data` says that they have a folder testdata of goldens and fixtures.
func tests(of name: String, with dependencies: [Target.Dependency] = [], data: Bool = true) -> Target {
  .testTarget(
    name: name + "Tests", dependencies: [.byName(name: name)] + dependencies,
    resources: data ? [.copy("testdata")] : [], swiftSettings: native)
}

let package = Package(
  name: "Studio-docs",
  platforms: [.macOS(.v27)],
  products: [
    .library(
      name: "StudioDocs",
      targets: ["Appearance", "JSONTree", "ResourceReferences", "TextModel", "WireFormat", "ZipArchives"])
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-collections", from: "1.7.0")
  ],
  targets: [
    library("RawDeflate"),
    library("ZipArchives", needs: ["RawDeflate", ordered]),
    library("JSONTree", needs: [ordered]),
    library("WireFormat", needs: ["JSONTree", bits]),
    library("ResourceReferences", needs: ["JSONTree", "WireFormat"], table: true),
    library("GoldenFiles"),
    library("ModelFixtures", needs: ["JSONTree", "WireFormat"]),

    tests(of: "RawDeflate", data: false),
    tests(of: "ZipArchives", with: ["GoldenFiles", "RawDeflate"]),
    tests(of: "JSONTree", with: ["GoldenFiles"]),
    tests(of: "WireFormat", with: ["GoldenFiles", "JSONTree"]),
    tests(of: "ResourceReferences", with: ["GoldenFiles", "JSONTree", "ModelFixtures", "WireFormat"]),
    tests(of: "GoldenFiles"),
    tests(of: "ModelFixtures", with: ["JSONTree", "WireFormat"]),
  ]
)
