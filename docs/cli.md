# CLI reference

## `nativiq create <name>`

Creates an Android/iOS Flutter application. Common options include `--org`, `--description`, `--output`, and `--json`.

## `nativiq doctor`

Checks Dart, Flutter, platform tooling, and the current environment. It returns a non-zero status when a required dependency is unavailable.

## `nativiq add feature <name>`

Adds a feature-first MVVM vertical slice to the current Nativiq application.

## `nativiq add model <feature> <name>`

Adds an immutable domain model to an existing feature.

All commands are non-interactive and support automation-friendly output through `--json`. Run `nativiq <command> --help` for the installed version's exact options.
