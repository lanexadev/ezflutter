# Phase 1: Fathom — Intelligence Report

## Territory Map

### Current State
- Fresh Flutter 3.41.6 project (Dart ^3.11.4)
- Org: com.lanexadev
- Platforms: Android + iOS only
- Files: default flutter create output (main.dart counter app, pubspec.yaml, analysis_options.yaml)
- Branch: develop (clean slate, V1 preserved on main + tag v1.0.0)
- Spec: spec/v2-spec.md (660 lines, 20 modules)

### Target State (from spec)
20 modules across 3 layers:
- **core/** (13 modules): di, router, network, auth, storage, theme, i18n, notifications, error, logging, connectivity, lifecycle, env
- **app/** (7 concerns): config.dart, routes.dart, pages/, widgets/, models/, services/, providers/
- **tools/** (7 scripts): rename, setup, generate, clean, update, create_page, create_service
- **support**: .ai/ (AI skills), config/ (env files), test/ (3 layers), ci/ (GitHub Actions)

### Package Compatibility (verified)
All packages resolve successfully with Flutter 3.41.6:
- flutter_riverpod 3.3.1 ✓
- auto_route 11.1.0 ✓ (spec said ^9.x, 11.x is better)
- get_it (latest) ✓
- injectable (latest) ✓
- dio 5.9.2 ✓
- retrofit (latest) ✓
- freezed_annotation 3.1.0 ✓
- json_annotation (latest) ✓
- shared_preferences (latest) ✓
- flutter_secure_storage 10.0.0 ✓
- flex_color_scheme 8.4.0 ✓
- connectivity_plus 7.1.0 ✓
- Total: 83 dependencies, all resolvable

## Historical Record

### V1 Learnings
- Provider-based state management was too basic (no compile-time safety)
- Manual routing map was fragile (no type safety, no deep linking)
- No DI framework = tight coupling everywhere
- No data models = raw Map<String, dynamic> everywhere
- Auth was hardcoded (admin/admin) — placeholder only
- ThemeManager had bugs (instantiated outside Provider)
- TranslationService was both singleton AND in Provider (conflicting patterns)
- WidgetsFlutterBinding.ensureInitialized() called twice
- Test was outdated and broken

### Git Conventions
- Commit style: conventional commits (chore:, docs:, feat:, fix:)
- Branch strategy: develop → main via PR
- Releases: tags (v1.0.0) with GitHub releases

## Build Order (dependency-sorted)

### Layer 0 — Foundation (no deps)
1. **env** — Environment config (everything reads this)
2. **logging** — Logger (everything logs)
3. **error** — AppException + Result type (everything uses this)

### Layer 1 — Infrastructure (depends on Layer 0)
4. **di** — get_it + injectable setup (registers everything)
5. **models** — Freezed base models (AuthToken, User, ApiResponse)

### Layer 2 — Services (depends on Layer 1)
6. **storage** — SharedPreferences + SecureStorage + Drift
7. **network** — Dio + interceptors + Retrofit
8. **connectivity** — Network monitoring

### Layer 3 — Features (depends on Layer 2)
9. **auth** — AuthService + token management + guards
10. **theme** — FlexColorScheme + ThemeManager + persistence
11. **i18n** — Slang + locale persistence

### Layer 4 — App Integration (depends on Layer 3)
12. **router** — AutoRoute + guards (needs auth)
13. **notifications** — Local + push (needs routing for deep links)
14. **lifecycle** — App lifecycle observer
15. **responsive** — Responsive utilities

### Layer 5 — App Layer
16. **app/config.dart** — Simplified config
17. **app/routes.dart** — Route declarations
18. **app/pages/** — Example pages (home, auth, settings)
19. **app/widgets/** — Reusable widgets
20. **main entry points** — main.dart, main_dev.dart, main_staging.dart, main_prod.dart

### Layer 6 — Tooling & Docs
21. **tools/** — CLI scripts
22. **.ai/** — AI skills
23. **test/** — Test structure + examples
24. **ci/** — GitHub Actions workflows

## Impact Map
- ~80+ files to create
- pubspec.yaml: 20+ dependencies to add
- analysis_options.yaml: switch to very_good_analysis
- build_runner codegen for: freezed, json_serializable, auto_route, injectable, riverpod, retrofit

## Assumptions (auto_mode)
- Using latest available versions of all packages (not pinning to spec's minimum versions)
- auto_route 11.x instead of spec's ^9.x (newer, compatible)
- Riverpod 3.3.1 instead of spec's ^3.0.3
- Will NOT include Firebase packages initially (firebase_messaging, firebase_crashlytics) — they require Firebase project setup which is user-specific. Will provide interfaces + stub implementations.
- drift will be included as optional (interface provided, setup left to user)
- slang requires specific tooling — will verify availability, may fall back to simpler i18n if not available
