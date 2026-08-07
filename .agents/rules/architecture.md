# Architecture rules

- Organize application code by feature, then by `view`, `view_model`, `repository`, and `service` responsibility.
- Keep dependency direction `view -> view model -> repository -> service`; depend on abstractions at repository boundaries.
- Keep framework primitives small and application-agnostic. A feature must not modify the framework to encode product-specific behavior.
- Put cross-feature code in a shared/core area only after two real consumers demonstrate the abstraction.
- Keep navigation, configuration, and dependency composition at application boundaries.
- Represent recoverable outcomes with typed `Result` and failure values. Convert thrown SDK or transport exceptions at the repository/service boundary.
- Do not introduce code generation unless the benefit is explicit and the generated artifacts have a validation path.

For concrete folder and dependency examples, read `.agents/references/architecture.md`.
