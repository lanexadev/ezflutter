import 'package:flutter/widgets.dart';

/// Screen breakpoints.
enum ScreenType { phone, tablet, largeTablet }

/// Responsive utilities as BuildContext extensions.
extension ResponsiveExtension on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  bool get isPhone => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 900;
  bool get isLargeTablet => screenWidth >= 900;

  ScreenType get screenType {
    if (isLargeTablet) return ScreenType.largeTablet;
    if (isTablet) return ScreenType.tablet;
    return ScreenType.phone;
  }
}

/// Widget that builds different layouts based on screen size.
class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    required this.phone,
    this.tablet,
    this.largeTablet,
    super.key,
  });

  final WidgetBuilder phone;
  final WidgetBuilder? tablet;
  final WidgetBuilder? largeTablet;

  @override
  Widget build(BuildContext context) {
    return switch (context.screenType) {
      ScreenType.largeTablet => (largeTablet ?? tablet ?? phone)(context),
      ScreenType.tablet => (tablet ?? phone)(context),
      ScreenType.phone => phone(context),
    };
  }
}
