import 'package:flutter/material.dart';

import '../data/in_memory_home_repository.dart';
import 'home_view_model.dart';

final class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final class _HomeScreenState extends State<HomeScreen> {
  late final HomeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = HomeViewModel(InMemoryHomeRepository())..load();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Home')),
    body: ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) => Center(
        child: viewModel.state.isLoading
            ? const CircularProgressIndicator()
            : Text(viewModel.message, key: const Key('home_message')),
      ),
    ),
  );
}
