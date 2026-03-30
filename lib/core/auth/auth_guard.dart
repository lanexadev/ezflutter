import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ezflutter/core/auth/auth_provider.dart';
import 'package:ezflutter/core/auth/auth_state.dart';

/// Route guard that redirects to login if not authenticated.
class AuthGuard extends AutoRouteGuard {
  AuthGuard(this._ref);

  final Ref _ref;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final authState = _ref.read(authProvider);

    if (authState is Authenticated) {
      resolver.next();
    } else {
      // TODO: Replace with your login route
      // router.push(const LoginRoute());
      resolver.next(false);
    }
  }
}
