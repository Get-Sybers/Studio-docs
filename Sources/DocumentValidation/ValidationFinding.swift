public import JSONTree

/// One thing that validation found: what, how grave, and where.
public struct ValidationFinding: Sendable, Hashable, CustomStringConvertible {
  /// How grave a finding is.
  public enum Severity: String, Sendable, Hashable, Comparable {
    /// A reader handles the content in a way that the format defines and the author may not intend.
    case warning
    /// The content breaks a rule of the format; the library does not save it.
    case error

    /// Orders a warning before an error.
    public static func < (left: Severity, right: Severity) -> Bool {
      left == .warning && right == .error
    }
  }

  /// The part of the package that a finding lies in.
  public enum Part: String, Sendable, Hashable {
    /// `main.json`.
    case main = "main.json"
    /// `presets.json`.
    case presets = "presets.json"
    /// `manifest.json`.
    case manifest = "manifest.json"
    /// The `Data` directory.
    case resources = "Data"
  }

  /// What was found.
  public var kind: FindingKind
  /// How grave it is.
  public var severity: Severity
  /// The part of the package it lies in.
  public var part: Part
  /// The place in that part.
  public var path: JSONPath

  /// Creates a finding; the severity is that of the kind unless another is given.
  public init(_ kind: FindingKind, in part: Part, at path: JSONPath = .root, severity: Severity? = nil) {
    self.kind = kind
    self.severity = severity ?? kind.severity
    self.part = part
    self.path = path
  }

  /// The finding on one line: severity, part, place and kind.
  public var description: String {
    "\(severity.rawValue) \(part.rawValue) \(path): \(kind)"
  }
}
