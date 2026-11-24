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
let trees: Target.Dependency = .product(name: "HashTreeCollections", package: "swift-collections")

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
      targets: [
        "Appearance", "AttributedText", "CanvasCommon", "CanvasModel", "ChartModel", "DocumentIdentifiers",
        "DocumentPackage",
        "DocumentValidation", "JSONTree", "PresentationModel", "PresetStyles", "ResourceReferences", "TableModel",
        "TextDocument", "TextModel", "WireFormat", "ZipArchives",
      ])
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-collections", from: "1.7.0")
  ],
  targets: [
    library("RawDeflate"),
    library("ZipArchives", needs: ["RawDeflate", ordered]),
    library("JSONTree", needs: [ordered]),
    library("WireFormat", needs: ["JSONTree", bits]),
    library("PresetStyles", needs: ["JSONTree", "WireFormat", ordered]),
    library("DocumentIdentifiers", needs: ["JSONTree", "WireFormat", trees]),
    library("ResourceReferences", needs: ["JSONTree", "WireFormat"], table: true),
    library("Appearance", needs: ["JSONTree", "ResourceReferences", "WireFormat"], table: true),
    library(
      "TextModel", needs: ["Appearance", "JSONTree", "PresetStyles", "ResourceReferences", "WireFormat"],
      table: true),
    library(
      "DocumentValidation",
      needs: [
        "Appearance", "DocumentIdentifiers", "JSONTree", "PresetStyles", "ResourceReferences", "TextModel",
        "WireFormat",
      ]),
    library(
      "DocumentPackage",
      needs: [
        "DocumentValidation", "JSONTree", "PresetStyles", "ResourceReferences", "TextModel", "WireFormat",
        "ZipArchives", ordered,
      ]),
    library("TextDocument", needs: ["DocumentPackage", "TextModel", "WireFormat"], table: true),
    library("CanvasCommon", needs: ["Appearance", "JSONTree", "TextModel", "WireFormat"], table: true),
    library("TableModel", needs: ["Appearance", "CanvasCommon", "JSONTree", "TextModel", "WireFormat"], table: true),
    library(
      "ChartModel", needs: ["Appearance", "CanvasCommon", "JSONTree", "TableModel", "TextModel", "WireFormat"],
      table: true),
    library(
      "CanvasModel",
      needs: [
        "Appearance", "CanvasCommon", "ChartModel", "JSONTree", "ResourceReferences", "TableModel", "TextModel",
        "WireFormat",
      ], table: true),
    library(
      "PresentationModel",
      needs: [
        "Appearance", "CanvasCommon", "CanvasModel", "ChartModel", "DocumentPackage", "DocumentValidation", "JSONTree",
        "TableModel", "TextModel", "WireFormat",
      ], table: true),
    library("AttributedText", needs: ["TextModel", "WireFormat"]),
    library("GoldenFiles"),
    library("ModelFixtures", needs: ["JSONTree", "WireFormat"]),

    tests(of: "RawDeflate", data: false),
    tests(of: "ZipArchives", with: ["GoldenFiles", "RawDeflate"]),
    tests(of: "JSONTree", with: ["GoldenFiles"]),
    tests(of: "WireFormat", with: ["GoldenFiles", "JSONTree"]),
    tests(of: "DocumentIdentifiers", with: ["GoldenFiles", "JSONTree", "TextModel", "WireFormat"]),
    tests(
      of: "DocumentValidation",
      with: ["Appearance", "GoldenFiles", "JSONTree", "PresetStyles", "ResourceReferences", "TextModel", "WireFormat"]),
    tests(
      of: "DocumentPackage",
      with: [
        "DocumentValidation", "GoldenFiles", "JSONTree", "ModelFixtures", "PresetStyles", "ResourceReferences",
        "TextModel", "WireFormat", "ZipArchives",
      ]),
    tests(of: "PresetStyles", with: ["Appearance", "GoldenFiles", "JSONTree", "TextModel", "WireFormat"]),
    tests(of: "ResourceReferences", with: ["GoldenFiles", "JSONTree", "ModelFixtures", "WireFormat"]),
    tests(of: "Appearance", with: ["GoldenFiles", "JSONTree", "ModelFixtures", "WireFormat"]),
    tests(of: "TextModel", with: ["Appearance", "GoldenFiles", "JSONTree", "ModelFixtures", "WireFormat"]),
    tests(
      of: "TextDocument",
      with: [
        "DocumentPackage", "DocumentValidation", "GoldenFiles", "JSONTree", "ModelFixtures", "PresetStyles",
        "TextModel", "WireFormat",
      ]),
    tests(of: "AttributedText", with: ["DocumentIdentifiers", "GoldenFiles", "JSONTree", "TextModel", "WireFormat"]),
    tests(
      of: "CanvasCommon", with: ["Appearance", "GoldenFiles", "JSONTree", "ModelFixtures", "TextModel", "WireFormat"]),
    tests(
      of: "TableModel",
      with: ["Appearance", "CanvasCommon", "GoldenFiles", "JSONTree", "ModelFixtures", "TextModel", "WireFormat"]),
    tests(
      of: "ChartModel",
      with: [
        "Appearance", "CanvasCommon", "GoldenFiles", "JSONTree", "ModelFixtures", "TableModel", "TextModel",
        "WireFormat",
      ]),
    tests(
      of: "CanvasModel",
      with: [
        "Appearance", "CanvasCommon", "ChartModel", "GoldenFiles", "JSONTree", "ModelFixtures", "ResourceReferences",
        "TableModel", "TextModel", "WireFormat",
      ]),
    tests(
      of: "PresentationModel",
      with: [
        "Appearance", "CanvasCommon", "CanvasModel", "DocumentPackage", "DocumentValidation", "GoldenFiles", "JSONTree",
        "ModelFixtures", "TableModel", "TextModel", "WireFormat", "ZipArchives",
      ]),
    tests(of: "GoldenFiles"),
    tests(of: "ModelFixtures", with: ["JSONTree", "WireFormat"]),
  ]
)
