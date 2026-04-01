# EzFlutter V2 — Specification

> **Statut** : En cours de design
> **Plateformes cibles** : Android / iOS uniquement (pas de web, pas de desktop)
> **Public cible** : Developpeurs Flutter debutants ET experimentes

---

## Philosophie

EzFlutter V2 repose sur une separation stricte en deux couches :

```
lib/
├── core/       # FRAMEWORK — Systeme (devs experimentes uniquement)
└── app/        # APPLICATION — Zone utilisateur (tous les devs)
```

### `core/` — La couche Framework

- Contient toute la plomberie : DI, routing, networking, auth, storage, theming, i18n, error handling, logging, notifications, connectivity
- Les developpeurs debutants **n'y touchent pas**
- Les developpeurs experimentes peuvent modifier, etendre, remplacer les implementations
- Expose des interfaces simples et des helpers que `app/` consomme

### `app/` — La couche Application

- C'est la **seule zone** ou un developpeur debutant travaille
- Tout est simplifie au maximum : creer une page, ajouter une route, appeler un service = quelques lignes
- Les patterns complexes (DI, interceptors, guards) sont caches derriere des abstractions simples
- Conventions over configuration : le framework fait les bons choix par defaut

### Principe directeur

> Un debutant doit pouvoir creer une nouvelle page avec appel API en moins de 5 minutes sans toucher a `core/`.
> Un expert doit pouvoir remplacer n'importe quelle brique du framework sans casser le reste.

---

## Structure du projet

```
ezflutter/
├── lib/
│   ├── main.dart                         # Entry point unique
│   ├── main_dev.dart                     # Entry point dev
│   ├── main_staging.dart                 # Entry point staging
│   ├── main_prod.dart                    # Entry point prod
│   │
│   ├── core/                             # FRAMEWORK
│   │   ├── di/                           # Dependency Injection (get_it + injectable)
│   │   ├── router/                       # Routing (auto_route)
│   │   ├── network/                      # HTTP client (Dio + Retrofit + interceptors)
│   │   ├── auth/                         # Auth service, token management, guards
│   │   ├── storage/                      # Settings, secure storage, database (drift)
│   │   ├── theme/                        # Theme manager (flex_color_scheme + Material 3)
│   │   ├── i18n/                         # Internationalization (slang)
│   │   ├── notifications/                # Local + push notifications
│   │   ├── error/                        # Error handling, exceptions, Result type
│   │   ├── logging/                      # Logger avec niveaux
│   │   ├── connectivity/                 # Network monitoring + offline mode
│   │   ├── lifecycle/                    # App lifecycle observer
│   │   └── env/                          # Environment config (dev/staging/prod)
│   │
│   └── app/                              # APPLICATION (zone utilisateur)
│       ├── config.dart                   # Config simplifiee (1 fichier, seed color, app name, API URL)
│       ├── routes.dart                   # Declaration des routes (liste simple)
│       ├── pages/                        # Les pages/ecrans
│       ├── widgets/                      # Widgets custom reutilisables
│       ├── models/                       # Modeles de donnees (freezed)
│       ├── services/                     # Services metier de l'app
│       └── providers/                    # Providers Riverpod de l'app
│
├── tools/                                # Scripts CLI
│   ├── rename.dart                       # Renommer le projet
│   ├── setup.dart                        # Setup initial
│   ├── generate.dart                     # Code generation (build_runner)
│   ├── clean.dart                        # Clean + rebuild
│   ├── create_page.dart                  # Generer une nouvelle page
│   └── create_service.dart               # Generer un nouveau service
│
├── .ai/                                  # Skills IA
│   ├── CLAUDE.md                         # Instructions Claude Code
│   ├── .cursorrules                      # Rules Cursor AI
│   ├── copilot-instructions.md           # Instructions GitHub Copilot
│   ├── architecture.md                   # Description architecture pour IA
│   ├── conventions.md                    # Conventions de code
│   └── templates/                        # Templates de code (page, service, model)
│
├── config/                               # Variables d'environnement
│   ├── dev.json                          # Config dev
│   ├── staging.json                      # Config staging
│   └── prod.json                         # Config prod
│
├── assets/
│   ├── locales/                          # Fichiers de traduction (JSON)
│   ├── images/                           # Images
│   └── fonts/                            # Polices custom
│
├── test/
│   ├── unit/                             # Tests unitaires
│   ├── widget/                           # Tests widget
│   └── integration/                      # Tests d'integration
│
├── ci/                                   # CI/CD
│   └── .github/workflows/
│       ├── quality.yml                   # Lint + analyze + test
│       ├── build.yml                     # Build APK/IPA
│       └── release.yml                   # Tag -> build -> deploy
│
├── spec/                                 # Ce dossier — specs du projet
├── pubspec.yaml
├── analysis_options.yaml                 # very_good_analysis
└── README.md
```

