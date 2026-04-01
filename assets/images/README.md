# App Assets

Place your app images here:

| File | Size | Purpose |
|---|---|---|
| `app_icon.png` | 1024x1024 | Main app icon (used by flutter_launcher_icons) |
| `app_icon_foreground.png` | 1024x1024 | Adaptive icon foreground (Android) |
| `splash_logo.png` | 400x400 | Splash screen logo (centered) |
| `splash_icon.png` | 288x288 | Android 12 splash icon |

## Generate Icons

After placing your images:
```bash
dart run flutter_launcher_icons
```

## Generate Splash Screen

```bash
dart run flutter_native_splash:create
```
