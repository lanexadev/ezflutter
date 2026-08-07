# Test matrix

| Surface | Primary test | Required concerns |
|---|---|---|
| Framework primitive | Dart/Flutter unit | types, edge cases, public API |
| View model | unit with fakes | transitions, concurrency, typed failures |
| View | widget | semantics, interaction, visible states |
| CLI parsing | unit | flags, JSON output, exit semantics |
| Generator | temp-directory integration | safe paths, atomic failure, file set |
| Template | generated-project smoke | dependency resolution, analyze, test |
| CI/release | workflow inspection | triggers, permissions, artifacts, platforms |

Do not use network access in the default suite. Keep platform builds in CI jobs designed for Android and unsigned iOS simulator verification.
