# START.DART agent contract

START.DART is an AI-native Flutter application system for Android and iOS. This file is the canonical entry point for every coding agent in this repository.

## Load context progressively

1. Read only the files in `.agents/rules/` that apply to the task.
2. Use the matching repository skill in `.agents/skills/` for creation, feature delivery, testing, review, or release work.
3. Load a skill's `references/` files only when its `SKILL.md` directs you to them.
4. Use `.agents/references/` and `.agents/templates/` for shared contracts and reusable artifacts.

## Non-negotiable constraints

- Support Android and iOS only. Do not add web or desktop platforms.
- Follow feature-first MVVM: views depend on view models; view models depend on repositories; repositories depend on services.
- Return typed failures through START.DART primitives. Do not leak infrastructure exceptions into UI code.
- Keep secrets out of source, fixtures, logs, and generated projects.
- Make the smallest coherent change, add proportional tests, and run `.agents/hooks/validate.sh` before handoff.
- Never add AI attribution or co-author trailers to commits.

Tool-specific files are adapters only. If an adapter conflicts with this file or `.agents/rules/`, this contract wins.
