# FORGE Contract: 01-ezflutter-v2

## Architecture Decisions

### ADR-01: Dual-layer architecture (core/ + app/)
- **Context:** Need to serve both beginners and experienced devs
- **Decision:** Strict separation — core/ is framework (system), app/ is user zone (simplified)
- **Consequences:** More initial scaffolding work, but clear boundaries and simple user experience

### ADR-02: Riverpod 3.x for state management
- **Context:** Need compile-time safe, auto-disposing state management
- **Decision:** flutter_riverpod + riverpod_generator (NOT Provider)
- **Consequences:** Code generation required, but type-safe and modern. Replaces V1's broken Provider setup.

### ADR-03: get_it + injectable for DI alongside Riverpod
- **Context:** Services need DI separate from UI state management
- **Decision:** Use get_it for service locator, injectable for code-gen registration. Riverpod for UI state only.
- **Consequences:** Two systems but clear separation — services in get_it, UI state in Riverpod.

### ADR-04: auto_route for routing
- **Context:** Need type-safe routing with guards and deep linking
- **Decision:** auto_route 11.x (code-gen, declarative, guard support)
- **Consequences:** More setup than go_router but better type safety and actively maintained.

### ADR-05: Firebase packages as optional stubs
- **Context:** Firebase requires project-specific setup (google-services.json, etc.)
- **Decision:** Provide abstract interfaces + stub implementations. User plugs in Firebase when ready.
- **Consequences:** Boilerplate works out of the box without Firebase setup.

### ADR-06: No drift initially, interface only
- **Context:** drift adds significant complexity and codegen. Most beginners won't need it immediately.
- **Decision:** Provide storage interface. SharedPreferences + SecureStorage included. Drift documented as optional.
- **Consequences:** Simpler initial setup. Expert can add drift when needed.

### ADR-07: slang for i18n
- **Context:** Need type-safe translations
- **Decision:** slang + slang_build_runner for code-gen i18n
- **Consequences:** Type-safe access (t.home.title), but requires build_runner.

## Story Backlog

| Story ID | Title | Files | Complexity | Layer |
|----------|-------|-------|------------|-------|
| S-01 | Project setup: pubspec + analysis + directory scaffold | pubspec.yaml, analysis_options.yaml, all dirs | M | Foundation |
| S-02 | Environment config (core/env/) | 3 files + 3 config JSONs + 3 entry points | M | Layer 0 |
| S-03 | Logging system (core/logging/) | 2 files | S | Layer 0 |
| S-04 | Error handling + Result type (core/error/) | 4 files | M | Layer 0 |
| S-05 | DI setup (core/di/) | 3 files | S | Layer 1 |
| S-06 | Base models (core/models/) | 4 files | M | Layer 1 |
| S-07 | Storage services (core/storage/) | 3 files | M | Layer 2 |
| S-08 | Network layer (core/network/) | 5 files | L | Layer 2 |
| S-09 | Connectivity monitor (core/connectivity/) | 2 files | S | Layer 2 |
| S-10 | Auth system (core/auth/) | 4 files | L | Layer 3 |
| S-11 | Theme system (core/theme/) | 2 files | M | Layer 3 |
| S-12 | i18n system (core/i18n/) | 2 files + locale JSONs | M | Layer 3 |
| S-13 | Router setup (core/router/) | 3 files | M | Layer 4 |
| S-14 | Notifications (core/notifications/) | 2 files | M | Layer 4 |
| S-15 | Lifecycle observer (core/lifecycle/) | 2 files | S | Layer 4 |
| S-16 | Responsive utilities (core/responsive/) | 2 files | S | Layer 4 |
| S-17 | App layer: config + routes + example pages | 6+ files | L | Layer 5 |
| S-18 | Main entry points integration | 4 files | M | Layer 5 |
| S-19 | Tools/Scripts CLI | 7 files | L | Layer 6 |
| S-20 | AI Skills (.ai/) | 8 files | M | Layer 6 |
| S-21 | Test structure + examples | 5+ files | M | Layer 6 |
| S-22 | CI/CD GitHub Actions | 3 files | S | Layer 6 |
| S-23 | README V2 | 1 file | S | Layer 6 |
| S-24 | Code generation + verification | build_runner run | S | Final |
