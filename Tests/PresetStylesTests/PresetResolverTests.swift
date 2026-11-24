import Appearance
import Foundation
import GoldenFiles
import JSONTree
import PresetStyles
import Testing
import TextModel
import WireFormat

struct ChainCase: Sendable, CustomTestStringConvertible {
  var name: String
  var presets: [Preset]
  var resolve: String
  var testDescription: String { name }

  static let all: [ChainCase] = [
    ChainCase(
      name: "the nearest preset wins",
      presets: [
        Preset(identifier: "grandparent", properties: ["a": 1, "b": 1, "c": 1]),
        Preset(identifier: "parent", properties: ["b": 2, "c": 2], parentIdentifier: "grandparent"),
        Preset(identifier: "child", properties: ["c": 3], parentIdentifier: "parent"),
      ], resolve: "child"),
    ChainCase(
      name: "a null in a child clears what the parent sets",
      presets: [
        Preset(identifier: "parent", properties: ["space_after": 10, "bold": true]),
        Preset(identifier: "child", properties: ["space_after": nil], parentIdentifier: "parent"),
      ], resolve: "child"),
    ChainCase(
      name: "two children share a parent",
      presets: [
        Preset(identifier: "parent", properties: ["a": 1]),
        Preset(identifier: "first", properties: ["b": 2], parentIdentifier: "parent"),
        Preset(identifier: "second", properties: ["c": 3], parentIdentifier: "parent"),
      ], resolve: "second"),
    ChainCase(
      name: "an absent parent adds nothing",
      presets: [Preset(identifier: "child", properties: ["a": 1], parentIdentifier: "gone")], resolve: "child"),
    ChainCase(name: "an absent preset has no properties", presets: [], resolve: "gone"),
    ChainCase(
      name: "of two presets with one identifier the later is adopted",
      presets: [Preset(identifier: "twice", properties: ["a": 1]), Preset(identifier: "twice", properties: ["a": 2])],
      resolve: "twice"),
    ChainCase(
      name: "the parents lead back to the preset",
      presets: [
        Preset(identifier: "a", properties: [:], parentIdentifier: "b"),
        Preset(identifier: "b", properties: [:], parentIdentifier: "c"),
        Preset(identifier: "c", properties: [:], parentIdentifier: "a"),
      ], resolve: "a"),
    ChainCase(
      name: "a preset is its own parent",
      presets: [Preset(identifier: "a", properties: ["x": 1], parentIdentifier: "a")], resolve: "a"),
  ]
}

struct EffectiveCase: Sendable, CustomTestStringConvertible {
  var name: String
  var presets: [Preset]
  var value: @Sendable (PresetResolver) throws -> JSONValue
  var testDescription: String { name }

  static let emphasis = Preset(
    identifier: "emphasis", properties: CharacterProperties(fontSize: 12, italic: true, underline: .value(.single)),
    displayName: "Emphasis")

