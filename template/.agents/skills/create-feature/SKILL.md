---
name: create-feature
description: Add a feature while preserving Nativiq feature-first MVVM boundaries.
---

# Create a feature

1. Create `lib/features/<name>/{data,domain,presentation}`.
2. Define the repository contract in domain and its implementation in data.
3. Add a view model and screen in presentation.
4. Add unit and widget tests for observable behavior.
5. Run `flutter analyze` and `flutter test`.

Prefer `nativiq add feature <name>` for the initial scaffold.
