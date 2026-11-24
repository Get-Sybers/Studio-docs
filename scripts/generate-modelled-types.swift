import Foundation

// Writes docs/Modelled-types.md from the format tables, so the list of what is modelled cannot drift from them.

struct Table: Decodable {
  struct Member: Decodable {
    var name: String
    var since: String?
  }

  struct Entry: Decodable {
    var type: String
    var name: String
    var version: String
    var members: [Member]?
    var cases: [Member]?
  }

  var objects: [Entry]
  var unions: [Entry]
}

func row(_ entry: Table.Entry, in target: String, kind: String) -> String {
  let parts = (entry.members ?? entry.cases ?? []).map { part in
    part.since.map { "`\(part.name)` (\($0))" } ?? "`\(part.name)`"
  }
  return
    "| `\(entry.type)` | `\(entry.name)` | \(target) | \(kind) | \(entry.version) | \(parts.joined(separator: ", ")) |"
}

let arguments = CommandLine.arguments
guard arguments.count == 3 else {
  FileHandle.standardError.write(Data("usage: generate-modelled-types.swift <Sources> <output.md>\n".utf8))
  exit(2)
}
let sources = URL(fileURLWithPath: arguments[1])
var rows: [String] = []
do {
  let targets = try FileManager.default.contentsOfDirectory(atPath: sources.path).sorted()
  for target in targets {
    let file = sources.appendingPathComponent(target).appendingPathComponent("Resources/format.json")
    guard FileManager.default.fileExists(atPath: file.path) else { continue }
    let table = try JSONDecoder().decode(Table.self, from: Data(contentsOf: file))
    rows += table.objects.map { row($0, in: target, kind: "object") }
    rows += table.unions.map { row($0, in: target, kind: "union") }
  }
  let lines =
    [
      "# Modelled types",
      "",
      "`make generate` writes this file from the format tables, `Sources/<Target>/Resources/format.json`.",
      "It lists every type of the format that the library models, with the version of the type that",
      "the library writes and the members or cases it reads. A member or a case that a later version",
      "than 1.0 introduced shows that version in brackets.",
      "",
      "| Type identifier | Swift type | Target | Kind | Version | Members or cases |",
      "| --- | --- | --- | --- | --- | --- |",
    ] + rows.sorted() + [""]
  try Data(lines.joined(separator: "\n").utf8).write(to: URL(fileURLWithPath: arguments[2]))
} catch {
  FileHandle.standardError.write(Data("generate-modelled-types: \(error)\n".utf8))
  exit(1)
}
