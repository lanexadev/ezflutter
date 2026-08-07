import 'package:flutter_test/flutter_test.dart';
import 'package:nativiq_app/core/config/app_environment.dart';

void main() {
  test('exposes all deployment environments', () {
    expect(AppEnvironment.values, hasLength(3));
  });
}
