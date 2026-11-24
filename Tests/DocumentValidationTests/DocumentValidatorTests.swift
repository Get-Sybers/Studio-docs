import DocumentValidation
import Foundation
import GoldenFiles
import JSONTree
import PresetStyles
import Testing
import TextModel
import WireFormat

/// A document with one thing wrong, written as JSON; `@name` stands for a type identifier of the format.
struct ValidationCase: Sendable, CustomTestStringConvertible {
  var name: String
  var main: String
  var presets = "[]"
  var resources: [String] = []
  var isSelfContained = true
  var testDescription: String { name }

  func input() throws -> ValidationInput {
    let expand = { (text: String) in
      Data(text.replacingOccurrences(of: "\"@", with: "\"com.apple.apps.content-language.").utf8)
    }
    return ValidationInput(
      main: try JSONValue(parsing: expand(main)),
      presets: try PresetLibrary(wire: try JSONValue(parsing: expand(presets))),
      resourceNames: resources, isSelfContained: isSelfContained, schemas: .text)
  }

  static let levels = Array(
    repeating: #"{"type_identifier": "@list-level-type", "label_indent": 0, "text_indent": 1.5, "label": "none"}"#,
    count: 10
  ).joined(separator: ", ")

  static let errors: [ValidationCase] = [
    ValidationCase(
      name: "a required member is absent",
      main: #"{"type_identifier": "@text-run", "style": {"type_identifier": "@character-properties"}}"#),
    ValidationCase(name: "a required member is null", main: #"{"type_identifier": "@text-run", "string": null}"#),
    ValidationCase(name: "an optional member is null", main: #"{"type_identifier": "@paragraph", "contents": null}"#),
    ValidationCase(
      name: "a number lies outside its range",
      main: #"{"type_identifier": "@color.rgba", "red": 1.5, "alpha": -0.1, "headroom": 20}"#),
    ValidationCase(
      name: "an array is longer than its member allows",
      main:
        #"{"type_identifier": "@column-metrics.unequal-columns-description", "column_widths": [9,9,9,9,9,9,9,9,9,9,10], "gutter_widths": [0,0,0,0,0,0,0,0,0,0]}"#
    ),
    ValidationCase(
      name: "a version is not major.minor", main: #"{"type_identifier": "@text-run", "string": "x", "version": "one"}"#),
    ValidationCase(
      name: "a version is no string", main: #"{"type_identifier": "@text-run", "string": "x", "version": 1.0}"#),
    ValidationCase(name: "a union holds no case", main: #"{"fill": {"type_identifier": "@fill"}}"#),
    ValidationCase(name: "a member is of the wrong kind", main: #"{"type_identifier": "@text-run", "string": 5}"#),
    ValidationCase(
      name: "a fault deep inside is reported once, where it lies",
      main: #"""
        {"type_identifier": "@text", "paragraphs": [{"type_identifier": "@paragraph", "contents": [
          {"type_identifier": "@paragraph.constituent", "run": {"type_identifier": "@text-run", "string": "fine", "style":
            {"type_identifier": "@character-properties", "bold": "yes"}}}]}]}
        """#),
    ValidationCase(
      name: "an object declares a later major version",
      main: #"{"type_identifier": "@text-run", "string": "x", "version": "2.0"}"#),
    ValidationCase(
      name: "two objects carry one identifier",
      main:
        #"{"sections": [{"identifier": "s-1", "paragraphs": [{"identifier": "p-1"}, {"identifier": "p-1"}]}, {"identifier": "p-1"}]}"#
    ),
    ValidationCase(
      name: "an indirect resource names no stored file",
      main: #"{"type_identifier": "@resource.indirect-resource", "filename": "Shown.png", "identifier": "stored.png"}"#,
      resources: ["Shown.png"]),
    ValidationCase(
      name: "an indirect resource falls back on its filename",
      main: #"{"type_identifier": "@resource.indirect-resource", "filename": "absent.png"}"#, resources: ["other.png"]),
    ValidationCase(
      name: "an indirect resource has a blank name",
      main: #"{"type_identifier": "@resource.indirect-resource", "filename": "  "}"#),
    ValidationCase(
      name: "an indirect resource takes a missing name from a preset",
      main: #"{"type_identifier": "@resource.indirect-resource", "preset_identifier": "picture"}"#,
      presets: #"[{"identifier": "picture", "properties": {"filename": "ghost.png"}}]"#, resources: ["real.png"]),
    ValidationCase(
      name: "an embedded resource is not Base64",
      main: #"{"type_identifier": "@resource.base64-encoded-resource", "string": "not base64!", "filename": " "}"#),
    ValidationCase(
      name: "a preset has an empty identifier", main: "{}", presets: #"[{"identifier": "", "properties": {}}]"#),
    ValidationCase(
      name: "two presets share an identifier", main: "{}",
      presets: #"[{"identifier": "body", "properties": {}}, {"identifier": "body", "properties": {"bold": true}}]"#),
    ValidationCase(
      name: "the parents of presets form a ring", main: "{}",
      presets:
        #"[{"identifier": "a", "parent_identifier": "b", "properties": {}}, {"identifier": "b", "parent_identifier": "a", "properties": {}}]"#
    ),
    ValidationCase(
      name: "a preset is reached again through a value it holds", main: "{}",
      presets:
        #"[{"identifier": "a", "parent_identifier": "b", "properties": {}}, {"identifier": "b", "properties": {"fill": {"preset_identifier": "a"}}}]"#
    ),
    ValidationCase(
      name: "a link has no target",
      main:
        #"{"links": [{"type_identifier": "@hyperlink", "url": "  "}, {"type_identifier": "@hyperlink", "file": ""}]}"#),
    ValidationCase(
      name: "a link gives a file as a URL",
      main: #"{"type_identifier": "@hyperlink", "url": "FILE:///notes/tides.txt"}"#),
    ValidationCase(
      name: "unequal columns have too few gutters",
      main: #"{"type_identifier": "@column-metrics.unequal-columns-description", "column_widths": [50, 50]}"#),
    ValidationCase(
      name: "unequal columns do not total 100",
      main:
        #"{"type_identifier": "@column-metrics.unequal-columns-description", "column_widths": [40, 40], "gutter_widths": [5]}"#
    ),
    ValidationCase(
      name: "a resource has a name that leaves Data", main: "{}", resources: ["../outside.png", "a/b.png", "", ".."]),
    ValidationCase(
      name: "a fault inside a preset's value", main: "{}",
      presets:
        #"[{"identifier": "ink", "properties": {"color": {"type_identifier": "@color", "rgba": {"type_identifier": "@color.rgba", "red": 7}}}}]"#
    ),
  ]

  static let warnings: [ValidationCase] = [
    ValidationCase(
      name: "a run inside a paragraph holds a paragraph separator",
      main: #"""
        {"type_identifier": "@paragraph", "contents": [
          {"type_identifier": "@paragraph.constituent", "run": {"type_identifier": "@text-run", "string": "one\ntwo"}},
          {"type_identifier": "@paragraph.constituent", "run": {"type_identifier": "@text-run", "string": "a line separator is fine"}},
          {"type_identifier": "@paragraph.constituent", "run": {"type_identifier": "@text-run", "string": "carriage\rreturn"}},
          {"type_identifier": "@paragraph.constituent", "hyperlink": {"type_identifier": "@paragraph.hyperlink-field",
            "target": {"type_identifier": "@hyperlink", "url": "https://example.org"},
            "run": {"type_identifier": "@text-run", "string": "para separator"}}}]}
        """#),
    ValidationCase(
      name: "a plain string and a list of runs may hold them",
      main:
        #"{"a": {"type_identifier": "@text", "string": "one\ntwo"}, "b": {"type_identifier": "@text", "text_runs": [{"type_identifier": "@text-run", "string": "one\ntwo"}]}}"#
    ),
    ValidationCase(
      name: "a paragraph before the last has no break",
      main:
        #"{"type_identifier": "@text", "paragraphs": [{"type_identifier": "@paragraph", "break_type": "none"}, {"type_identifier": "@paragraph", "break_type": "none"}]}"#
    ),
    ValidationCase(
      name: "list numbers and levels beyond what a reader keeps",
      main: #"""
        {"paragraphs": [{"type_identifier": "@paragraph", "list_level": 9, "list_start": -1},
          {"type_identifier": "@paragraph", "list_level": -1, "list_start": 4294967296}],
         "style": {"type_identifier": "@paragraph-properties", "outline_level": 1000, "tabs": [{"type_identifier": "@tab-stop-type", "position": 0}]},
         "list": {"type_identifier": "@list-properties", "levels": [\#(levels)]}}
        """#),
    ValidationCase(
      name: "a gradient a reader repairs",
      main: #"""
        {"short": {"type_identifier": "@fill.gradient", "stops": [{"type_identifier": "@fill.gradient.stop", "color": "x", "fraction": 0.5}],
                   "flavor": {"type_identifier": "@fill.gradient.flavor", "linear": {"type_identifier": "@fill.gradient.flavor.linear", "angle": 90,
                     "start_point": {"type_identifier": "@position", "x": 0, "y": 0}}}},
         "unordered": {"type_identifier": "@fill.gradient", "flavor": {"type_identifier": "@fill.gradient.flavor", "linear": {"type_identifier": "@fill.gradient.flavor.linear", "angle": 0}},
           "stops": [{"type_identifier": "@fill.gradient.stop", "color": {"type_identifier": "@color", "rgba": {"type_identifier": "@color.rgba"}}, "fraction": 0.9},
                     {"type_identifier": "@fill.gradient.stop", "color": {"type_identifier": "@color", "rgba": {"type_identifier": "@color.rgba"}}, "fraction": 0.1}]}}
        """#),
    ValidationCase(
      name: "a number format with a setting its numerals lack",
      main: #"""
        {"formats": [{"type_identifier": "@number-format-type", "kind": "numeric", "upper": true},
          {"type_identifier": "@number-format-type", "kind": "roman", "upper": true},
          {"type_identifier": "@number-format-type", "kind": "alpha", "formal": true},
          {"type_identifier": "@number-format-type", "kind": "hebrew", "format": "circled"},
          {"type_identifier": "@number-format-type", "format": "standard"},
          {"type_identifier": "@number-format-type", "kind": "hebrew_biblical", "format": "standard"}]}
        """#),
    ValidationCase(
      name: "a premium resource with an asset identifier that is no UUID",
      main:
        #"{"type_identifier": "@resource.premium-resource-info", "asset_uuid": "not-a-uuid", "is_derived_asset": false, "may_need_watermark": true}"#
    ),
    ValidationCase(
      name: "an object adopts a preset the document lacks",
      main:
        #"{"run": {"type_identifier": "@text-run", "string": "x", "style": {"type_identifier": "@character-properties", "preset_identifier": "gone"}}}"#
    ),
    ValidationCase(
      name: "a document that leans on a theme may adopt what it lacks",
      main:
        #"{"run": {"type_identifier": "@text-run", "string": "x", "identifier": "a", "style": {"type_identifier": "@character-properties", "preset_identifier": "gone"}}, "again": {"identifier": "a"}}"#,
      isSelfContained: false),
    ValidationCase(
      name: "a style of the stylesheet is a name to adopt",
      main: #"""
        {"stylesheet": {"type_identifier": "@stylesheet", "character_styles": [{"type_identifier": "@stylesheet.character-style", "name": "Stress",
           "preset_identifier": "stress", "properties": {"type_identifier": "@character-properties", "italic": true}}]},
         "style": {"type_identifier": "@character-properties", "preset_identifier": "stress"}}
        """#),
    ValidationCase(
      name: "a preset names a parent the document lacks",
      main: "{}", presets: #"[{"identifier": "child", "parent_identifier": "gone", "properties": {}}]"#),
    ValidationCase(
      name: "an object declares a later minor version",
      main: #"{"type_identifier": "@color.rgba", "version": "1.4", "red": 1, "glow": 2}"#),
    ValidationCase(
      name: "a union names a primary case the library lacks",
      main:
        #"{"type_identifier": "@fill", "color": {"type_identifier": "@color", "rgba": {"type_identifier": "@color.rgba"}}, "mesh": {"points": 9}, "primary_case": "mesh"}"#
    ),
    ValidationCase(name: "an identifier is the empty string", main: #"{"identifier": ""}"#),
    ValidationCase(
      name: "a link names an identifier no object carries",
      main:
        #"{"identifier": "here", "a": {"type_identifier": "@hyperlink.slide-target", "by_identifier": "there"}, "b": {"type_identifier": "@hyperlink.slide-target", "by_identifier": "here"}}"#
    ),
    ValidationCase(
      name: "two resources differ only in case or composition", main: "{}",
      resources: ["Cafe\u{301}.png", "caf\u{E9}.png", "other.png"]),
  ]
}

@Suite struct DocumentValidatorTests {
  let goldens: GoldenFile

  init() throws {
    goldens = try GoldenFile(named: "document-validation", in: .module)
  }

  @Test(arguments: ValidationCase.errors)
  func refuses(_ item: ValidationCase) throws {
    let report = DocumentValidator.validate(try item.input())
    let got = report.findings.map(\.description).joined(separator: "\n")
    #expect(got == (try goldens.want("refuses: \(item.name)", got: got)))
    #expect(!report.isSaveable)
    #expect(!report.errors.isEmpty)
  }

  @Test(arguments: ValidationCase.warnings)
  func warns(_ item: ValidationCase) throws {
    let report = DocumentValidator.validate(try item.input())
    let got = report.findings.map(\.description).joined(separator: "\n")
    #expect(got == (try goldens.want("warns: \(item.name)", got: got)))
    #expect(report.isSaveable)
    #expect(report.errors.isEmpty)
  }

  @Test func aNumberThatIsNotFiniteIsRefused() {
    let input = ValidationInput(main: ["size": .double(.infinity), "list": [.double(.nan)]], schemas: .text)
    let report = DocumentValidator.validate(input)
    #expect(
      report.findings.map(\.description) == [
        "error main.json size: nonFiniteNumber", "error main.json list[0]: nonFiniteNumber",
      ])
  }

  @Test func aSoundDocumentHasNoFindings() throws {
    var styled = Paragraph(contents: [
      .text("Low water at "), .text("six", style: CharacterProperties(italic: true)), .text("."),
    ])
    styled.identifier = "p-2"
    styled.style = ParagraphProperties(alignment: .value(.justified))
    styled.style?.presetIdentifier = "body"
    var first = Paragraph("Harbour notes")
    first.identifier = "p-1"
    let input = ValidationInput(
      main: [
        "type_identifier": "org.example.notes", "identifier": "notes",
        "text": TextBody.paragraphs([first, styled]).wireValue,
      ],
      presets: [Preset(identifier: "body", properties: ParagraphProperties(spaceAfter: 6))],
      resourceNames: ["cover.png"], schemas: .text)
    #expect(DocumentValidator.validate(input).findings == [])
  }

  @Test func everyModelledTypeHasACheck() {
    #expect(DocumentValidator.checkedTypes == SchemaRegistry.text.typeIdentifiers.map(\.rawValue))
  }

  @Test func aFindingCarriesItsSeverityAndItsPlace() {
    let finding = ValidationFinding(.unknownPreset("gone"), in: .main, at: JSONPath([.member("style")]))
    #expect(finding.severity == .warning)
    #expect(finding.description == "warning main.json style: unknownPreset(\"gone\")")
    #expect(ValidationFinding(.custom(name: "scene-order", detail: "x"), in: .main).severity == .error)
    #expect(
      ValidationFinding(.custom(name: "scene-order", detail: "x"), in: .main, severity: .warning).severity == .warning)
    #expect(ValidationFinding.Severity.warning < .error)
    let report = ValidationReport([finding])
    #expect(report.warnings == [finding])
    #expect(report.isSaveable)
  }
}
