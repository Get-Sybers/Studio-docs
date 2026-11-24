import Foundation
public import JSONTree
public import WireFormat

/// The manifest of a package, `manifest.json`: the version of the package format that the document uses.
public struct Manifest: Sendable, Hashable {
  /// The declared version; nil when the manifest is absent or its version does not parse, which reads as 1.0.
  public var packageVersion: FormatVersion?
  /// The members of the manifest beside the version, kept as read.
  public var unmodelled: JSONObject

  /// The version of the package format that the library writes for a new document.
  public static let currentVersion = FormatVersion(1, 0)

  /// Creates a manifest; with no argument it declares the current version.
  public init(packageVersion: FormatVersion? = Manifest.currentVersion) {
    self.packageVersion = packageVersion
    self.unmodelled = JSONObject()
  }

  /// The version by which the document is read: the declared one, or 1.0.
  public var effectiveVersion: FormatVersion {
    packageVersion ?? Manifest.currentVersion
  }

  /// Whether the library reads and writes a package of this version: one of the same major version or an earlier.
  public var isSupported: Bool {
    effectiveVersion.major <= Manifest.currentVersion.major
  }

  // A manifest that is absent, is not JSON or holds no version is no fault: the document is read at 1.0.
  init(reading bytes: Data?) {
    self.init(packageVersion: nil)
    guard let bytes, let object = try? JSONValue(parsing: bytes).objectValue else { return }
    for (name, value) in object where name != "package_version" {
      unmodelled[name] = value
    }
    switch object["package_version"] {
    case .string(let text):
      packageVersion = FormatVersion(text)
    case .number(let number):
      // A reader also takes the version as a number, such as 1.0, or as an object of two integers.
      packageVersion =
        number.isFinite ? FormatVersion(number.intValue.map { "\($0).0" } ?? "\(number.doubleValue)") : nil
    case .object(let parts):
      if let major = parts["major"]?.numberValue?.intValue, major >= 0 {
        let minor = parts["minor"].map { $0.numberValue?.intValue ?? -1 } ?? 0
        packageVersion = minor >= 0 ? FormatVersion(major, minor) : nil
      }
    case .null, .bool, .array, nil:
      break
    }
  }

  var tree: JSONValue {
    var object = unmodelled
    object["package_version"] = .string(effectiveVersion.description)
    return .object(object)
  }
}
