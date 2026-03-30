import 'package:ezflutter/app/widgets/error_view.dart';
import 'package:ezflutter/app/widgets/loading_widget.dart';
import 'package:ezflutter/core/ez/ez_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A pre-built detail page that displays fields from a data object.
///
/// ```dart
/// @RoutePage()
/// class ProductDetailPage extends EzDetailPage<Product> {
///   const ProductDetailPage({required this.id, super.key});
///   final String id;
///
///   @override
///   String get title => 'Product';
///
///   @override
///   List<EzField> get fields => [
///     EzField.text('name', label: 'Name'),
///     EzField.currency('price', label: 'Price'),
///   ];
///
///   @override
///   AsyncValue<Product> watchData(WidgetRef ref) =>
///       ref.watch(productProvider(id));
///
///   @override
///   void invalidateData(WidgetRef ref) =>
///       ref.invalidate(productProvider(id));
/// }
/// ```
abstract class EzDetailPage<T> extends ConsumerWidget {
  const EzDetailPage({
    this.padding = const EdgeInsets.all(16),
    super.key,
  });

  /// Page title.
  String get title;

  /// Fields to display.
  List<EzField> get fields;

  /// Watch the async data from a provider.
  AsyncValue<T> watchData(WidgetRef ref);

  /// Invalidate the provider for refresh.
  void invalidateData(WidgetRef ref);

  /// Override to add AppBar actions.
  List<Widget>? buildActions(BuildContext context, WidgetRef ref) => null;

  /// Override to add a hero widget above the fields.
  Widget? buildHero(BuildContext context, T data) => null;

  /// Padding around the content.
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = watchData(ref);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: buildActions(context, ref),
      ),
      body: asyncData.when(
        data: (data) {
          final dataMap = _toMap(data);
          return SingleChildScrollView(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (buildHero(context, data) case final hero?) hero,
                ...fields.map((field) => field.buildDisplay(context, dataMap)),
              ],
            ),
          );
        },
        loading: () => const LoadingWidget(),
        error: (error, _) => ErrorView(
          message: error.toString(),
          onRetry: () => invalidateData(ref),
        ),
      ),
    );
  }

  Map<String, dynamic> _toMap(T data) {
    if (data is Map<String, dynamic>) return data;
    try {
      return (data as dynamic).toJson() as Map<String, dynamic>;
    } catch (_) {
      return {};
    }
  }
}
