import 'package:flutter/widgets.dart';

import 'app/app.dart';
import 'core/config/app_environment.dart';

void bootstrap(AppEnvironment environment) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}
