import 'package:auto_route/auto_route.dart';
import 'package:ezflutter/core/router/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: ProductListRoute.page),
        AutoRoute(page: ProductDetailRoute.page),
        AutoRoute(page: AddProductRoute.page),
        AutoRoute(page: CartRoute.page),
      ];
}
