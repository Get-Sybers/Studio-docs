/// How a tree is written as text; both styles order the members of every object by name.
public enum JSONStyle: Sendable, Hashable {
  /// On one line, with no space between tokens.
  case compact
  /// Indented, one member a line.
  case readable
}
