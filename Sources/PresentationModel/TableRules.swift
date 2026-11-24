import DocumentValidation
import JSONTree
import TableModel
import WireFormat

/// The rules of a table beyond its schema: names that are one, indices that rise, and what cells and merges name.
enum TableRules {
  static func check(_ table: Table, at path: JSONPath, into findings: inout [ValidationFinding]) {
    let columns = names(
      of: table.columnHeaders ?? [], "column_identifier", { $0.columnIdentifier }, at: path.member("column_headers"),
      into: &findings)
    let rows = names(
      of: table.content ?? [], "row_identifier", { $0.rowIdentifier }, at: path.member("content"), into: &findings)
    let formats = names(
      of: table.customFormats ?? [], "identifier", { $0.identifier?.rawValue }, at: path.member("custom_formats"),
      into: &findings)
    let styleSets = names(
      of: table.conditionalStyleSets ?? [], "identifier", { $0.identifier?.rawValue },
      at: path.member("conditional_style_sets"), into: &findings)

    var previousRow = -1
    for (rowIndex, row) in (table.content ?? []).enumerated() {
      let rowPath = path.member("content").index(rowIndex)
      previousRow = check(
        index: row.rowIndex, after: previousRow, count: table.numberOfRows, "row_index", at: rowPath, into: &findings)
      var previousColumn = -1
      for (cellIndex, cell) in (row.cells ?? []).enumerated() {
        let cellPath = rowPath.member("cells").index(cellIndex)
        previousColumn = check(
          index: cell.columnIndex, after: previousColumn, count: table.numberOfColumns, "column_index", at: cellPath,
          into: &findings)
        if let set = cell.conditionalStyleSetIdentifier, !styleSets.contains(set) {
          findings.append(
            ValidationFinding(
              .unknownTableReference(member: "conditional_style_set_identifier", value: set), in: .main,
              at: cellPath.member("conditional_style_set_identifier")))
        }
        if let format = cell.cellFormat?.value, format.formatType == .custom, let name = format.customFormatIdentifier,
          !formats.contains(name)
        {
          findings.append(
            ValidationFinding(
              .unknownTableReference(member: "custom_format_identifier", value: name), in: .main,
              at: cellPath.member("cell_format").member("custom_format_identifier")))
        }
      }
    }
    for (index, merge) in (table.merges ?? []).enumerated() {
      guard case .rowColumnIdRange(let range) = merge.form else { continue }
      let place = path.member("merges").index(index).member("row_column_id_range")
      let corners = [
        ("top_left_row_identifier", range.topLeftRowIdentifier, rows),
        ("bottom_right_row_identifier", range.bottomRightRowIdentifier, rows),
        ("top_left_column_identifier", range.topLeftColumnIdentifier, columns),
        ("bottom_right_column_identifier", range.bottomRightColumnIdentifier, columns),
      ]
      for (member, value, known) in corners where !known.contains(value) {
        findings.append(
          ValidationFinding(.unknownTableReference(member: member, value: value), in: .main, at: place.member(member)))
      }
    }
  }

  /// The names of a list, each once; a repeated name is a finding at its later place.
  private static func names<Item>(
    of items: [Item], _ member: String, _ name: (Item) -> String?, at path: JSONPath,
    into findings: inout [ValidationFinding]
  ) -> Set<String> {
    var seen: Set<String> = []
    for (index, item) in items.enumerated() {
      guard let value = name(item) else { continue }
      if !seen.insert(value).inserted {
        findings.append(
          ValidationFinding(
            .repeatedTableName(member: member, value: value), in: .main, at: path.index(index).member(member)))
      }
    }
    return seen
  }

  /// Resolves an index, which omitted is the one after the previous, and checks that it lies in the table and rises.
  private static func check(
    index: Int?, after previous: Int, count: Int, _ member: String, at path: JSONPath,
    into findings: inout [ValidationFinding]
  ) -> Int {
    let resolved = index ?? previous + 1
    if !(0..<count).contains(resolved) {
      findings.append(
        ValidationFinding(
          .tableIndexOutOfRange(member: member, index: resolved, count: count), in: .main, at: path.member(member)))
    } else if resolved <= previous {
      findings.append(
        ValidationFinding(.tableIndexNotRising(member: member, index: resolved), in: .main, at: path.member(member)))
    }
    return resolved
  }
}