---

## 1. Tools / Scripts CLI

**Objectif** : Automatiser les taches repetitives pour que le dev se concentre sur son app.

| Script | Commande | Description |
|---|---|---|
| `rename` | `dart run tools/rename.dart --name "MyApp" --org "com.example"` | Renomme le package partout (pubspec, Android bundle ID, iOS bundle ID, display name) |
| `setup` | `dart run tools/setup.dart` | Installe les deps, genere le code, configure les flavors |
| `generate` | `dart run tools/generate.dart` | Lance build_runner (freezed, json_serializable, auto_route, injectable, slang) |
| `clean` | `dart run tools/clean.dart` | flutter clean + supprime `*.g.dart`, `*.freezed.dart`, `*.gr.dart` + rebuild |
| `update` | `dart run tools/update.dart` | Met a jour les deps + regenere + lance les tests |
| `create_page` | `dart run tools/create_page.dart --name "Profile"` | Genere `pages/profile_page.dart` avec scaffold, route annotation, provider |
| `create_service` | `dart run tools/create_service.dart --name "Payment"` | Genere un service avec interface + implementation + registration DI |

---

## 2. State Management — Riverpod 3.x

**Package** : `flutter_riverpod ^3.0.3` + `riverpod_generator`

### Cote framework (`core/`)
- Providers systeme pre-configures : auth state, theme, locale, connectivity
- Auto-dispose des providers non utilises
- Persistence integree (Riverpod 3.0)

### Cote app (`app/providers/`)
- Le dev cree ses providers avec des annotations simples
- Pattern MVVM : chaque page peut avoir un provider/notifier

### Exemple simplifie pour le dev
```dart
// app/providers/counter_provider.dart
@riverpod
class Counter extends _$Counter {
  @override
  int build() => 0;

  void increment() => state++;
}

// app/pages/counter_page.dart
class CounterPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    return Text('$count');
  }
}
```

---

## 3. Routing — Auto Route

**Package** : `auto_route ^9.x` + `auto_route_generator`

### Cote framework (`core/router/`)
- Configuration du router avec guards (auth, onboarding)
- Deep linking setup
- Transition animations par defaut
- Navigation depuis les notifications

### Cote app (`app/routes.dart` + annotations)
- Le dev decore ses pages avec `@RoutePage()` et les liste dans un fichier unique

### Exemple simplifie pour le dev
```dart
// app/pages/profile_page.dart
@RoutePage()
class ProfilePage extends StatelessWidget { ... }

// app/routes.dart — le dev ajoute juste une ligne
@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: ProfileRoute.page),    // <- ajouter ca
    AutoRoute(page: SettingsRoute.page),
  ];
}
```

---

## 4. Dependency Injection — Get_it + Injectable

**Packages** : `get_it ^7.7+`, `injectable ^2.4+`, `injectable_generator`

### Cote framework (`core/di/`)
- Registration automatique des services systeme
- Modules par environnement (`@dev`, `@staging`, `@prod`)
- Lazy singletons pour les services lourds

### Cote app
- Le dev annote ses services avec `@injectable` ou `@singleton`
- Acces via `getIt<MonService>()` ou injection dans le constructeur

### Exemple simplifie pour le dev
```dart
// app/services/payment_service.dart
@injectable
class PaymentService {
  Future<bool> pay(double amount) async { ... }
}

// Utilisation n'importe ou
final paymentService = getIt<PaymentService>();
await paymentService.pay(9.99);
```

---

## 5. Networking — Dio + Retrofit

**Packages** : `dio ^5.7+`, `retrofit ^4.x`, `retrofit_generator`

### Cote framework (`core/network/`)
- Dio pre-configure avec interceptors :
  - **AuthInterceptor** : injecte le token JWT, gere le refresh automatique
  - **LogInterceptor** : logs en dev uniquement
  - **RetryInterceptor** : retry automatique sur erreur reseau
  - **ErrorInterceptor** : convertit les erreurs Dio en `AppException`
