# Release contract

- Tags use `v<major>.<minor>.<patch>` and point to a reviewed commit.
- Breaking changes require a major version and migration guidance.
- The CLI archive includes licenses and excludes caches, credentials, test fixtures, and local path overrides.
- Release notes identify behavior changes, breaking changes, upgrade steps, and known limitations.
- Automation uses least-privilege permissions and produces checksums for downloadable artifacts.
- Publication to pub.dev, GitHub Releases, stores, or other registries is always an explicit external action.
