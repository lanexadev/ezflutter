import 'dart:async';

import 'package:ezflutter/app/widgets/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A list page with infinite scroll pagination.
///
/// ```dart
/// @RoutePage()
/// class ProductsPage extends EzPaginatedListPage<Product> {
///   const ProductsPage({super.key});
///
///   @override
///   String get title => 'Products';
///
///   @override
///   int get pageSize => 20;
///
///   @override
///   Future<List<Product>> fetchPage(WidgetRef ref, int page) async {
///     final result = await getIt<ProductService>().getPage(page, pageSize);
///     return result.dataOrNull ?? [];
///   }
///
///   @override
///   Widget buildItem(BuildContext context, Product item) =>
///       EzTile(title: item.name);
/// }
/// ```
abstract class EzPaginatedListPage<T> extends ConsumerStatefulWidget {
  const EzPaginatedListPage({
    this.emptyMessage = 'No items found',
    this.emptyIcon = Icons.inbox_outlined,
    this.divider = false,
    this.padding = EdgeInsets.zero,
    super.key,
  });

  /// Page title.
  String get title;

  /// Items per page.
  int get pageSize => 20;

  /// Fetch a page of items (0-indexed).
  Future<List<T>> fetchPage(WidgetRef ref, int page);

  /// Build a widget for each item.
  Widget buildItem(BuildContext context, T item);

  /// Called when an item is tapped.
  void onItemTap(BuildContext context, T item) {}

  /// Override to add AppBar actions.
  List<Widget>? buildActions(BuildContext context, WidgetRef ref) => null;

  /// Override to add a FAB.
  Widget? buildFab(BuildContext context, WidgetRef ref) => null;

  final String emptyMessage;
  final IconData emptyIcon;
  final bool divider;
  final EdgeInsets padding;

  @override
  ConsumerState<EzPaginatedListPage<T>> createState() =>
      _EzPaginatedListPageState<T>();
}

class _EzPaginatedListPageState<T>
    extends ConsumerState<EzPaginatedListPage<T>> {
  final List<T> _items = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _currentPage = 0;
  Object? _error;

  @override
  void initState() {
    super.initState();
    unawaited(_loadPage());
  }

  Future<void> _loadPage() async {
    if (_isLoading || !_hasMore) return;
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final newItems = await widget.fetchPage(ref, _currentPage);
      if (mounted) {
        setState(() {
          _items.addAll(newItems);
          _currentPage++;
          _hasMore = newItems.length >= widget.pageSize;
          _isLoading = false;
        });
      }
    } on Exception catch (e) {
      if (mounted) {
        setState(() {
          _error = e;
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _items.clear();
      _currentPage = 0;
      _hasMore = true;
      _error = null;
    });
    await _loadPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: widget.buildActions(context, ref),
      ),
      floatingActionButton: widget.buildFab(context, ref),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_error != null && _items.isEmpty) {
      return ErrorView(
        message: _error.toString(),
        onRetry: _refresh,
      );
    }

    if (!_isLoading && _items.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(widget.emptyIcon, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(widget.emptyMessage),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.separated(
        padding: widget.padding,
        itemCount: _items.length + (_hasMore ? 1 : 0),
        separatorBuilder: (_, _) => widget.divider
            ? const Divider(height: 1)
            : const SizedBox.shrink(),
        itemBuilder: (context, index) {
          if (index >= _items.length) {
            unawaited(_loadPage());
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          final item = _items[index];
          return InkWell(
            onTap: () => widget.onItemTap(context, item),
            child: widget.buildItem(context, item),
          );
        },
      ),
    );
  }
}
