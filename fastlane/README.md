# Fastlane Setup

## Prerequisites

```bash
gem install fastlane
```

## Android Setup

1. Create a Google Play Console service account
2. Download the JSON key file
3. Save it as `fastlane/play-store-key.json` (gitignored)
4. Update `Appfile` with your package name

```bash
fastlane android build    # Build APK
fastlane android deploy   # Deploy to Play Store (internal)
```

## iOS Setup

1. Update `Appfile` with your Apple ID and team ID
2. Configure code signing (match recommended)

```bash
fastlane ios build    # Build IPA
fastlane ios deploy   # Deploy to TestFlight
```

## Secrets

These files must NOT be committed:
- `fastlane/play-store-key.json`
- Any `.p12` or `.mobileprovision` files

They are already in `.gitignore`.
