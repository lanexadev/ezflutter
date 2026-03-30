import 'package:auto_route/auto_route.dart';
import 'package:ezflutter/core/router/app_router.gr.dart';

/// Main router configuration.
///
/// Add new routes here by adding an AutoRoute entry.
/// Pages must be annotated with @RoutePage().
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: LoginRoute.page),
      ];

  @override
  List<AutoRouteGuard> get guards => [
        // AuthGuard can be added here when needed
      ];
}
