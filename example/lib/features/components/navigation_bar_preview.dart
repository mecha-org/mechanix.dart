import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

/// Design system catalog page demonstrating all states, options, and layouts
/// of [MechanixNavigationBar].
class NavigationBarPreview extends StatefulWidget {
  const NavigationBarPreview({super.key});

  @override
  State<NavigationBarPreview> createState() => _NavigationBarPreviewState();
}

class _NavigationBarPreviewState extends State<NavigationBarPreview> {
  int _interactiveIndex = 0;
  int _row1Index = 0;
  int _row2Index = 0;
  int _row3Index = 0;
  int _behaviorIndex = 0;
  NavigationDestinationLabelBehavior _labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Page Header
        _buildPageHeader(context),
        const SizedBox(height: 24),

        // 2. Navigation Bar Variants (3, 4, 5 items) - Matches Design Spec Screenshot
        _buildVariantsSection(context),
        const SizedBox(height: 32),

        // 3. Interactive Navigation Bar
        _buildInteractiveSection(context),
        const SizedBox(height: 32),

        // 4. States Matrix (Selected, Hovered, Focused, Pressed, Unselected, Disabled)
        _buildStatesMatrixSection(context),
        const SizedBox(height: 32),

        // 5. Label Behaviors
        _buildLabelBehaviorsSection(context),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildPageHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.navigation_outlined,
            size: 28,
            color: colorScheme.primary,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Navigation Bar',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                'Mechanix Navigation Bar with 80px Height, 1px onSecondaryFixed Top Border, and Whole-Item Hover & Selection Highlight',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- SECTION 2: VARIANTS (3, 4, 5 ITEMS - EXACT FIGMA SPEC) ---
  Widget _buildVariantsSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Destination Variants (3, 4, 5 Items)',
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Text(
          'Hover and selected highlight with top border applied to the whole nav item containing icon and label.',
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 3 Destinations
              Text(
                '3 Items Layout',
                style: textTheme.labelMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: MechanixNavigationBar(
                  selectedIndex: _row1Index,
                  onDestinationSelected: (idx) =>
                      setState(() => _row1Index = idx),
                  destinations: const [
                    MechanixNavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    MechanixNavigationDestination(
                      icon: Icon(Icons.search_outlined),
                      selectedIcon: Icon(Icons.search),
                      label: 'Search',
                    ),
                    MechanixNavigationDestination(
                      icon: Icon(Icons.person_outline),
                      selectedIcon: Icon(Icons.person),
                      label: 'Profile',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 4 Destinations
              Text(
                '4 Items Layout',
                style: textTheme.labelMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: MechanixNavigationBar(
                  selectedIndex: _row2Index,
                  onDestinationSelected: (idx) =>
                      setState(() => _row2Index = idx),
                  destinations: const [
                    MechanixNavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    MechanixNavigationDestination(
                      icon: Icon(Icons.explore_outlined),
                      selectedIcon: Icon(Icons.explore),
                      label: 'Explore',
                    ),
                    MechanixNavigationDestination(
                      icon: Icon(Icons.notifications_none),
                      selectedIcon: Icon(Icons.notifications),
                      label: 'Alerts',
                    ),
                    MechanixNavigationDestination(
                      icon: Icon(Icons.person_outline),
                      selectedIcon: Icon(Icons.person),
                      label: 'Profile',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 5 Destinations
              Text(
                '5 Items Layout',
                style: textTheme.labelMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: MechanixNavigationBar(
                  selectedIndex: _row3Index,
                  onDestinationSelected: (idx) =>
                      setState(() => _row3Index = idx),
                  destinations: const [
                    MechanixNavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    MechanixNavigationDestination(
                      icon: Icon(Icons.search_outlined),
                      selectedIcon: Icon(Icons.search),
                      label: 'Search',
                    ),
                    MechanixNavigationDestination(
                      icon: Icon(Icons.favorite_border),
                      selectedIcon: Icon(Icons.favorite),
                      label: 'Favorites',
                    ),
                    MechanixNavigationDestination(
                      icon: Icon(Icons.notifications_none),
                      selectedIcon: Icon(Icons.notifications),
                      label: 'Alerts',
                    ),
                    MechanixNavigationDestination(
                      icon: Icon(Icons.settings_outlined),
                      selectedIcon: Icon(Icons.settings),
                      label: 'Settings',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- SECTION 3: INTERACTIVE DEMO ---
  Widget _buildInteractiveSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final tabNames = ['Dashboard', 'Search', 'Notifications', 'Settings'];

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  'Interactive Preview',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Active: ${tabNames[_interactiveIndex]} (Index $_interactiveIndex)',
                    style: textTheme.labelSmall?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 120,
            alignment: Alignment.center,
            color: colorScheme.surface,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _interactiveIndex == 0
                      ? Icons.dashboard
                      : _interactiveIndex == 1
                      ? Icons.search
                      : _interactiveIndex == 2
                      ? Icons.notifications
                      : Icons.settings,
                  size: 40,
                  color: colorScheme.primary,
                ),
                const SizedBox(height: 8),
                Text(
                  'Current View: ${tabNames[_interactiveIndex]}',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          MechanixNavigationBar(
            selectedIndex: _interactiveIndex,
            onDestinationSelected: (idx) {
              setState(() {
                _interactiveIndex = idx;
              });
            },
            destinations: const [
              MechanixNavigationDestination(
                icon: Icon(Icons.dashboard_outlined),
                selectedIcon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              MechanixNavigationDestination(
                icon: Icon(Icons.search_outlined),
                selectedIcon: Icon(Icons.search),
                label: 'Search',
              ),
              MechanixNavigationDestination(
                icon: Icon(Icons.notifications_outlined),
                selectedIcon: Icon(Icons.notifications),
                label: 'Alerts',
                badge: Text('3'),
              ),
              MechanixNavigationDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- SECTION 4: STATES MATRIX ---
  Widget _buildStatesMatrixSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Destination Item States & Token Specs',
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Text(
          'Whole nav item (icon + label) state-specific background and border styling.',
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: Wrap(
            spacing: 24,
            runSpacing: 24,
            children: [
              _buildStateCard(
                context,
                title: 'Selected (Default)',
                description:
                    '10% onSurface bg\n1px onSecondaryFixed top border',
                child: _buildWholeItemMock(
                  context,
                  isSelected: true,
                  icon: Icons.star,
                  bgColor: colorScheme.onSurface.withValues(alpha: 0.10),
                  borderColor: colorScheme.onSecondaryFixed,
                  iconColor: colorScheme.onSurface,
                  label: 'Selected',
                ),
              ),
              _buildStateCard(
                context,
                title: 'Hovered',
                description: '8% onSurface bg\nNo top border',
                child: _buildWholeItemMock(
                  context,
                  isSelected: false,
                  icon: Icons.star_outline,
                  bgColor: colorScheme.onSurface.withValues(alpha: 0.08),
                  borderColor: Colors.transparent,
                  iconColor: colorScheme.onSurfaceVariant,
                  label: 'Hovered',
                ),
              ),
              _buildStateCard(
                context,
                title: 'Focused / Pressed',
                description: 'surfaceContainerLow bg\nNo top border',
                child: _buildWholeItemMock(
                  context,
                  isSelected: false,
                  icon: Icons.star_outline,
                  bgColor: colorScheme.surfaceContainerLow,
                  borderColor: Colors.transparent,
                  iconColor: colorScheme.onSurfaceVariant,
                  label: 'Focused',
                ),
              ),
              _buildStateCard(
                context,
                title: 'Unselected Idle',
                description: 'Transparent bg\nonSurfaceVariant icon',
                child: _buildWholeItemMock(
                  context,
                  isSelected: false,
                  icon: Icons.star_outline,
                  bgColor: Colors.transparent,
                  borderColor: Colors.transparent,
                  iconColor: colorScheme.onSurfaceVariant,
                  label: 'Unselected',
                ),
              ),
              _buildStateCard(
                context,
                title: 'Disabled Destination',
                description: '38% opacity dim\nNon-interactive',
                child: _buildWholeItemMock(
                  context,
                  isSelected: false,
                  icon: Icons.lock_outline,
                  bgColor: Colors.transparent,
                  borderColor: Colors.transparent,
                  iconColor: colorScheme.onSurfaceVariant.withValues(
                    alpha: 0.38,
                  ),
                  labelColor: colorScheme.onSecondaryContainer.withValues(
                    alpha: 0.38,
                  ),
                  label: 'Disabled',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStateCard(
    BuildContext context, {
    required String title,
    required String description,
    required Widget child,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      width: 170,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          child,
          const SizedBox(height: 12),
          Text(
            description,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildWholeItemMock(
    BuildContext context, {
    required bool isSelected,
    required IconData icon,
    required Color bgColor,
    required Color borderColor,
    required Color iconColor,
    Color? labelColor,
    required String label,
  }) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Container(
      width: 120,
      height: 70,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(height: 1.0, color: borderColor),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 24, color: iconColor),
              const SizedBox(height: 4),
              Text(
                label,
                style: textTheme.labelLarge?.copyWith(
                  color: labelColor ?? colorScheme.onSecondaryContainer,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- SECTION 5: LABEL BEHAVIORS ---
  Widget _buildLabelBehaviorsSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Label Behaviors',
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Text(
          'Configurable via labelBehavior: alwaysShow, onlyShowSelected, or alwaysHide.',
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SegmentedButton<NavigationDestinationLabelBehavior>(
                    segments: const [
                      ButtonSegment(
                        value: NavigationDestinationLabelBehavior.alwaysShow,
                        label: Text('alwaysShow'),
                      ),
                      ButtonSegment(
                        value:
                            NavigationDestinationLabelBehavior.onlyShowSelected,
                        label: Text('onlyShowSelected'),
                      ),
                      ButtonSegment(
                        value: NavigationDestinationLabelBehavior.alwaysHide,
                        label: Text('alwaysHide'),
                      ),
                    ],
                    selected: {_labelBehavior},
                    onSelectionChanged: (set) {
                      setState(() {
                        _labelBehavior = set.first;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: MechanixNavigationBar(
                  selectedIndex: _behaviorIndex,
                  labelBehavior: _labelBehavior,
                  onDestinationSelected: (idx) {
                    setState(() {
                      _behaviorIndex = idx;
                    });
                  },
                  destinations: const [
                    MechanixNavigationDestination(
                      icon: Icon(Icons.folder_outlined),
                      selectedIcon: Icon(Icons.folder),
                      label: 'Files',
                    ),
                    MechanixNavigationDestination(
                      icon: Icon(Icons.history_outlined),
                      selectedIcon: Icon(Icons.history),
                      label: 'Recent',
                    ),
                    MechanixNavigationDestination(
                      icon: Icon(Icons.favorite_outline),
                      selectedIcon: Icon(Icons.favorite),
                      label: 'Favorites',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
