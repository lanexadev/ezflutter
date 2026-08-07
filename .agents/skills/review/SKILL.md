---
name: review
description: Review Nativiq changes for correctness, regressions, architecture, security, tests, documentation, and agent-contract drift. Use for code review, pull-request review, pre-merge audit, design verification, and release-readiness review.
---

# Review a change

1. Read `AGENTS.md`, relevant `.agents/rules/`, the stated intent, and the full diff.
2. Trace affected behavior from entry point to boundary and test. Verify every claimed acceptance criterion against evidence.
3. Prioritize correctness, data loss, unsafe filesystem behavior, secret exposure, platform drift, and public API breakage.
4. Check MVVM dependency direction, typed failure conversion, lifecycle cleanup, deterministic tests, and documentation drift.
5. Run focused verification when it can confirm or refute a suspected issue.
6. Report only actionable findings, ordered by severity, with file/line, impact, evidence, and a repair direction. Distinguish facts from residual risks.
7. If no findings remain, state that explicitly and list verification gaps.

Use `.agents/templates/review-report.md` for substantial reviews. Read [references/severity.md](references/severity.md) before assigning severity.
