#!/usr/bin/env bash
set -euo pipefail

if (($# != 1)); then
  echo "Usage: $0 <generated-project>" >&2
  exit 64
fi

project="$(cd "$1" && pwd)"
[[ -f "$project/pubspec.yaml" ]] || { echo "Missing pubspec.yaml in $project" >&2; exit 1; }
[[ -d "$project/android" && -d "$project/ios" ]] || { echo "Generated project must contain android/ and ios/" >&2; exit 1; }

for unsupported in web linux macos windows; do
  [[ ! -e "$project/$unsupported" ]] || { echo "Unsupported generated platform: $unsupported" >&2; exit 1; }
done

(
  cd "$project"
  flutter pub get
  dart format --output=none --set-exit-if-changed .
  flutter analyze
  flutter test
)
