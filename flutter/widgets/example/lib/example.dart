import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

import 'example_page_items.dart';

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return _MasterDetailPage(pageItems: examplePageItems);
  }
}

class _MasterDetailPage extends StatefulWidget {
  const _MasterDetailPage({required this.pageItems});

  final List<PageItem> pageItems;

  @override
  State<_MasterDetailPage> createState() => _MasterDetailPageState();
}

class _MasterDetailPageState extends State<_MasterDetailPage> {
  int _selectedIndex = 15;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;

        if (isWide) {
          /// Desktop / tablet → side by side
          return Scaffold(
            body: Row(
              children: [
                // Sidebar column with icon at top
                Column(
                  children: [
                    ThemeToggleButton(),
                    Expanded(
                      // ← Give the sidebar expanded height
                      child: _buildSidebar(context),
                    ),
                  ],
                ),
                const VerticalDivider(width: 1, thickness: 1),
                Expanded(
                  child: _buildDetailScaffold(context, showDrawer: false),
                ),
              ],
            ),
          );
        } else {
          /// Mobile → sidebar as drawer
          return _buildDetailScaffold(context, showDrawer: true);
        }
      },
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Material(
        elevation: 2,
        child: ListView.builder(
          itemCount: widget.pageItems.length,
          itemBuilder: (context, index) {
            final page = widget.pageItems[index];
            final selected = index == _selectedIndex;
            return Column(
              children: [
                ListTile(
                  leading: page.iconBuilder(context, selected),
                  title: Text(page.title),
                  selected: selected,
                  onTap: () {
                    setState(() => _selectedIndex = index);
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop(); // close drawer on mobile
                    }
                  },
                ),

                //divider between items
                if (index < widget.pageItems.length - 1)
                  const Divider(height: 1, thickness: 0.8),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDetailScaffold(BuildContext context,
      {required bool showDrawer}) {
    return Scaffold(
      appBar: AppBar(
        leading: showDrawer
            ? Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              )
            : null,
        title: buildTitle(context, widget.pageItems[_selectedIndex]),
        actions: buildActions(context, widget.pageItems[_selectedIndex]),
      ),
      drawer: showDrawer ? Drawer(child: _buildSidebar(context)) : null,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: widget.pageItems[_selectedIndex].pageBuilder(context),
      ),
      floatingActionButton: buildFloatingActionButton(
        context,
        widget.pageItems[_selectedIndex],
      ),
    );
  }
}

/// Helper builders
Widget? buildLeading(BuildContext context, PageItem item) {
  return item.leadingBuilder?.call(context);
}

Widget buildTitle(BuildContext context, PageItem item) {
  return item.titleBuilder?.call(context) ?? Text(item.title);
}

List<Widget>? buildActions(BuildContext context, PageItem item) {
  return item.actionsBuilder?.call(context);
}

Widget? buildFloatingActionButton(BuildContext context, PageItem item) {
  return item.floatingActionButtonBuilder?.call(context);
}
