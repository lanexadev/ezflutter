# EzShop — EzFlutter Showcase

A complete product catalog app built with **EzFlutter V2**, demonstrating the Ez* declarative page system, Riverpod state management, Freezed models, and all framework features.

> This is a showcase/example project. The boilerplate framework is at [lanexadev/ezflutter](https://github.com/lanexadev/ezflutter).

## What This Demonstrates

### Ez* Pages in Action

| Page | Ez* Class | Lines of Config |
|---|---|---|
| Product List | `EzListPage<Product>` | ~25 lines (loading/error/empty/refresh/search) |
| Product Detail | `EzDetailPage<Product>` | ~25 lines (hero image + field display) |
| Add Product | `EzFormPage` | ~30 lines (6 field types + validation) |
| Settings | `EzSettingsPage` | ~40 lines (theme + language + logout) |

### Framework Features Used

- **EzField** — text, email, password, currency, select, toggle, date, textArea
- **EzTile** — product cards with avatar, badge ("In Stock"/"Sold Out"), chevron
- **EzService** — ProductService with `guard()` for auto error handling
- **Riverpod** — async providers for products, cart state management
- **Freezed** — Product and CartItem models with JSON serialization
- **Auth** — login/logout flow with state-aware UI
- **Theming** — light/dark/system toggle (persisted)
- **i18n** — EN/FR translations (type-safe via Slang)
- **Connectivity** — offline banner on home page

## Pages

### Home (Dashboard)
Welcome banner, featured products, quick actions, cart badge, auth state.

### Products (EzListPage + Search)
Full product list with search bar, pull-to-refresh, empty state, loading indicator.

### Product Detail (EzDetailPage)
Hero image, auto-rendered fields from `EzField` definitions, add-to-cart action.

### Add Product (EzFormPage)
Declarative form with 6 field types, auto-validation, submit with loading state.

### Cart
Quantity controls, computed totals, clear cart, checkout (demo).

### Settings (EzSettingsPage)
Theme toggle (light/dark/system), language switch (EN/FR), logout.

## Setup

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart run slang
flutter run --dart-define-from-file=config/dev.json
```

## Project Structure

```
lib/app/
├── models/
│   ├── product.dart        # Freezed product model
│   └── cart_item.dart      # Freezed cart item with computed total
├── services/
│   └── product_service.dart # EzService with guard() + 8 mock products
├── providers/
│   └── product_providers.dart # Riverpod: products, product(id), cart
├── pages/
│   ├── home_page.dart         # Dashboard
│   ├── product_list_page.dart # EzListPage + search
│   ├── product_detail_page.dart # EzDetailPage + hero
│   ├── add_product_page.dart  # EzFormPage
│   ├── cart_page.dart         # Shopping cart
│   ├── settings_page.dart     # EzSettingsPage
│   └── login_page.dart        # Auth with EzField
└── widgets/                   # Loading, Empty, Error, AsyncValue
```

## License

MIT — see [LICENSE](LICENSE)