- Base URL injectee depuis l'environnement

### Cote app (`app/services/`)
- Le dev definit une interface Retrofit → le code est genere

### Exemple simplifie pour le dev
```dart
// app/services/api/user_api.dart
@RestApi()
abstract class UserApi {
  factory UserApi(Dio dio) = _UserApi;

  @GET('/users/{id}')
  Future<User> getUser(@Path() int id);

  @POST('/users')
  Future<User> createUser(@Body() CreateUserRequest request);
}

// Utilisation
final api = getIt<UserApi>();
final user = await api.getUser(42);
```

---

## 6. Models — Freezed + JSON Serializable

**Packages** : `freezed ^2.x`, `json_serializable ^6.x`, `build_runner`

### Cote framework (`core/`)
- Modeles systeme fournis : `AuthToken`, `User`, `ApiResponse<T>`, `PaginatedResponse<T>`, `AppException`

### Cote app (`app/models/`)
- Le dev cree ses modeles avec l'annotation `@freezed`
- `copyWith`, `==`, `toJson`, `fromJson` generes automatiquement

### Exemple simplifie pour le dev
```dart
// app/models/product.dart
@freezed
class Product with _$Product {
  const factory Product({
    required int id,
    required String name,
    required double price,
    String? imageUrl,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}
```

---

## 7. Theming — Flex Color Scheme + Material 3

**Package** : `flex_color_scheme ^8.4+`

### Cote framework (`core/theme/`)
- `ThemeManager` avec Riverpod : light / dark / system
- Persistence du choix de theme
- Typography system avec echelle configurable
- Component theming complet (boutons, cards, inputs, dialogs, etc.)

### Cote app (`app/config.dart`)
- Le dev change **une seule couleur** et tout le theme s'adapte

### Exemple simplifie pour le dev
```dart
// app/config.dart
class AppConfig {
  static const seedColor = Color(0xFF6750A4);  // <- changer CA
  static const appName = 'My App';
  // C'est tout. Le framework genere light + dark + tous les composants.
}
```

---

## 8. Internationalization — Slang

**Package** : `slang ^4.x` + `slang_flutter`

### Cote framework (`core/i18n/`)
- Configuration de slang, detection de locale, persistence du choix
- Provider Riverpod pour la locale courante

### Cote app (`assets/locales/`)
- Le dev ajoute ses cles dans les fichiers JSON
- Acces type-safe genere automatiquement

### Exemple simplifie pour le dev
```json
// assets/locales/en.json
{
  "home": {
    "title": "Welcome",
    "greeting": "Hello, {name}!"
  }
}
```
```dart
// Utilisation dans un widget
Text(t.home.title)
Text(t.home.greeting(name: 'John'))
```

---

## 9. Auth — Complet et abstrait

**Packages** : `flutter_secure_storage ^10.x`, `dio` (interceptors)

### Cote framework (`core/auth/`)
- `AuthService` abstrait avec implementation par defaut (JWT email/password)
- Token management : access token + refresh token
- Auto-refresh via Dio interceptor (transparent pour le dev)
- Stockage securise des tokens (Keychain iOS / EncryptedSharedPreferences Android)
- Auth state global via Riverpod : `authenticated` / `unauthenticated` / `loading`
- Route guards automatiques (redirige vers login si non authentifie)
- Social login ready (interfaces pour Google, Apple — le dev branche)
- `logout()` = clear tokens + clear cache + redirect login

### Cote app
- Le dev appelle des methodes simples

### Exemple simplifie pour le dev
```dart
// Login
await ref.read(authProvider.notifier).login(email, password);

// Logout
await ref.read(authProvider.notifier).logout();

// Verifier l'etat
final isLoggedIn = ref.watch(authProvider).isAuthenticated;

// Acceder a l'utilisateur courant
final user = ref.watch(currentUserProvider);
```

---

## 10. Storage — Triple couche

### Cote framework (`core/storage/`)

| Couche | Package | Usage | Acces simplifie |
|---|---|---|---|
| **Settings** | `shared_preferences` | Theme, langue, flags | `Settings.get('key')` / `Settings.set('key', value)` |
| **Secure** | `flutter_secure_storage ^10.x` | Tokens, credentials | Gere automatiquement par le framework (auth) |
| **Database** | `drift ^2.x` | Donnees structurees, cache offline, relations | DAO pattern avec code generation |

