#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$root"
"$root/.agents/hooks/check-agent-contract.sh"

if (($#)); then
  packages=("$@")
else
  mapfile_command="mapfile"
  if ! command -v "$mapfile_command" >/dev/null 2>&1; then
    packages=()
    while IFS= read -r manifest; do packages+=("$(dirname "$manifest")"); done < <(find . -name pubspec.yaml -not -path './.dart_tool/*' -not -path './build/*' -not -path './.agents/*' | sort)
  else
    mapfile -t packages < <(find . -name pubspec.yaml -not -path './.dart_tool/*' -not -path './build/*' -not -path './.agents/*' | sort | xargs -n1 dirname)
  fi
fi

for package in "${packages[@]}"; do
  [[ -f "$package/pubspec.yaml" ]] || { echo "Not a Dart package: $package" >&2; exit 1; }
  echo "Validating $package"
  (
    cd "$package"
    dart format --output=none --set-exit-if-changed .
    if grep -Eq '^[[:space:]]+flutter:' pubspec.yaml; then
      flutter analyze
      if [[ -d test ]]; then flutter test; fi
    else
      dart analyze
      if [[ -d test ]]; then dart test; fi
    fi
  )
done
