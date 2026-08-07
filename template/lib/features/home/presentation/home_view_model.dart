import 'package:flutter/foundation.dart';
import 'package:start_dart/start_dart.dart';

import '../domain/home_repository.dart';

final class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._repository);

  final HomeRepository _repository;
  AsyncState<String> state = const AsyncState.idle();
  String get message => state.dataOrNull ?? '';

  Future<void> load() async {
    state = AsyncState.loading(previousData: state.dataOrNull);
    notifyListeners();
    state = AsyncState.data(await _repository.load());
    notifyListeners();
  }
}
