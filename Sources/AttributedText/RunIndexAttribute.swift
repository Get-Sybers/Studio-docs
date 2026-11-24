public import Foundation

/// The attribute that keeps adjacent runs of one style apart: the place of each element among its paragraph's contents.
///
/// Two pieces of one place are one run that another attribute cut; pieces of two places stay two runs.
public enum RunIndexAttribute: CodableAttributedStringKey {
  /// The index of the element in `contents`.
  public typealias Value = Int

  /// The name of the attribute.
  public static let name = "io.github.get-sybers.studio-docs.run-index"
}
