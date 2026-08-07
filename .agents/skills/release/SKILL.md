---
name: release
description: Prepare and verify a Nativiq version release without publishing implicitly. Use for version bumps, changelogs, migration notes, release candidates, tags, CLI packaging, and release-readiness checks.
---

# Prepare a release

1. Read `AGENTS.md`, `.agents/rules/git.md`, `.agents/rules/security.md`, and [references/release-contract.md](references/release-contract.md).
2. Determine the semantic version from user-visible changes and identify every package whose public contract changed.
3. Ensure versions, changelog, migration guide, install examples, and generated dependency constraints agree.
4. Run `.agents/hooks/validate.sh`, generator smoke tests, secret scanning, and release workflow inspection.
5. Build the CLI artifact locally and verify it starts, reports its version, and emits machine-readable output where promised.
6. Review the release diff and record known limitations and rollback instructions.
7. Stop before publishing, pushing tags, or creating a remote release unless the user explicitly authorizes that external action.

Never bypass a failing gate or mutate an existing release tag.
