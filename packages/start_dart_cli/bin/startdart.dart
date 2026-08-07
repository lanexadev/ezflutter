import 'dart:io';

import 'package:start_dart_cli/start_dart_cli.dart';

Future<void> main(List<String> arguments) async {
  final exitCode = await StartDartCli().run(arguments);
  if (exitCode != 0) {
    exit(exitCode);
  }
}
