import 'package:ezflutter/core/storage/settings_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockPrefs;
  late SettingsService service;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    service = SettingsService(mockPrefs);
  });

  group('SettingsService', () {
    test('get returns value when key exists', () {
      when(() => mockPrefs.get('theme')).thenReturn('dark');
      expect(service.get<String>('theme'), equals('dark'));
    });

    test('get returns null when key does not exist', () {
      when(() => mockPrefs.get('missing')).thenReturn(null);
      expect(service.get<String>('missing'), isNull);
    });

    test('set stores string value', () async {
      when(() => mockPrefs.setString('key', 'value'))
          .thenAnswer((_) async => true);
      final result = await service.set('key', 'value');
      expect(result, isTrue);
      verify(() => mockPrefs.setString('key', 'value')).called(1);
    });

    test('set stores bool value', () async {
      when(() => mockPrefs.setBool('flag', true))
          .thenAnswer((_) async => true);
      final result = await service.set('flag', true);
      expect(result, isTrue);
    });

    test('set stores int value', () async {
      when(() => mockPrefs.setInt('count', 42))
          .thenAnswer((_) async => true);
      final result = await service.set('count', 42);
      expect(result, isTrue);
    });

    test('remove deletes key', () async {
      when(() => mockPrefs.remove('key')).thenAnswer((_) async => true);
      final result = await service.remove('key');
      expect(result, isTrue);
    });

    test('containsKey returns true when key exists', () {
      when(() => mockPrefs.containsKey('key')).thenReturn(true);
      expect(service.containsKey('key'), isTrue);
    });
  });
}
