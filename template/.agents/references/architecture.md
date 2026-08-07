# Application architecture

The application uses feature-first MVVM. Each feature owns its data adapters, domain contracts,
and presentation layer. Shared cross-feature types live under `lib/core`. Entrypoints select one of
the development, staging, or production environments before bootstrapping the same application.
