extension JSONValue: Codable {
  /// Reads any JSON value; the members of an object are put in the order of their names.
  public init(from decoder: any Decoder) throws {
    // The order of the attempts follows how often each kind occurs, since a failed attempt costs a thrown error.
    let single = try decoder.singleValueContainer()
    if single.decodeNil() {
      self = .null
    } else if let text = try Self.attempt({ try single.decode(String.self) }) {
      self = .string(text)
    } else if let keyed = try Self.attempt({ try decoder.container(keyedBy: JSONCodingKey.self) }) {
      var object = JSONObject()
      for key in keyed.allKeys.sorted(by: { $0.stringValue < $1.stringValue }) {
        object[key.stringValue] = try keyed.decode(JSONValue.self, forKey: key)
      }
      self = .object(object)
    } else if var list = try Self.attempt({ try decoder.unkeyedContainer() }) {
      var elements: [JSONValue] = []
      elements.reserveCapacity(list.count ?? 0)
      while !list.isAtEnd {
        elements.append(try list.decode(JSONValue.self))
      }
      self = .array(elements)
    } else if let flag = try Self.attempt({ try single.decode(Bool.self) }) {
      self = .bool(flag)
    } else if let whole = try? single.decode(Int64.self) {
      self = .number(JSONNumber(whole))
    } else if let whole = try? single.decode(UInt64.self) {
      self = .number(JSONNumber(whole))
    } else {
      self = .number(JSONNumber(try single.decode(Double.self)))
    }
  }

  /// Writes the value; an encoder that sorts keys gives the same text for equal trees.
  public func encode(to encoder: any Encoder) throws {
    switch self {
    case .null:
      var single = encoder.singleValueContainer()
      try single.encodeNil()
    case .bool(let flag):
      var single = encoder.singleValueContainer()
      try single.encode(flag)
    case .number(let number):
      var single = encoder.singleValueContainer()
      if let whole = number.int64Value {
        try single.encode(whole)
      } else if let whole = number.uint64Value {
        try single.encode(whole)
      } else {
        try single.encode(number.doubleValue)
      }
    case .string(let text):
      var single = encoder.singleValueContainer()
      try single.encode(text)
    case .array(let elements):
      var list = encoder.unkeyedContainer()
      for element in elements {
        try list.encode(element)
      }
    case .object(let object):
      var keyed = encoder.container(keyedBy: JSONCodingKey.self)
      for (name, value) in object {
        try keyed.encode(value, forKey: JSONCodingKey(name))
      }
    }
  }

  // A value of another kind is no failure here; text that is not JSON at all is.
  private static func attempt<T>(_ body: () throws -> T) throws -> T? {
    do {
      return try body()
    } catch DecodingError.typeMismatch {
      return nil
    }
  }
}
