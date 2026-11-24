import JSONTree
import WireFormat

/// An enumeration of the tests' own: two known values, and room for more.
struct Finish: WireEnumeration {
  let rawValue: String

  static let matte = Finish(rawValue: "matte")
  static let satin = Finish(rawValue: "satin")
  static let modelled: [Finish] = [.matte, .satin]
}

/// An object type of the tests' own, at version 2.0, with a member of each kind and three later ones.
struct Swatch: WireObject {
  static let schema = ObjectSchema(
    typeIdentifier: "org.example.swatch", version: FormatVersion(2, 0),
    members: [
      .init("name", kind: .required),
      .init("weight"),
      .init("tint", kind: .inheritable),
      .init("gloss", since: FormatVersion(1, 1)),
      .init("finish", kind: .inheritable, since: FormatVersion(1, 2)),
      .init("seal", since: FormatVersion(2, 0)),
      .init("layers"),
    ])

  var name: String
  var weight: Int?
  var tint: Inheritable<Double> = .inherited
  var gloss: Bool?
  var finish: Inheritable<Finish> = .inherited
  var seal: String?
  var layers: [Swatch]?
  var envelope = ObjectEnvelope()

  init(name: String) {
    self.name = name
  }

  init(reading reader: inout ObjectReader) throws(WireError) {
    name = try reader.required("name")
    weight = try reader.optional("weight")
    tint = try reader.inheritable("tint")
    gloss = try reader.optional("gloss")
    finish = try reader.inheritable("finish")
    seal = try reader.optional("seal")
    layers = try reader.optional("layers")
  }

  func write(to writer: inout ObjectWriter) {
    writer.required("name", name)
    writer.optional("weight", weight)
    writer.inheritable("tint", tint)
    writer.optional("gloss", gloss)
    writer.inheritable("finish", finish)
    writer.optional("seal", seal)
    writer.optional("layers", layers)
  }
}

/// A union of the tests' own, at version 1.1: two cases with contents, one without, and a later one.
struct Coating: WireUnion {
  enum Form: Sendable, Hashable {
    case swatch(Swatch)
    case label(String)
    case bare
    case glaze(Double)
  }

  static let schema = UnionSchema(
    typeIdentifier: "org.example.coating", version: FormatVersion(1, 1),
    cases: [
      .init("swatch"), .init("label"), .init("bare", isValueless: true), .init("glaze", since: FormatVersion(1, 1)),
    ])

  var form: Form?
  var envelope: ObjectEnvelope

  static func readForm(named name: String, from contents: JSONValue) throws(WireError) -> Form? {
    switch name {
    case "swatch": .swatch(try Swatch(wire: contents))
    case "label": .label(try String(wire: contents))
    case "bare": .bare
    case "glaze": .glaze(try Double(wire: contents))
    default: nil
    }
  }

  static func member(for form: Form) -> (name: String, contents: JSONValue?) {
    switch form {
    case .swatch(let swatch): ("swatch", swatch.wireValue)
    case .label(let text): ("label", text.wireValue)
    case .bare: ("bare", nil)
    case .glaze(let amount): ("glaze", amount.wireValue)
    }
  }
}
