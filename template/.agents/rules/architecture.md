# Architecture rules

- Organize product code by feature, then by `data`, `domain`, and `presentation`.
- Presentation depends on domain contracts; data implements those contracts.
- View models own screen state. Widgets render state and forward user intent.
- Keep platform support limited to Android and iOS.
