/// Everything that validation found in a document.
public struct ValidationReport: Sendable, Hashable {
  /// The findings, in the order the checks made them.
  public var findings: [ValidationFinding]

  /// Creates a report.
  public init(_ findings: [ValidationFinding] = []) {
    self.findings = findings
  }

  /// The findings that break a rule of the format.
  public var errors: [ValidationFinding] {
    findings.filter { $0.severity == .error }
  }

  /// The findings that a reader handles otherwise than written.
  public var warnings: [ValidationFinding] {
    findings.filter { $0.severity == .warning }
  }

  /// Whether the document has no error, so that the library saves it.
  public var isSaveable: Bool {
    !findings.contains { $0.severity == .error }
  }
}
