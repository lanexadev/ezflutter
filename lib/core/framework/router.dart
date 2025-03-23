import 'package:ezflutter/app/config/routes.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    WidgetBuilder? builder = appRoutes[settings.name];
    return MaterialPageRoute(
      builder: (context) => builder != null ? builder(context) : _errorPage(),
      settings: settings,
    );
  }

  static Widget _errorPage() {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: const Center(child: Text('Page not found')),
    );
  }
}
