package import WireFormat

/// The format table of the target: the schema of the two types that make up the library's own text document.
package enum TextDocumentFormat {
  /// The table, decoded once from the `format.json` that the target embeds.
  package static let table = FormatTable(embedded: PackageResources.format_json, target: "TextDocument")
}
