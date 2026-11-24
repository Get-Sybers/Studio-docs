package import JSONTree
package import WireFormat

/// The checks that every target that models types of the format runs against its fixtures and its table.
package enum ModelCheck {
  /// Reads the sample of a type and writes it back; a union's sample is an array with one element for each case.
  ///
  /// The defects name whatever was lost, left unread or missing from the sample.
  package static func roundTrip(_ type: ModelledType, sample: JSONValue) -> (written: JSONValue, defects: [String]) {
    var defects: [String] = []
    var written: [JSONValue] = []
    let samples = type.isUnion ? sample.arrayValue ?? [] : [sample]
    var seen: Set<String> = []
    for one in samples {
      do throws(WireError) {
        let reading = try type.read(one)
        written.append(reading.written)
        if reading.written.withoutTypeIdentifiers != one {
          defects.append("\(type.name) does not write back what it read")
        }
        if !reading.unmodelled.isEmpty { defects.append("\(type.name) leaves \(reading.unmodelled) unread") }
        if !reading.hasForm { defects.append("\(type.name) reads no form from \(one)") }
        if try type.read(reading.written).written != reading.written {
          defects.append("\(type.name) writes its own output differently")
        }
      } catch {
        defects.append("\(type.name): \(error)")
      }
      seen.formUnion(one.objectValue?.keys ?? one.stringValue.map { [$0] } ?? [])
    }
    // A sample may declare a version or adopt a preset; neither is a member of the type.
    seen.subtract(["version", "preset_identifier"])
    if seen != Set(type.parts) {
      defects.append("the sample of \(type.name) holds \(seen.sorted()); the table lists \(type.parts.sorted())")
    }
    return (type.isUnion ? .array(written) : written.first ?? .null, defects)
  }

  /// Tells where the types of a target, its fixtures and its format table name different things.
  package static func agreement(types: [ModelledType], fixtures: FixtureFile, table: FormatTable) -> [String] {
    var defects: [String] = []
    let modelled = Set(types.map(\.name))
    let listed = Set(table.objects.keys).union(table.unions.keys)
    if modelled != listed {
      defects.append("the table and the types differ in \(modelled.symmetricDifference(listed).sorted())")
    }
    let sampled = Set(fixtures.samples.keys)
    if modelled != sampled {
      defects.append("the fixtures and the types differ in \(modelled.symmetricDifference(sampled).sorted())")
    }
    for type in types {
      let schema = type.isUnion ? table.unions[type.name]?.typeIdentifier : table.objects[type.name]?.typeIdentifier
      if schema != type.typeIdentifier { defects.append("\(type.name) is listed as the other kind of type") }
    }
    return defects
  }

  /// Tells where the named values of an enumeration and its list in the format table differ.
  package static func agreement<Enumeration: WireEnumeration>(
    _ named: [Enumeration], table: FormatTable
  ) -> [String] {
    let name = "\(Enumeration.self)"
    let listed = table.enumerations[name] ?? []
    var defects: [String] = []
    if Set(named.map(\.rawValue)) != Set(listed) || named.count != listed.count {
      defects.append("\(name) names \(named.map(\.rawValue).sorted()); the table lists \(listed.sorted())")
    }
    if Enumeration.modelled.map(\.rawValue) != listed { defects.append("\(name).modelled is not the table's list") }
    return defects
  }
}
