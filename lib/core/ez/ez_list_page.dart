import 'package:ezflutter/app/widgets/empty_state.dart';
import 'package:ezflutter/app/widgets/error_view.dart';
import 'package:ezflutter/app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A pre-built list page that handles loading, error, empty, and refresh.
///
/// The developer only configures what to show, not how.
///
/// ```dart
/// @RoutePage()
/// class ProductsPage extends EzListPage<Product> {
///   const ProductsPage({super.key});
///
///   @override
///   String get title => 'Products';
///
///   @override
///   AsyncValue<List<Product>> watchData(WidgetRef ref) =>
///       ref.watch(productsProvider);
///
///   @override
///   void invalidateData(WidgetRef ref) =>
///       ref.invalidate(productsProvider);
///
///   @override
///   Widget buildItem(BuildContext context, Product item) => EzTile(
///     title: item.name,
///     subtitle: '${item.price} €',
///   );
/// }
/// ```
abstract class EzListPage<T> extends ConsumerWidget {
  const EzListPage({
    this.emptyMessage = 'No items found',
    this.emptyIcon = Icons.inbox_outlined,
    this.divider = false,
    this.padding = EdgeInsets.zero,
    super.key,
  });

  /// Page title shown in AppBar.
  String get title;

  /// Watch the async data from a provider.
  AsyncValue<List<T>> watchData(WidgetRef ref);

  /// Invalidate the provider for refresh.
  void invalidateData(WidgetRef ref);

  /// Build a widget for each item.
  Widget buildItem(BuildContext context, T item);

  /// Called when an item is tapped. Override to navigate.
  void onItemTap(BuildContext context, T item) {}

  /// Override to add AppBar actions.
  List<Widget>? buildActions(BuildContext context, WidgetRef ref) => null;

  /// Override to add a FAB.
  Widget? buildFab(BuildContext context, WidgetRef ref) => null;

  /// Message shown when list is empty.
  final String emptyMessage;

  /// Icon shown when list is empty.
  final IconData emptyIcon;

  /// Show dividers between items.
  final bool divider;

  /// Padding around the list.
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = watchData(ref);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: buildActions(context, ref),
      ),
      floatingActionButton: buildFab(context, ref),
      body: asyncData.when(
        data: (items) {
          if (items.isEmpty) {
            return EmptyState(
              message: emptyMessage,
              icon: emptyIcon,
            );
          }
          return RefreshIndicator(
            onRefresh: () async => invalidateData(ref),
            child: ListView.separated(
              padding: padding,
              itemCount: items.length,
              separatorBuilder: (_, _) => divider
                  ? const Divider(height: 1)
                  : const SizedBox.shrink(),
              itemBuilder: (context, index) {
                final item = items[index];
                return InkWell(
                  onTap: () => onItemTap(context, item),
                  child: buildItem(context, item),
                );
              },
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
}
