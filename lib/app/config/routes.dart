import 'package:flutter/material.dart';
import 'package:ezflutter/app/pages/splash_screen.dart';
import 'package:ezflutter/app/pages/home.dart';
import 'package:ezflutter/app/pages/documentation.dart';
import 'package:ezflutter/app/pages/notifications.dart';
import 'package:ezflutter/app/pages/auth.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/splash': (context) => SplashScreen(),
  '/home': (context) => HomePage(),
  '/documentation': (context) => DocumentationPage(),
  '/notifications': (context) => NotificationsPage(),
  '/auth': (context) => AuthPage(),
};
