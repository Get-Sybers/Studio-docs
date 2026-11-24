/// The way from the root of a tree to one of its values.
public struct JSONPath: Sendable, Hashable, CustomStringConvertible {
  /// One step of a path.
  public enum Component: Sendable, Hashable {
    /// Into the member of this name.
    case member(String)
    /// Into the element at this index.
    case index(Int)
  }

  /// The steps, the outermost first.
  public var components: [Component]

  /// Creates a path from its steps.
  public init(_ components: [Component] = []) {
    self.components = components
  }

  /// The path of the root itself.
  public static let root = JSONPath()

  /// Returns the path one member deeper.
  public func member(_ name: String) -> JSONPath {
    JSONPath(components + [.member(name)])
  }

  /// Returns the path one element deeper.
  public func index(_ index: Int) -> JSONPath {
    JSONPath(components + [.index(index)])
  }

  /// The path as text, such as `sections[2].paragraphs[0]`; the root is `<root>`.
  public var description: String {
    guard !components.isEmpty else { return "<root>" }
    var text = ""
    for component in components {
      switch component {
      case .member(let name):
        let isPlain =
          !name.isEmpty
          && name.unicodeScalars.allSatisfy {
            $0 == "_" || $0 == "-" || $0.properties.isAlphabetic || ("0"..."9").contains($0)
          }
        text += isPlain ? (text.isEmpty ? name : ".\(name)") : "[\"\(name)\"]"
      case .index(let index):
        text += "[\(index)]"
      }
    }
    return text
  }
}
