import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

import '../features/settings/theme_mode_menu.dart';

/// The sidebar navigation and controls widget for the application.
class AppSidebar extends StatelessWidget {
  /// The currently active section ID (e.g. 'theme', 'typography').
  final String selectedSection;

  /// Callback when a navigation section is chosen.
  final ValueChanged<String>? onSectionSelected;

  /// Optional callback when theme mode changes.
  final ValueChanged<ThemeMode>? onThemeModeChanged;

  const AppSidebar({
    super.key,
    this.selectedSection = 'typography',
    this.onSectionSelected,
    this.onThemeModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = MechanixTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Brand Header
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Icon(
                    MechanixIcons.comet,
                    color: theme.colorScheme.onPrimary,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mechanix Widgets',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Design System',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const Divider(height: 1),

        // Navigation Items Categorized
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            children: [
              // OVERVIEW
              _buildCategoryHeader(context, 'OVERVIEW'),
              _buildNavItem(
                context,
                id: 'theme',
                title: 'Theme Overview',
                icon: Icons.palette_outlined,
              ),

              const SizedBox(height: 16),

              // FOUNDATIONS
              _buildCategoryHeader(context, 'FOUNDATIONS'),
              _buildNavItem(
                context,
                id: 'typography',
                title: 'Typography',
                icon: Icons.text_fields_rounded,
              ),

              const SizedBox(height: 16),

              // COMPONENTS
              _buildCategoryHeader(context, 'COMPONENTS'),
              _buildNavItem(
                context,
                id: 'buttons',
                title: 'Buttons',
                icon: Icons.smart_button_outlined,
              ),
              _buildNavItem(
                context,
                id: 'checkboxes',
                title: 'Checkboxes',
                icon: Icons.check_box_outlined,
              ),
              _buildNavItem(
                context,
                id: 'icon_buttons',
                title: 'Icon Buttons',
                icon: Icons.info_outline_rounded,
              ),
              _buildNavItem(
                context,
                id: 'radio_buttons',
                title: 'Radio Buttons',
                icon: Icons.radio_button_checked_rounded,
              ),
              _buildNavItem(
                context,
                id: 'snackbars',
                title: 'Snackbars',
                icon: Icons.chat_bubble_outline,
              ),
            ],
          ),
        ),

        const Divider(height: 1),

        // Footer: Theme Mode Selection
        Padding(
          padding: const EdgeInsets.all(16),
          child: ThemeModeMenu(onThemeModeChanged: onThemeModeChanged),
        ),
      ],
    );
  }

  Widget _buildCategoryHeader(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 4, bottom: 6),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required String id,
    required String title,
    required IconData icon,
    bool isComingSoon = false,
  }) {
    final theme = Theme.of(context);
    final isSelected = selectedSection == id;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        dense: true,
        selected: isSelected,
        selectedTileColor: theme.colorScheme.primary.withValues(alpha: 0.12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        leading: Icon(
          icon,
          color: isSelected
              ? theme.colorScheme.primary
              : (isComingSoon
                    ? theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5)
                    : theme.colorScheme.onSurfaceVariant),
          size: 18,
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isSelected
                      ? theme.colorScheme.primary
                      : (isComingSoon
                            ? theme.colorScheme.onSurfaceVariant.withValues(
                                alpha: 0.6,
                              )
                            : theme.colorScheme.onSurface),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  fontSize: 13,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isComingSoon)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.6,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Soon',
                  style: TextStyle(
                    fontSize: 9,
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
        onTap: () {
          onSectionSelected?.call(id);
        },
      ),
    );
  }
}
