import JSONTree

extension WireUnion {
  /// Reads a client's member; nil when the value has none or holds `null` there.
  public func value<Value>(of property: ClientProperty<Value>) throws(WireError) -> Value? {
    guard let value = envelope.unmodelled[property.name], !value.isNull else { return nil }
    return try Value.read(value, under: .member(property.name))
  }

  /// Writes a client's member; nil removes it.
  public mutating func setValue<Value>(_ value: Value?, of property: ClientProperty<Value>) {
    envelope.unmodelled[property.name] = value?.wireValue
  }
}
