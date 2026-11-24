public import Foundation

extension AttributeDynamicLookup {
  /// Gives the library's attributes the dotted spelling that Foundation's own have.
  public subscript<Key: AttributedStringKey>(
    dynamicMember keyPath: KeyPath<AttributeScopes.StudioTextAttributes, Key>
  ) -> Key {
    self[Key.self]
  }
}
