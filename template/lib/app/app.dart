import 'package:flutter/material.dart';

import '../features/home/presentation/home_screen.dart';

final class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'START.DART App',
    theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
    home: const HomeScreen(),
  );
}
