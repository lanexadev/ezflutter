import 'package:flutter_test/flutter_test.dart';
import 'package:start_dart/start_dart.dart';

void main() {
  group('PageRequest', () {
    test('calculates the offset from a one-based page', () {
      const request = PageRequest(page: 3, pageSize: 25);

      final offset = request.offset;

      expect(offset, 50);
    });

    test('preserves page size when advancing', () {
      const request = PageRequest(page: 3, pageSize: 25);

      final next = request.next;

      expect(
        next,
        isA<PageRequest>().having((it) => it.pageSize, 'pageSize', 25),
      );
    });
  });

  group('Page', () {
    test('calculates a partial final page', () {
      final page = Page<int>(
        items: const [1, 2],
        page: 1,
        pageSize: 2,
        totalItems: 5,
      );

      final totalPages = page.totalPages;

      expect(totalPages, 3);
    });

    test('protects items from mutation', () {
      final source = [1, 2];
      final page = Page<int>(
        items: source,
        page: 1,
        pageSize: 2,
        totalItems: 2,
      );
      source.add(3);

      final items = page.items;

      expect(items, [1, 2]);
    });

    test('maps items while preserving metadata', () {
      final page = Page<int>(
        items: const [1, 2],
        page: 2,
        pageSize: 2,
        totalItems: 5,
      );

      final mapped = page.map((item) => '#$item');

      expect(
        mapped,
        isA<Page<String>>()
            .having((it) => it.items, 'items', ['#1', '#2'])
            .having((it) => it.page, 'page', 2)
            .having((it) => it.totalItems, 'totalItems', 5),
      );
    });
  });

  group('CursorPage', () {
    test('reports a following page when a cursor exists', () {
      final page = CursorPage<int>(items: const [1], nextCursor: 'next');

      final hasNext = page.hasNext;

      expect(hasNext, isTrue);
    });
  });
}
