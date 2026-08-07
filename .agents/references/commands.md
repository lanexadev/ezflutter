# Repository command reference

Prefer repository-provided commands and inspect package manifests before adding dependencies.

```sh
# Full local gate
.agents/hooks/validate.sh

# Contract-only gate
.agents/hooks/check-agent-contract.sh

# Generated application smoke gate
.agents/hooks/check-generated-project.sh <generated-project>

# Typical focused Flutter package checks
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
```

The validation hook discovers Dart/Flutter packages. Pass package directories to restrict a run, for example `.agents/hooks/validate.sh packages/nativiq`.
