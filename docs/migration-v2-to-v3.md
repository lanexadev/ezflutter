# Migrating from EzFlutter V2

V3 is a product redesign, not an in-place framework upgrade. Create a fresh Nativiq app and migrate feature by feature.

1. Record current user journeys, API contracts, persistence, and environment values.
2. Generate a Nativiq application.
3. Move domain models without UI or transport dependencies.
4. Rebuild repositories and services behind interfaces.
5. Move screens into feature presentation folders and introduce view models.
6. Replace `Ez*` inheritance with ordinary composed Flutter widgets.
7. Port unit/widget tests, then add integration coverage for critical journeys.
8. Validate Android and iOS builds before switching application identifiers.

There is no compatibility shim for `EzListPage`, `EzFormPage`, generated routing, injectable registrations, or V2 configuration files. Keeping the migration explicit produces a smaller and more understandable application.
