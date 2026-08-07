---
name: deliver-feature
description: Implement an end-to-end Nativiq or generated-app feature using feature-first MVVM and typed failures. Use for new product behavior, feature changes, CLI subcommands, framework capabilities, and bug fixes that cross architectural layers.
---

# Deliver a feature

1. Read `AGENTS.md` and the applicable files in `.agents/rules/`.
2. State the observable outcome and map each acceptance criterion to a test or inspection check. Use `.agents/templates/feature-plan.md` when the change crosses layers.
3. Inspect adjacent implementations and reuse established primitives before adding abstractions or dependencies.
4. Define boundaries from the outside in: view intent, view-model state, repository contract, then service integration.
5. Write the narrowest failing test or reproduction first when practical.
6. Implement typed success, loading, empty, and failure paths without leaking infrastructure exceptions.
7. Run focused tests while iterating, then `.agents/hooks/validate.sh`.
8. Review the diff for architectural direction, generated noise, secrets, and unintended platforms.

Read [references/delivery-checklist.md](references/delivery-checklist.md) for cross-layer or migration-heavy work.
