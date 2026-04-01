# EzFlutter V2 Architecture

## Layer Diagram
```
┌────────────────────────────────────┐
│          App Layer (lib/app/)      │
│  config, pages, widgets, models,   │
│  services, providers               │
├────────────────────────────────────┤
│       Core Layer (lib/core/)       │
│  di, router, network, auth,        │
│  storage, theme, i18n, error,      │
│  logging, connectivity, lifecycle, │
│  env, responsive, notifications    │
└────────────────────────────────────┘
```

## Data Flow
1. User interacts with UI (app/pages/)
2. UI reads state from Riverpod providers
3. Providers call services (via get_it DI)
4. Services use Dio for API calls
5. Responses are mapped to Freezed models
6. Result type handles success/failure
7. UI rebuilds reactively

## Package Roles
| Package | Role |
|---|---|
| flutter_riverpod | UI state management |
| get_it + injectable | Service DI |
| auto_route | Navigation |
| dio + retrofit | HTTP |
| freezed | Immutable models |
| flex_color_scheme | Theming |
| shared_preferences | Settings |
| flutter_secure_storage | Secure data |
| connectivity_plus | Network monitoring |
