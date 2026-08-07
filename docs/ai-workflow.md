# AI workflow

`AGENTS.md` is the universal entry point. It sends every supported agent to the same canonical material under `.agents/`.

Use a skill when the task matches it:

- `create-app` for a new product baseline;
- `deliver-feature` for a vertical product change;
- `test` for strategy and missing coverage;
- `review` for evidence-based review;
- `release` for release preparation.

Rules are durable constraints. Skills are executable workflows. Hooks are deterministic checks. References explain architecture and conventions. Vendor files must not fork or duplicate the canonical doctrine.

Agents must inspect before editing, keep changes scoped, never invent credentials, and finish with analysis and tests proportional to risk.
