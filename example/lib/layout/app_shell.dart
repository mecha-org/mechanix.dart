import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

import '../features/components/button_preview.dart';
import '../features/components/checkbox_preview.dart';
import '../features/components/icon_button_preview.dart';
import '../features/components/radio_preview.dart';
import '../features/theme/theme_preview.dart';
import '../features/typography/typography_preview.dart';
import 'app_sidebar.dart';

/// The main application layout shell composing the sidebar and content area.
class AppShell extends StatefulWidget {
  /// Initial section to show (e.g. 'typography' or 'theme').
  final String initialSection;

  /// Optional callback when theme mode changes.
  final ValueChanged<ThemeMode>? onThemeModeChanged;

  const AppShell({
    super.key,
    this.initialSection = 'typography',
    this.onThemeModeChanged,
  });

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late String _selectedSection;

  @override
  void initState() {
    super.initState();
    _selectedSection = widget.initialSection;
  }

  void _handleSectionSelected(String section) {
    if (_selectedSection != section) {
      setState(() {
        _selectedSection = section;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = MechanixTheme.of(context);
    final isDesktop = MediaQuery.sizeOf(context).width >= 600;

    if (!isDesktop) {
      return Scaffold(
        appBar: AppBar(title: Text(_appBarTitle(_selectedSection))),
        drawer: Drawer(
          backgroundColor: theme.colorScheme.surfaceContainerLow,
          child: SafeArea(
            child: Builder(
              builder: (drawerContext) => AppSidebar(
                selectedSection: _selectedSection,
                onSectionSelected: (section) {
                  Navigator.of(drawerContext).pop();
                  _handleSectionSelected(section);
                },
                onThemeModeChanged: widget.onThemeModeChanged,
              ),
            ),
          ),
        ),
        body: _MainContent(section: _selectedSection),
      );
    }

    return Scaffold(
      body: Row(
        children: [
          Material(
            color: theme.colorScheme.surfaceContainerLow,
            child: Container(
              width: 260,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(color: theme.colorScheme.outlineVariant),
                ),
              ),
              child: SafeArea(
                child: AppSidebar(
                  selectedSection: _selectedSection,
                  onSectionSelected: _handleSectionSelected,
                  onThemeModeChanged: widget.onThemeModeChanged,
                ),
              ),
            ),
          ),
          Expanded(child: _MainContent(section: _selectedSection)),
        ],
      ),
    );
  }

  String _appBarTitle(String section) {
    switch (section) {
      case 'typography':
        return 'Typography';
      case 'theme':
        return 'Theme Overview';
      case 'buttons':
        return 'Buttons';
      case 'checkboxes':
        return 'Checkboxes';
      case 'icon_buttons':
        return 'Icon Buttons';
      case 'radio_buttons':
        return 'Radio Buttons';
      case 'inputs':
        return 'Inputs';
      case 'cards':
        return 'Cards';
      default:
        return 'Mechanix UI';
    }
  }
}

/// The main content area displaying the selected catalog section.
class _MainContent extends StatelessWidget {
  final String section;

  const _MainContent({required this.section});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget content;
    switch (section) {
      case 'typography':
        content = const TypographyPreview();
        break;
      case 'buttons':
        content = const ButtonPreview();
        break;
      case 'checkboxes':
        content = const CheckboxPreview();
        break;
      case 'icon_buttons':
        content = const IconButtonPreview();
        break;
      case 'radio_buttons':
        content = const RadioPreview();
        break;
      case 'theme':
        content = const ThemePreview();
        break;
      default:
        content = Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.construction_rounded,
                  size: 48,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  '${section[0].toUpperCase()}${section.substring(1)} Section',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'This section will be added in a future update.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        );
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: ListView(padding: const EdgeInsets.all(24), children: [content]),
    );
  }
}