### Cote app
- Pour les settings simples : helper one-liner
- Pour la DB : le dev cree ses tables avec drift

### Exemple simplifie pour le dev
```dart
// Settings simples
await Settings.set('onboarding_done', true);
final done = await Settings.get<bool>('onboarding_done');

// Database (pour ceux qui en ont besoin)
@DriftDatabase(tables: [Products])
class AppDatabase extends _$AppDatabase { ... }
```

---

## 11. Notifications — Local + Push

**Packages** : `flutter_local_notifications`, `firebase_messaging`

### Cote framework (`core/notifications/`)
- Service abstrait unifie pour local et push
- Gestion des permissions (demande au bon moment)
- Deep linking depuis les notifications tap
- Channels Android preconfigures
- Foreground / background handling

### Cote app
```dart
// Notification locale
await Notify.show(title: 'Rappel', body: 'Tu as un RDV dans 1h');

// Notification programmee
await Notify.schedule(
  title: 'Rappel',
  body: 'Check ton app',
  when: DateTime.now().add(Duration(hours: 1)),
);
```

---

## 12. Environnements — Dev / Staging / Prod

### Cote framework (`core/env/`)

| Environnement | API URL | Logging | Debug banner | Crash reporting |
|---|---|---|---|---|
| `dev` | localhost / mock | Verbose (tout) | Oui | Non |
| `staging` | staging API | Info + errors | Non | Oui |
| `prod` | production API | Errors only | Non | Oui |

- **envied** pour les secrets (cles API) avec obfuscation dans le code genere
- `--dart-define-from-file=config/dev.json` au build
- Entry points separes : `main_dev.dart`, `main_staging.dart`, `main_prod.dart`
- `Env.current` accessible partout pour savoir dans quel mode on est

### Cote app
```dart
// Le dev ne gere rien, il lance juste :
// flutter run --dart-define-from-file=config/dev.json -t lib/main_dev.dart

// Ou via le script :
// dart run tools/run.dart --env dev
```

---

## 13. Error Handling avance

### Cote framework (`core/error/`)
- `AppException` : classe de base avec sous-types
  - `NetworkException` (timeout, no internet, server error)
  - `AuthException` (unauthorized, token expired, forbidden)
  - `CacheException` (read/write failure)
  - `ValidationException` (invalid input)
- **Result type** avec Freezed sealed union :
  ```dart
  @freezed
  sealed class Result<T> {
    const factory Result.success(T data) = Success<T>;
    const factory Result.failure(AppException error) = Failure<T>;
  }
  ```
- Zone d'erreur globale (catch Flutter + async errors)
- Crash reporter abstrait (Firebase Crashlytics / Sentry pluggable)
- Error boundary widget pour les erreurs UI
- En dev : stack trace coloree en console
- En prod : message user-friendly + envoi au crash reporter

### Cote app
```dart
// Le dev utilise le Result type
final result = await ref.read(userProvider.notifier).fetchUser(42);
result.when(
  success: (user) => showProfile(user),
  failure: (error) => showError(error.message),
);
```

---

## 14. Testing

**Packages** : `very_good_analysis ^6.x`, `mocktail`, `flutter_test`, `integration_test`

### Structure
```
test/
├── unit/
│   ├── services/          # Tests des services
│   └── providers/         # Tests des providers/notifiers
├── widget/
│   └── pages/             # Tests des pages
└── integration/
    └── flows/             # Tests des parcours utilisateur
```

### Fourni avec le boilerplate
- Exemples de tests pour chaque couche
- Mocks pre-configures pour les services systeme (auth, API, storage)
- Helper de test (`test/helpers/`) pour le setup commun
- CI qui bloque le merge si les tests echouent

---

## 15. AI Skills — `.ai/`

### Fichiers
| Fichier | Role |
|---|---|
| `CLAUDE.md` (racine) | Instructions principales pour Claude Code |
| `.cursorrules` (racine) | Rules pour Cursor AI |
| `.ai/architecture.md` | Description complete de l'architecture, layers, data flow |
| `.ai/conventions.md` | Conventions de nommage, patterns obligatoires, anti-patterns |
| `.ai/templates/page.md` | Template exact pour creer une page |
| `.ai/templates/service.md` | Template exact pour creer un service |
| `.ai/templates/model.md` | Template exact pour creer un modele |
| `.ai/templates/provider.md` | Template exact pour creer un provider |

