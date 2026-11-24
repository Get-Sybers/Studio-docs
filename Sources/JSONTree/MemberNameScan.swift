import Foundation

/// Finds a member name that an object of some JSON text holds twice, which Foundation's decoder drops in silence.
///
/// The scan follows the structure of the text only as far as names need; text that is not JSON ends it with no finding.
enum MemberNameScan {
  /// A name that one object holds twice, and the place of that object.
  struct Finding: Equatable {
    var name: String
    var path: JSONPath
  }

  private enum Frame {
    case object(seen: Set<String>, key: String?)
    case array(index: Int)
  }

  /// The first name that an object repeats, in the order of the text, or nil when every object's names differ.
  static func firstRepeatedName(in text: Data) -> Finding? {
    let bytes = text.startIndex == 0 ? text : Data(text)
    var frames: [Frame] = []
    var position = 0
    while position < bytes.count {
      let byte = bytes[position]
      switch byte {
      case 0x20, 0x09, 0x0A, 0x0D:
        position += 1
      case UInt8(ascii: "{"):
        frames.append(.object(seen: [], key: nil))
        position += 1
      case UInt8(ascii: "["):
        frames.append(.array(index: 0))
        position += 1
      case UInt8(ascii: "}"), UInt8(ascii: "]"):
        guard !frames.isEmpty else { return nil }
        frames.removeLast()
        position += 1
      case UInt8(ascii: ","):
        switch frames.last {
        case .object(let seen, _): frames[frames.count - 1] = .object(seen: seen, key: nil)
        case .array(let index): frames[frames.count - 1] = .array(index: index + 1)
        case nil: return nil
        }
        position += 1
      case UInt8(ascii: ":"):
        position += 1
      case UInt8(ascii: "\""):
        guard let (name, next) = string(in: bytes, from: position + 1) else { return nil }
        position = next
        if case .object(var seen, nil) = frames.last {
          guard seen.insert(name).inserted else {
            return Finding(name: name, path: JSONPath(frames.dropLast().compactMap(component)))
          }
          frames[frames.count - 1] = .object(seen: seen, key: name)
        }
      default:
        // A number or a literal runs to the next structural character.
        while position < bytes.count, !Self.ends(bytes[position]) {
          position += 1
        }
      }
    }
    return nil
  }

  private static func component(_ frame: Frame) -> JSONPath.Component? {
    switch frame {
    case .object(_, let key): key.map { .member($0) }
    case .array(let index): .index(index)
    }
  }

  private static func ends(_ byte: UInt8) -> Bool {
    switch byte {
    case 0x20, 0x09, 0x0A, 0x0D, UInt8(ascii: ","), UInt8(ascii: "]"), UInt8(ascii: "}"), UInt8(ascii: ":"): true
    default: false
    }
  }

  /// Decodes a string whose opening quote stands before `start`; nil when the text is cut short or mis-escaped.
  private static func string(in bytes: Data, from start: Int) -> (String, Int)? {
    var scalars = String.UnicodeScalarView()
    var raw: [UInt8] = []
    var position = start
    func flush() {
      if !raw.isEmpty {
        scalars.append(contentsOf: String(decoding: raw, as: UTF8.self).unicodeScalars)
        raw.removeAll()
      }
    }
    while position < bytes.count {
      let byte = bytes[position]
      if byte == UInt8(ascii: "\"") {
        flush()
        return (String(scalars), position + 1)
      }
      guard byte == UInt8(ascii: "\\") else {
        raw.append(byte)
        position += 1
        continue
      }
      flush()
      guard position + 1 < bytes.count else { return nil }
      let escaped = bytes[position + 1]
      position += 2
      switch escaped {
      case UInt8(ascii: "\""): scalars.append("\"")
      case UInt8(ascii: "\\"): scalars.append("\\")
      case UInt8(ascii: "/"): scalars.append("/")
      case UInt8(ascii: "b"): scalars.append("\u{08}")
      case UInt8(ascii: "f"): scalars.append("\u{0C}")
      case UInt8(ascii: "n"): scalars.append("\n")
      case UInt8(ascii: "r"): scalars.append("\r")
      case UInt8(ascii: "t"): scalars.append("\t")
      case UInt8(ascii: "u"):
        guard var code = hex(in: bytes, at: position) else { return nil }
        position += 4
        if (0xD800...0xDBFF).contains(code) {
          guard position + 1 < bytes.count, bytes[position] == UInt8(ascii: "\\"),
            bytes[position + 1] == UInt8(ascii: "u"),
            let low = hex(in: bytes, at: position + 2), (0xDC00...0xDFFF).contains(low)
          else { return nil }
          position += 6
          code = 0x10000 + ((code - 0xD800) << 10) + (low - 0xDC00)
        }
        guard let scalar = Unicode.Scalar(code) else { return nil }
        scalars.append(scalar)
      default:
        return nil
      }
    }
    return nil
  }

  private static func hex(in bytes: Data, at position: Int) -> UInt32? {
    guard position + 4 <= bytes.count else { return nil }
    return UInt32(String(decoding: bytes[position..<position + 4], as: UTF8.self), radix: 16)
  }
}
