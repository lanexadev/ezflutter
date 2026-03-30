import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ezflutter/core/services/translation_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadResources();
  }

  Future<void> _loadResources() async {
    await Future.delayed(Duration(seconds: 3)); // Simule un chargement
    Provider.of<TranslationService>(context, listen: false).loadLanguage('en');
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade700,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset('assets/logo.png', height: 100)), // Ajout d’un logo
          SizedBox(height: 20),
          CircularProgressIndicator(color: Colors.white), // Ajout d'un loader
          SizedBox(height: 20),
          Text(
            "EzFlutter",
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
