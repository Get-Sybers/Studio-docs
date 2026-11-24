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

// A library of one concern.
func library(_ name: String, needs dependencies: [Target.Dependency] = []) -> Target {
  .target(name: name, dependencies: dependencies, swiftSettings: native)
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
    .library(name: "StudioDocs", targets: ["JSONTree", "ZipArchives"])
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-collections", from: "1.7.0")
  ],
  targets: [
    library("RawDeflate"),
    library("ZipArchives", needs: ["RawDeflate", ordered]),
    library("JSONTree", needs: [ordered]),
    library("GoldenFiles"),

    tests(of: "RawDeflate", data: false),
    tests(of: "ZipArchives", with: ["GoldenFiles", "RawDeflate"]),
    tests(of: "JSONTree", with: ["GoldenFiles"]),
    tests(of: "GoldenFiles"),
  ]
)