### Objectif
- N'importe quelle IA (Claude, Cursor, Copilot) qui ouvre le projet comprend immediatement :
  - Ou mettre quoi
  - Quels patterns suivre
  - Quelles commandes lancer
  - Comment le code est organise

---

## 16. Connectivity Monitor

**Package** : `connectivity_plus`

### Cote framework (`core/connectivity/`)
- Surveillance reseau en temps reel via Riverpod provider
- Bascule automatique sur le cache local quand offline
- Retry automatique quand la connexion revient
- Widget `ConnectivityBanner` pre-fait

### Cote app
```dart
// Verifier la connexion
final isOnline = ref.watch(connectivityProvider);

// Le framework gere le reste automatiquement
// (les appels API basculent sur le cache, retry a la reconnexion)
```

---

## 17. Responsive / Adaptive UI

### Cote framework (`core/`)
- Breakpoints : `phone` (< 600dp), `tablet` (600-900dp), `largeTablet` (> 900dp)
- Helper `context.isPhone`, `context.isTablet`
- Widget `ResponsiveBuilder` pour adapter les layouts
- Safe area handling
- Support orientation portrait / landscape

### Cote app
```dart
ResponsiveBuilder(
  phone: (context) => SingleColumnLayout(),
  tablet: (context) => TwoColumnLayout(),
)
```

---

## 18. CI/CD — GitHub Actions

### Workflows
| Workflow | Trigger | Actions |
|---|---|---|
| `quality.yml` | Chaque PR | Lint, analyze, test, coverage check |
| `build.yml` | Merge sur `main` | Build APK + IPA (signing) |
| `release.yml` | Nouveau tag `v*` | Build + deploy Play Store / App Store (Fastlane) |

---

## 19. Logging avance

### Cote framework (`core/logging/`)
- Niveaux : `verbose`, `debug`, `info`, `warning`, `error`, `fatal`
- En dev : logs colores en console avec timestamp
- En staging : info + errors vers fichier
- En prod : errors + fatal vers crash reporter
- Filtrage automatique selon l'environnement

### Cote app
```dart
Log.info('User logged in');
Log.error('Payment failed', error: e, stackTrace: s);
```

---

## 20. App Lifecycle & Performance

### Cote framework (`core/lifecycle/`)
- Splash screen natif (pas de delay artificiel)
- App lifecycle observer : detection foreground / background
- Deep linking / Universal links pre-configure
- In-app update checker

---

## Stack technique complete

| Categorie | Package | Version |
|---|---|---|
| State Management | `flutter_riverpod` | ^3.0.3 |
| State Codegen | `riverpod_generator` | latest |
| Routing | `auto_route` | ^9.x |
| Routing Codegen | `auto_route_generator` | latest |
| DI | `get_it` | ^7.7+ |
| DI Codegen | `injectable` + `injectable_generator` | ^2.4+ |
| HTTP | `dio` | ^5.7+ |
| API Codegen | `retrofit` + `retrofit_generator` | ^4.x |
| Models | `freezed` + `json_serializable` | latest |
| Code Gen Runner | `build_runner` | latest |
| Local DB | `drift` | ^2.x |
| Settings | `shared_preferences` | ^2.5+ |
| Secure Storage | `flutter_secure_storage` | ^10.x |
| Theme | `flex_color_scheme` | ^8.4+ |
| i18n | `slang` + `slang_flutter` | ^4.x |
| Notifications Local | `flutter_local_notifications` | latest |
| Notifications Push | `firebase_messaging` | latest |
| Crash Reporting | `firebase_crashlytics` | latest |
| Connectivity | `connectivity_plus` | latest |
| Env Secrets | `envied` | latest |
| Linting | `very_good_analysis` | ^6.x |
| Testing | `mocktail` | latest |

---

## Contraintes

- **Mobile uniquement** : Android + iOS. Pas de web, pas de desktop.
- **Dart ^3.7.2** minimum
- **Flutter stable** dernier canal
- **Pas de packages abandonnes** : chaque dep doit etre activement maintenue
- **Zero warning** en analyse statique avec very_good_analysis
