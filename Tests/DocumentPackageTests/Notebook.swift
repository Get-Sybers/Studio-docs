import DocumentPackage
import DocumentValidation
import JSONTree
import ResourceReferences
import TextModel
import WireFormat

/// A body of the tests' own, as a client writes one: a root type and an entry type around the library's text.
struct Notebook: WireObject, DocumentBody {
  static let schema = ObjectSchema(typeIdentifier: "org.example.notebook", members: [.init("entries", kind: .required)])

  var entries: [NotebookEntry]
  var envelope = ObjectEnvelope()

  init(entries: [NotebookEntry]) {
    self.entries = entries
  }

  init(reading reader: inout ObjectReader) throws(WireError) {
    entries = try reader.required("entries")
  }

  func write(to writer: inout ObjectWriter) {
    writer.required("entries", entries)
  }

  // A rule of the body's own: an entry needs a title.
  func findings() -> [ValidationFinding] {
    entries.enumerated().compactMap { index, entry in
      entry.title.isEmpty
        ? ValidationFinding(
          .custom(name: "untitled-entry", detail: "an entry has no title"), in: .main,
          at: JSONPath([.member("entries"), .index(index), .member("title")]))
        : nil
    }
  }
}

struct NotebookEntry: WireObject {
  static let schema = ObjectSchema(
    typeIdentifier: "org.example.notebook.entry",
    members: [.init("title", kind: .required), .init("text", kind: .required), .init("picture")])

  var title: String
  var text: TextBody
  var picture: ResourceReference?
  var envelope = ObjectEnvelope()

  init(title: String, text: TextBody, picture: ResourceReference? = nil) {
    self.title = title
    self.text = text
    self.picture = picture
  }

  init(reading reader: inout ObjectReader) throws(WireError) {
    title = try reader.required("title")
    text = try reader.required("text")
    picture = try reader.optional("picture")
  }

  func write(to writer: inout ObjectWriter) {
    writer.required("title", title)
    writer.required("text", text)
    writer.optional("picture", picture)
  }
}
