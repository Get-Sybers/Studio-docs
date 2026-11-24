#!/bin/sh
# Structural lint: the rules that neither the compiler nor the formatter checks.
set -u
fail=0

report() {
  echo "structure-lint: $*" >&2
  fail=1
}

for file in LICENSE NOTICE README.md CHANGELOG.md AGENTS.md .gitignore .swift-format .xcode-version \
  Makefile Package.swift Package.resolved; do
  [ -f "$file" ] || report "$file is missing"
done

grep -q 'Apache License' LICENSE && grep -q 'Version 2.0' LICENSE || report "LICENSE is not Apache-2.0"
grep -q 'Licence: Apache-2.0' README.md || report "README.md does not declare Apache-2.0"
grep -q '^## \[Unreleased\]' CHANGELOG.md || report "CHANGELOG.md has no Unreleased section"

# The words are split so that this file does not match itself.
markers='TO''DO|FIX''ME|X''XX|HA''CK'
if git grep -nE "(^|[^A-Za-z])($markers)([^A-Za-z]|\$)" -- . ':!*/testdata/*'; then
  report "a tracking marker stands in a tracked file; changes are tracked in CHANGELOG.md"
fi

git ls-files -- README.md AGENTS.md 'docs/*.md' | while IFS= read -r file; do
  awk -v file="$file" '
    /^[[:space:]]*```/ { fenced = !fenced; next }
    fenced { next }
    {
      line = tolower($0)
      gsub(/`[^`]*`/, "", line)
      if (line ~ /(^|[^a-z])(will|roadmap|tbd|wip|planned)([^a-z]|$)/ || line ~ /not yet|coming soon/)
        printf "%s:%d: plan or status wording\n", file, NR
      if (line ~ /^[[:space:]]*[-*] \[[ x]\]/)
        printf "%s:%d: tick box\n", file, NR
    }' "$file"
done | grep . && report "a document states a plan or a status; documents state present fact"

git ls-files -- '*.swift' '*.sh' '*.yml' '*.yaml' Makefile | grep -v '/testdata/' | while IFS= read -r file; do
  awk -v file="$file" '
    NR == 1 && /^#!/ { next }
    /^[[:space:]]*(\/\/|#)/ { run++; if (run == 4) printf "%s:%d: comment block longer than three lines\n", file, NR; next }
    { run = 0 }' "$file"
done | grep . && report "a comment block is longer than three lines"

if git grep -nE 'path:[[:space:]]*"\.\./' -- '*Package.swift' '*Package@swift-*.swift'; then
  report "a manifest names a package beside the repository"
fi

if git grep -nE 'func[[:space:]]+get[A-Z]' -- '*.swift'; then
  report "a function has a get prefix; name the verb of the work"
fi

git ls-files -- 'Sources/*.swift' | while IFS= read -r file; do
  awk -v file="$file" '
    BEGIN {
      base = file
      sub(/^.*\//, "", base)
      sub(/\.swift$/, "", base)
    }
    /^(public |package |internal )?(final |indirect )*(struct|enum|class|actor|protocol) / {
      line = $0
      sub(/^(public |package |internal )?(final |indirect )*(struct|enum|class|actor|protocol) /, "", line)
      sub(/[^A-Za-z0-9_].*$/, "", line)
      types[++typeCount] = line
    }
    /^(public |package |internal |private |fileprivate )?extension / {
      line = $0
      sub(/^(public |package |internal |private |fileprivate )?extension /, "", line)
      sub(/[^A-Za-z0-9_].*$/, "", line)
      if (!(line in extended)) { extended[line] = 1; extendedCount++; lastExtended = line }
    }
    END {
      if (typeCount > 1) printf "%s: declares %d types; one type a file\n", file, typeCount
      else if (typeCount == 1 && types[1] != base) printf "%s: declares %s; the file takes the name of its type\n", file, types[1]
      else if (typeCount == 0 && extendedCount != 1) printf "%s: declares no type and does not extend exactly one\n", file
      else if (typeCount == 0 && index(base, lastExtended "+") != 1) printf "%s: extends %s; the file is named %s+Concern.swift\n", file, lastExtended, lastExtended
    }' "$file"
done | grep . && report "a source file does not hold one type under its own name"

git ls-files -z | xargs -0 shasum -a 256 2>/dev/null | awk '
  $2 ~ /\/testdata\// { next }
  { count[$1]++; names[$1] = names[$1] " " $2 }
  END { for (hash in count) if (count[hash] > 1 && hash != "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855") print "identical files:" names[hash] }' \
  | grep . && report "two tracked files are identical"

git ls-files -z -- '*.json' Package.resolved | xargs -0 -n 1 jq empty || report "a JSON file does not parse"

exit "$fail"
