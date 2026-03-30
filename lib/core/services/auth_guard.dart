import 'package:flutter/material.dart';
import 'auth_service.dart';

class AuthGuard extends StatelessWidget {
  final Widget page;
  const AuthGuard({required this.page});

  @override
  Widget build(BuildContext context) {
    if (!AuthService().isLoggedIn) {
      return Scaffold(
        body: Center(
          child: Text("Vous devez être connecté pour accéder à cette page."),
        ),
      );
    }
    return page;
  }
}
