# Generation contract

The generator must be non-interactive and deterministic for the same CLI arguments and tool version. It must reject invalid Dart package names, path traversal, symlink escapes, non-empty targets, and unsupported platforms before creating the destination.

Generated applications must include:

- Android and iOS platform projects only.
- Feature-first MVVM source layout.
- Development, staging, and production configuration with safe placeholders.
- A passing starter test and an agent contract suitable for project-local work.

On failure, no partially generated destination may remain. During repository integration tests, local path dependencies are allowed; released output must use published package constraints.
