# Page Templates

EzFlutter provides pre-built page types. Choose the right one:

## Simple Page (custom layout)

```dart
@RoutePage()
class {Name}Page extends ConsumerWidget {
  const {Name}Page({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('{Name}')),
      body: const Center(child: Text('{Name} Page')),
    );
  }
}
```

## List Page (EzListPage)

For any page that shows a list with loading/error/empty/refresh:

```dart
@RoutePage()
class {Name}Page extends EzListPage<{Model}> {
  const {Name}Page({super.key});

  @override
  String get title => '{Name}';

  @override
  AsyncValue<List<{Model}>> watchData(WidgetRef ref) =>
      ref.watch({name}sProvider);

  @override
  void invalidateData(WidgetRef ref) => ref.invalidate({name}sProvider);

  @override
  Widget buildItem(BuildContext context, {Model} item) =>
      EzTile(title: item.name, subtitle: item.description);

  @override
  void onItemTap(BuildContext context, {Model} item) =>
      context.router.push({Name}DetailRoute(id: item.id));
}
```

## Form Page (EzFormPage)

For create/edit forms with auto validation:

```dart
@RoutePage()
class Create{Name}Page extends EzFormPage {
  const Create{Name}Page({super.key});

  @override
  String get title => 'New {Name}';
  @override
  String get submitLabel => 'Create';

  @override
  List<EzField> get fields => [
    EzField.text('name', label: 'Name', required: true),
    EzField.currency('price', label: 'Price', symbol: '€'),
    EzField.select('category', label: 'Category', options: ['A', 'B', 'C']),
  ];

  @override
  Future<void> Function(Map<String, dynamic> data) get onSubmit =>
      (data) async => getIt<{Name}Service>().create(data);
}
```

## Settings Page (EzSettingsPage)

For settings/preferences screens:

```dart
@RoutePage()
class {Name}Page extends EzSettingsPage {
  const {Name}Page({super.key});

  @override
  String get title => '{Name}';

  @override
  List<EzSection> get sections => [
    EzSection('General', [
      EzSetting.navigation(label: 'Profile', route: ProfileRoute(), icon: Icons.person),
      EzSetting.action(label: 'Logout', icon: Icons.logout, isDanger: true, onTap: () {}),
    ]),
  ];
}
```

## Detail Page (EzDetailPage)

For showing model details from field definitions:

```dart
@RoutePage()
class {Name}DetailPage extends EzDetailPage<{Model}> {
  const {Name}DetailPage({required this.id, super.key});
  final String id;

  @override
  String get title => '{Name}';

  @override
  List<EzField> get fields => [
    EzField.text('name', label: 'Name'),
    EzField.currency('price', label: 'Price'),
    EzField.date('createdAt', label: 'Created'),
  ];

  @override
  AsyncValue<{Model}> watchData(WidgetRef ref) => ref.watch({name}Provider(id));

  @override
  void invalidateData(WidgetRef ref) => ref.invalidate({name}Provider(id));
}
```

## Rules
- File: `lib/app/pages/{name}_page.dart`
- Always use `@RoutePage()` annotation
- Prefer Ez* pages over raw Flutter widgets
- Add route in `lib/core/router/app_router.dart`
- Run `dart run build_runner build --delete-conflicting-outputs` after

## CLI
```bash
dart run tools/create_page.dart --name "Products" --type list
dart run tools/create_page.dart --name "CreateProduct" --type form
dart run tools/create_page.dart --name "AppSettings" --type settings
```
