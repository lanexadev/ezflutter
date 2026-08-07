# AI agent entry point

Read `.agents/rules/` before changing code. Load only the relevant workflow from
`.agents/skills/`, and consult `.agents/references/architecture.md` for structural decisions.
Hooks are documented in `.agents/hooks/README.md`.

This application targets Android and iOS only. Preserve the feature-first MVVM boundaries and
run `flutter analyze` plus `flutter test` before presenting a change.
