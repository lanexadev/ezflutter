# Dart and Flutter rules

- Target the Dart and Flutter constraints declared by each package; do not rely on a newer local SDK without updating constraints intentionally.
- Use sound null safety, immutable values by default, exhaustive switches, and explicit public API types.
- Prefer `final`, `const`, composition, and small widgets. Avoid service locators inside views.
- Keep `build` methods free of I/O and business logic. Dispose every owned controller, subscription, and focus node.
- Avoid `dynamic`, unchecked casts, force unwraps, and broad exception catches unless a documented boundary requires them.
- Use package imports across library boundaries and relative imports within a feature when consistent with the package.
- Format changed Dart files and keep the analyzer at zero issues.
- Generated apps must contain only `android/` and `ios/` platform directories.
