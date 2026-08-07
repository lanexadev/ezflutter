import '../domain/home_repository.dart';

final class InMemoryHomeRepository implements HomeRepository {
  @override
  Future<String> load() async => 'Home ready';
}
