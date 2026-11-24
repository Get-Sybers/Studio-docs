package import WireFormat

/// The format table of the target: the schema of every type of the format that it models.
package enum PresentationModelFormat {
  /// The table, decoded once from the `format.json` that the target embeds.
  package static let table = FormatTable(embedded: PackageResources.format_json, target: "PresentationModel")
}
