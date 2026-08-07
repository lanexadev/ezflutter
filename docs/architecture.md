# Architecture

START.DART uses feature-first MVVM with explicit boundaries.

1. Views render state and forward user intent.
2. View models coordinate use cases and expose immutable async state.
3. Repositories define the domain-facing data contract.
4. Services communicate with devices, persistence, and remote APIs.

Dependencies point inward. Presentation code does not import concrete services; services do not know about widgets. `package:start_dart` supplies small primitives and does not dictate state management, routing, networking, or code generation.

## Error contract

Expected failures travel as `Result<T>` and typed `Failure` values. Unexpected programmer errors are allowed to fail loudly in development. UI code maps failures to user-safe messages and must not expose tokens, raw responses, or stack traces.

## State contract

Async operations expose idle, loading, success, or failure. Pagination retains loaded data while requesting another page. Cancellation and duplicate-request prevention belong to the view model or service boundary.

## Testing pyramid

- Unit-test framework primitives, view models, repositories, and validation.
- Widget-test important states and interactions.
- Integration-test a small set of critical journeys.
- Generator tests assert the generated architecture and run its quality gate.
