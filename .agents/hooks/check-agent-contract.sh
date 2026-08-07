#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$root"

required=(
  AGENTS.md
  CLAUDE.md
  GEMINI.md
  .github/copilot-instructions.md
  .cursor/rules/start-dart.mdc
)

for file in "${required[@]}"; do
  [[ -s "$file" ]] || { echo "Missing agent adapter: $file" >&2; exit 1; }
done

for file in CLAUDE.md GEMINI.md .github/copilot-instructions.md .cursor/rules/start-dart.mdc; do
  grep -q 'AGENTS.md' "$file" || { echo "$file must route to AGENTS.md" >&2; exit 1; }
done

for skill in create-app deliver-feature test review release; do
  file=".agents/skills/$skill/SKILL.md"
  [[ -s "$file" ]] || { echo "Missing skill: $skill" >&2; exit 1; }
  head -n 1 "$file" | grep -qx -- '---' || { echo "Invalid frontmatter: $file" >&2; exit 1; }
  grep -q "^name: $skill$" "$file" || { echo "Invalid skill name: $file" >&2; exit 1; }
  grep -q '^description: ' "$file" || { echo "Missing skill description: $file" >&2; exit 1; }
done

for hook in .agents/hooks/validate.sh .agents/hooks/check-agent-contract.sh .agents/hooks/check-generated-project.sh; do
  [[ -x "$hook" ]] || { echo "Hook is not executable: $hook" >&2; exit 1; }
done

echo "Agent contract is consistent."
