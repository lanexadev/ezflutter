import 'dart:io';

import 'package:nativiq_cli/nativiq_cli.dart';

Future<void> main(List<String> arguments) async {
  final exitCode = await NativiqCli().run(arguments);
  if (exitCode != 0) {
    exit(exitCode);
  }
}
