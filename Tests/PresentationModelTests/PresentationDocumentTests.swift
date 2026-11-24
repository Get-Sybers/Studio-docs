import Appearance
import CanvasCommon
import CanvasModel
import DocumentPackage
import DocumentValidation
import Foundation
import GoldenFiles
import JSONTree
import PresentationModel
import Testing
import TextModel
import WireFormat
import ZipArchives

@Suite struct PresentationDocumentTests {
  // The shape of a presentation, from Apple's documentation; the words are invented.
  static let main = #"""
    {"type_identifier": "com.apple.apps.content-language.presentation",
     "theme": {"type_identifier": "com.apple.apps.content-language.keynote-theme", "name": "White"},
     "slide_size": {"type_identifier": "com.apple.apps.content-language.size", "width": 1920, "height": 1080},
     "slides": [{"type_identifier": "com.apple.apps.content-language.slide", "identifier": "slide-1",
       "note": {"type_identifier": "com.apple.apps.content-language.text", "string": "Say where the boats went."},
       "contents": [{"type_identifier": "com.apple.apps.content-language.slide-object", "source_kind": "user",
         "object": {"type_identifier": "com.apple.apps.content-language.canvas-object",
           "textbox": {"type_identifier": "com.apple.apps.content-language.textbox", "preset_identifier": "theme-title",
             "geometry": {"type_identifier": "com.apple.apps.content-language.geometry",
               "position": {"type_identifier": "com.apple.apps.content-language.position", "x": 160, "y": 120},
               "size": {"type_identifier": "com.apple.apps.content-language.size", "width": 1600, "height": 160}},
             "stroke": "empty",
             "text": {"type_identifier": "com.apple.apps.content-language.text", "string": "Harbour notes"},
             "a_member_of_a_later_version": {"kept": true}}}}]}]}
    """#

  let goldens: GoldenFile

  init() throws {
    goldens = try GoldenFile(named: "presentation-model", in: .module)
  }

  @Test func aPresentationOpensTypedAndWritesBackWhatItRead() throws {
    var writer = ZipWriter()
    try writer.add(Data(Self.main.utf8), named: "main.json")
    let document = try StudioDocument<Presentation>(archive: writer.finish())
    let slide = try #require(document.body.slides.first)
    #expect(slide.identifier == "slide-1")
    #expect(slide.note?.plainText == "Say where the boats went.")
    let object = try #require(slide.contents?.first)
    #expect(object.sourceKind == .user)
    guard case .textbox(let textbox) = object.object.form else {
      Issue.record("the object is not a text box")
      return
    }
    #expect(textbox.presetIdentifier == "theme-title")
    #expect(textbox.geometry?.position == PositionValue(x: 160, y: 120))
    #expect(textbox.text?.plainText == "Harbour notes")
    #expect(textbox.envelope.unmodelled["a_member_of_a_later_version"] == ["kept": true])
    #expect(document.validate().errors == [])

    let written = try StudioDocument<UntypedBody>(archive: try document.archive())
    #expect(written.body.tree == (try JSONValue(parsing: Data(Self.main.utf8))))
    let got = String(decoding: try document.body.mainTree.text(.readable), as: UTF8.self)
    #expect(got == (try goldens.want("a presentation, typed", got: got)))
  }

  @Test func aPresentationIsBuiltFromItsParts() throws {
    var textbox = Textbox()
    textbox.text = .string("Harbour notes")
    var slide = Slide()
    slide.contents = [SlideObject(object: .textbox(textbox))]
    let presentation = Presentation(slides: [slide])
    let document = StudioDocument(body: presentation)
    #expect(document.validate().errors == [])
    let reopened = try StudioDocument<Presentation>(archive: try document.archive())
    #expect(reopened.body == presentation)
  }
}
