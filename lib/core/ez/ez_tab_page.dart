import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A pre-built tabbed page from declarative configuration.
///
/// ```dart
/// @RoutePage()
/// class DashboardPage extends EzTabPage {
///   const DashboardPage({super.key});
///
///   @override
///   String get title => 'Dashboard';
///
///   @override
///   List<EzTab> get tabs => [
///     EzTab(label: 'Overview', icon: Icons.dashboard, body: OverviewWidget()),
///     EzTab(label: 'Stats', icon: Icons.bar_chart, body: StatsWidget()),
///     EzTab(label: 'Activity', icon: Icons.history, body: ActivityWidget()),
///   ];
/// }
/// ```
abstract class EzTabPage extends ConsumerStatefulWidget {
  const EzTabPage({super.key});

  /// Page title.
  String get title;

  /// Tabs to display.
  List<EzTab> get tabs;

  /// Override to add AppBar actions.
  List<Widget>? buildActions(BuildContext context, WidgetRef ref) => null;

  /// Whether tabs should be scrollable (for many tabs).
  bool get isScrollable => false;

  @override
  ConsumerState<EzTabPage> createState() => _EzTabPageState();
}

class _EzTabPageState extends ConsumerState<EzTabPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: widget.buildActions(context, ref),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: widget.isScrollable,
          tabs: widget.tabs
              .map(
                (tab) => Tab(
                  text: tab.label,
                  icon: tab.icon != null ? Icon(tab.icon) : null,
                ),
              )
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: widget.tabs.map((tab) => tab.body).toList(),
      ),
    );
  }
}

/// A single tab in an [EzTabPage].
class EzTab {
  const EzTab({
    required this.label,
    required this.body,
    this.icon,
  });

  /// Tab label text.
  final String label;

  /// Tab content widget.
  final Widget body;

  /// Optional tab icon.
  final IconData? icon;
}
