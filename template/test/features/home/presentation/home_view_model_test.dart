import 'package:flutter_test/flutter_test.dart';
import 'package:start_dart_app/features/home/data/in_memory_home_repository.dart';
import 'package:start_dart_app/features/home/presentation/home_view_model.dart';

void main() {
  test('loads the repository message', () async {
    final viewModel = HomeViewModel(InMemoryHomeRepository());
    await viewModel.load();
    expect(viewModel.message, 'Home ready');
  });
}