  static let all: [EffectiveCase] = [
    EffectiveCase(name: "an object's own member wins, and the rest is inherited", presets: [emphasis]) { resolver in
      var properties = CharacterProperties(fontSize: 18)
      properties.presetIdentifier = "emphasis"
      return try resolver.effective(properties).wireValue
    },
    EffectiveCase(name: "a null on the object stops the search", presets: [emphasis]) { resolver in
      var properties = CharacterProperties(underline: .cleared)
      properties.presetIdentifier = "emphasis"
      return try resolver.effective(properties).wireValue
    },
    EffectiveCase(name: "a preset that is absent leaves the object as it is", presets: []) { resolver in
      var properties = CharacterProperties(bold: true)
      properties.presetIdentifier = "gone"
      return try resolver.effective(properties).wireValue
    },
    EffectiveCase(name: "the declared defaults fill what nothing sets", presets: []) { resolver in
      try resolver.effective(RGBAColor(red: 0.5)).wireValue
    },
    EffectiveCase(name: "the defaults are left out on request", presets: []) { resolver in
      try resolver.effective(RGBAColor(red: 0.5), applyingDefaults: false).wireValue
    },
    EffectiveCase(
      name: "a union takes its form from a preset",
      presets: [Preset(identifier: "ink", properties: ["color": ["rgba": ["red": 0.1, "green": 0.1, "blue": 0.12]]])]
    ) { resolver in
      var properties = CharacterProperties()
      properties.characterFill = .value(Fill(form: nil, envelope: ObjectEnvelope(presetIdentifier: "ink")))
      return try resolver.effective(properties).wireValue
    },
    EffectiveCase(
      name: "a preset's own value adopts another preset",
      presets: [
        Preset(identifier: "accent", properties: ["rgba": ["red": 0.93, "green": 0.35, "blue": 0.16]]),
        Preset(identifier: "ruled", properties: ["fill": ["preset_identifier": "accent"]]),
      ]
    ) { resolver in
      var properties = ParagraphProperties()
      properties.presetIdentifier = "ruled"
      return try resolver.effective(properties, applyingDefaults: false).wireValue
    },
    EffectiveCase(
      name: "a run takes from its paragraph what it and its preset leave out",
      presets: [
        emphasis,
        Preset(
          identifier: "body",
          properties: ["character_properties": ["font_name": "Fenwick", "font_size": 11, "bold": false]]),
      ]
    ) { resolver in
      var paragraph = Paragraph("placeholder")
      paragraph.style = ParagraphProperties()
      paragraph.style?.presetIdentifier = "body"
      var run = TextRun("stressed", style: CharacterProperties(bold: true))
      run.style?.presetIdentifier = "emphasis"
      return try resolver.characterProperties(of: run, in: paragraph).wireValue
    },
    EffectiveCase(name: "a run with no style takes its paragraph's", presets: []) { resolver in
      var paragraph = Paragraph("placeholder")
      paragraph.style = ParagraphProperties(characterProperties: CharacterProperties(italic: true))
      return try resolver.characterProperties(of: TextRun("plain"), in: paragraph).wireValue
    },
    EffectiveCase(
      name: "the paragraph properties of a paragraph",
      presets: [Preset(identifier: "body", properties: ["alignment": "justified", "space_after": 6])]
    ) { resolver in
      var paragraph = Paragraph("placeholder")
      paragraph.style = ParagraphProperties(spaceAfter: 12)
      paragraph.style?.presetIdentifier = "body"
      return try resolver.paragraphProperties(of: paragraph).wireValue
    },
  ]
}

@Suite struct PresetResolverTests {
  let goldens: GoldenFile

  init() throws {
    goldens = try GoldenFile(named: "preset-styles", in: .module)
  }

  @Test(arguments: ChainCase.all)
  func resolvesAChain(_ item: ChainCase) throws {
    let resolver = PresetResolver(PresetLibrary(item.presets))
    var resolved: JSONObject?
    var got = ""
    do throws(PresetError) {
      resolved = try resolver.resolvedProperties(of: item.resolve)
    } catch {
      got = "\(error)"
    }
    if let resolved { got = String(decoding: try JSONValue.object(resolved).text(), as: UTF8.self) }
    #expect(got == (try goldens.want("chain: \(item.name)", got: got)))
  }

  @Test(arguments: EffectiveCase.all)
  func findsTheEffectiveProperties(_ item: EffectiveCase) throws {
    let resolver = PresetResolver(PresetLibrary(item.presets), stylesheet: nil)
    let got = String(decoding: try item.value(resolver).text(.readable), as: UTF8.self)
    #expect(got == (try goldens.want("effective: \(item.name)", got: got)))
  }

  @Test func aValueOfTheWrongKindFromAPresetIsRefused() {
    let resolver = PresetResolver([Preset(identifier: "bad", properties: ["red": "crimson"])])
    var colour = RGBAColor()
    colour.presetIdentifier = "bad"
    #expect(
      throws: PresetError.inheritedValueInvalid(
        preset: "bad", underlying: .unexpectedKind(expected: .number, found: .string, at: JSONPath([.member("red")])))
    ) { _ = try resolver.effective(colour) }
  }

  @Test func aStylesheetIsSearchedBeforeTheLibrary() throws {
    var named = NamedCharacterStyle(properties: CharacterProperties(italic: true), name: "Stress")
    named.presetIdentifier = "stress"
    let stylesheet = Stylesheet(characterStyles: [named])
    let library: PresetLibrary = [Preset(identifier: "stress", properties: ["italic": false, "bold": true])]
    var properties = CharacterProperties()
    properties.presetIdentifier = "stress"
    let withSheet = try PresetResolver(library, stylesheet: stylesheet).effective(properties)
    #expect(withSheet.italic == true)
    #expect(withSheet.bold == true)
    let without = try PresetResolver(library, stylesheet: nil).effective(properties)
    #expect(without.italic == false)
  }

  @Test func aPresetThatAdoptsItselfThroughAValueStopsThere() throws {
    let resolver = PresetResolver([
      Preset(identifier: "loop", properties: ["fill": ["preset_identifier": "loop", "x": 1]])
    ])
    let got = try resolver.resolved(["preset_identifier": "loop"])
    #expect(got == ["fill": ["x": 1]])
  }
}
