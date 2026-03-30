import 'package:ezflutter/core/ez/ez_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A pre-built form page with automatic field rendering and validation.
///
/// ```dart
/// @RoutePage()
/// class CreateProductPage extends EzFormPage {
///   CreateProductPage() : super(
///     title: 'New Product',
///     fields: [
///       EzField.text('name', label: 'Name', required: true),
///       EzField.currency('price', label: 'Price', required: true),
///       EzField.image('imageUrl', label: 'Photo'),
///     ],
///     submitLabel: 'Create',
///     onSubmit: (data) async {
///       await getIt<ProductService>().create(data);
///     },
///   );
/// }
/// ```
abstract class EzFormPage extends ConsumerStatefulWidget {
  const EzFormPage({
    required this.title,
    required this.fields,
    required this.onSubmit,
    this.submitLabel = 'Submit',
    this.initialData,
    this.padding = const EdgeInsets.all(16),
    this.spacing = 16.0,
    super.key,
  });

  /// Page title.
  final String title;

  /// Form fields.
  final List<EzField> fields;

  /// Called with form data when submitted and valid.
  final Future<void> Function(Map<String, dynamic> data) onSubmit;

  /// Submit button label.
  final String submitLabel;

  /// Initial values for edit mode.
  final Map<String, dynamic>? initialData;

  /// Padding around the form.
  final EdgeInsets padding;

  /// Spacing between fields.
  final double spacing;

  @override
  ConsumerState<EzFormPage> createState() => _EzFormPageState();
}

class _EzFormPageState extends ConsumerState<EzFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _data = <String, dynamic>{};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _data.addAll(widget.initialData!);
    }
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    _formKey.currentState?.save();

    setState(() => _isLoading = true);
    try {
      await widget.onSubmit(_data);
      if (mounted) Navigator.of(context).maybePop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        padding: widget.padding,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...widget.fields.map(
                (field) => Padding(
                  padding: EdgeInsets.only(bottom: widget.spacing),
                  child: field.buildInput(context, _data),
                ),
              ),
              SizedBox(height: widget.spacing),
              FilledButton(
                onPressed: _isLoading ? null : _submit,
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(widget.submitLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
