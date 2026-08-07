# Delivery checklist

- Public behavior and failure behavior are explicit.
- Views contain rendering and event forwarding only.
- View models expose immutable, testable state.
- Repositories present domain-facing contracts and translate failures.
- Services isolate SDK, filesystem, storage, or network details.
- Configuration differs safely across dev, staging, and production.
- Accessibility, localization, loading, empty, retry, and offline states are considered where relevant.
- Tests cover the changed boundary, not private implementation structure.
- Documentation changes accompany public API, CLI, architecture, or migration changes.
