# Contributing to START.DART

Contributions are welcome. Use a GitHub issue or discussion before implementing a substantial API or architecture change.

## Development workflow

1. Fork the repository and branch from `develop`.
2. Keep the change focused and add tests for observable behavior.
3. Run `.agents/hooks/validate.sh` from the repository root.
4. Use an English [Conventional Commit](https://www.conventionalcommits.org/) subject.
5. Open a pull request to `develop` and complete the pull request template.

Public API changes require documentation and a changelog entry. Breaking changes require migration guidance. Never commit credentials, signing material, personal data, generated build output, or automated attribution trailers.

## Release flow

`develop` is the integration branch. Stable releases are merged into `main`, tagged with a semantic version, and published through the release workflow.

By contributing, you agree that your work is licensed under the repository's MIT License and that you will follow the [Code of Conduct](CODE_OF_CONDUCT.md).
