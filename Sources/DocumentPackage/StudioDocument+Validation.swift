public import DocumentValidation
import JSONTree

extension StudioDocument {
  /// Checks the document against the rules of the format, and against the rules of its body.
  public func validate() -> ValidationReport {
    validation(of: body.mainTree)
  }

  func validation(of tree: JSONValue) -> ValidationReport {
    var report = DocumentValidator.validate(
      ValidationInput(
        main: tree, presets: presets, resourceNames: resources.names, isSelfContained: Body.isSelfContained,
        schemas: Body.schemas))
    if !manifest.isSupported {
      report.findings.insert(
        ValidationFinding(.unsupportedPackageVersion(manifest.effectiveVersion), in: .manifest), at: 0)
    }
    report.findings += body.findings()
    return report
  }
}
