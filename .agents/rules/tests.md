# Test rules

- Add a failing test or reproducible check before fixing a defect when practical.
- Unit-test framework primitives, validation, view models, repositories, services, and CLI parsing/error behavior.
- Widget-test meaningful UI states and user interactions; do not assert implementation details.
- Integration-test generator output in a temporary directory, including failure atomicity and Android/iOS-only output.
- Tests must be deterministic, isolated, and independent of network access, credentials, wall-clock timing, or execution order.
- Prefer fakes at owned boundaries and mocks only when interaction verification is the behavior under test.
- Every acceptance criterion affected by a change must map to an executable test or an explicit inspection check.
- Run the narrowest relevant tests while iterating, then `.agents/hooks/validate.sh` before handoff.
