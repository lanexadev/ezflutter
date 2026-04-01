import 'package:auto_route/auto_route.dart';
import 'package:ezflutter/core/auth/auth_provider.dart';
import 'package:ezflutter/core/auth/auth_state.dart';
import 'package:ezflutter/core/ez/ez_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Login page using EzField for declarative field rendering.
@RoutePage()
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  /// Declarative field definitions — the only thing to configure.
  static final fields = [
    EzField.email('email'),
    EzField.password('password'),
  ];

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _data = <String, dynamic>{};
  bool _isLoading = false;

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    _formKey.currentState?.save();

    setState(() => _isLoading = true);

    await ref.read(authProvider.notifier).login(
          _data['email']?.toString() ?? '',
          _data['password']?.toString() ?? '',
        );

    if (mounted) {
      setState(() => _isLoading = false);
      final state = ref.read(authProvider);
      if (state is Authenticated) {
        context.router.maybePop();
      } else if (state is AuthError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              Icon(
                Icons.lock_outline,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 32),
              // EzField renders the inputs declaratively
              ...LoginPage.fields.map(
                (field) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: field.buildInput(context, _data),
                ),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: _isLoading ? null : _submit,
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
