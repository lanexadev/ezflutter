import 'package:flutter/material.dart';
import 'package:ezflutter/core/services/auth_service.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final AuthService _authService = AuthService();
  bool isLoggedIn = false;

  void _login() {
    _authService.login("admin", "admin");
    setState(() {
      isLoggedIn = _authService.isLoggedIn;
    });
  }

  void _logout() {
    _authService.logout();
    setState(() {
      isLoggedIn = _authService.isLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("🔐 Authentification")),
      body: Center(
        child: isLoggedIn
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Connecté !"),
                  SizedBox(height: 20),
                  ElevatedButton(onPressed: _logout, child: Text("Se déconnecter")),
                ],
              )
            : ElevatedButton(onPressed: _login, child: Text("Se connecter")),
      ),
    );
  }
}
