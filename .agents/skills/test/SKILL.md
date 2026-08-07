---
name: test
description: Design, add, and run deterministic tests for Nativiq framework, CLI, templates, and generated Flutter apps. Use for test strategy, regressions, coverage gaps, generator smoke tests, widgets, integration tests, and acceptance verification.
---

# Test Nativiq

1. Read `AGENTS.md` and `.agents/rules/tests.md`; add security rules for generator or filesystem tests.
2. Identify the behavior boundary and select the cheapest test that proves it: unit, widget, CLI integration, generated-project smoke, or workflow inspection.
3. Make each test deterministic and isolated. Use temporary directories for generator tests and fakes for owned I/O boundaries.
4. Cover success plus relevant validation, typed failure, empty, retry, cancellation, and cleanup behavior.
5. Prefer semantic assertions over snapshots or private-field checks.
6. Run the focused test first, then the containing package suite. Use `.agents/hooks/validate.sh` for final verification.
7. Report commands, pass/fail counts, uncovered acceptance criteria, and environmental limitations.

Read [references/test-matrix.md](references/test-matrix.md) when choosing test layers.
