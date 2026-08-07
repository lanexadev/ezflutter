import 'dart:collection';

/// Parameters for offset-based pagination.
final class PageRequest {
  /// Creates a page request.
  const PageRequest({this.page = 1, this.pageSize = 20})
    : assert(page > 0, 'page must be greater than zero'),
      assert(pageSize > 0, 'pageSize must be greater than zero');

  /// The one-based page number.
  final int page;

  /// The maximum number of requested items.
  final int pageSize;

  /// The zero-based item offset.
  int get offset => (page - 1) * pageSize;

  /// Returns a request for the following page.
  PageRequest get next => PageRequest(page: page + 1, pageSize: pageSize);
}

/// An immutable page of offset-based results.
final class Page<T> {
  /// Creates a page and protects its items from mutation.
  Page({
    required List<T> items,
    required this.page,
    required this.pageSize,
    required this.totalItems,
  }) : assert(page > 0, 'page must be greater than zero'),
       assert(pageSize > 0, 'pageSize must be greater than zero'),
       assert(totalItems >= 0, 'totalItems must not be negative'),
       items = UnmodifiableListView(List<T>.of(items));

  /// Items in this page.
  final List<T> items;

  /// The one-based page number.
  final int page;

  /// The configured page size.
  final int pageSize;

  /// Total item count across all pages.
  final int totalItems;

  /// Total page count.
  int get totalPages => totalItems == 0 ? 0 : (totalItems / pageSize).ceil();

  /// Whether a following page exists.
  bool get hasNext => page < totalPages;

  /// Whether a preceding page exists.
  bool get hasPrevious => page > 1;

  /// Transforms every item while preserving pagination metadata.
  Page<R> map<R>(R Function(T item) transform) => Page(
    items: items.map(transform).toList(growable: false),
    page: page,
    pageSize: pageSize,
    totalItems: totalItems,
  );
}

/// An immutable page of cursor-based results.
final class CursorPage<T> {
  /// Creates a cursor page.
  CursorPage({required List<T> items, this.nextCursor})
    : items = UnmodifiableListView(List<T>.of(items));

  /// Items in this page.
  final List<T> items;

  /// Opaque cursor for the following page, or `null` at the end.
  final String? nextCursor;

  /// Whether a following page exists.
  bool get hasNext => nextCursor != null;

  /// Transforms every item while preserving the cursor.
  CursorPage<R> map<R>(R Function(T item) transform) => CursorPage(
    items: items.map(transform).toList(growable: false),
    nextCursor: nextCursor,
  );
}
