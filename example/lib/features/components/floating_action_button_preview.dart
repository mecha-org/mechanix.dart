import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

/// Design system catalog page demonstrating all variants, sizes, interactive states,
/// focus indicators, and theme customizations of [MechanixFloatingActionButton].
class FloatingActionButtonPreview extends StatefulWidget {
  const FloatingActionButtonPreview({super.key});

  @override
  State<FloatingActionButtonPreview> createState() =>
      _FloatingActionButtonPreviewState();
}

class _FloatingActionButtonPreviewState
    extends State<FloatingActionButtonPreview> {
  // Playground state
  MechanixFloatingActionButtonSize _selectedSize =
      MechanixFloatingActionButtonSize.small;
  bool _isEnabled = true;
  IconData _selectedIcon = Icons.add_rounded;
  int _clickCount = 0;

  final List<IconData> _availableIcons = [
    Icons.add_rounded,
    Icons.edit_rounded,
    Icons.navigation_rounded,
    Icons.favorite_rounded,
    Icons.share_rounded,
    Icons.mic_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Page Header
        _buildPageHeader(context),
        const SizedBox(height: 24),

        // 2. Interactive Playground
        _buildPlaygroundSection(context),
        const SizedBox(height: 32),

        // 3. Sizing Scale (Small, Medium, Large)
        _buildSizesSection(context),
        const SizedBox(height: 32),

        // 4. Interactive States (Enabled, Hovered, Focused, Pressed, Disabled)
        _buildStatesSection(context),
        const SizedBox(height: 32),

        // 5. Theme & Customization Overrides
        _buildCustomThemeSection(context),
        const SizedBox(height: 32),

        // 6. Token & Specification Reference Table
        _buildSpecificationSection(context),
      ],
    );
  }

  // --- 1. PAGE HEADER ---
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
            Icons.add_circle_outline_rounded,
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
                'Floating Action Button (FAB)',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                'Material 3 Floating Action Button featuring Secondary Container styling, Small (56px), Medium (80px), and Large (96px) sizes, non-shifting 3px focus ring, and full accessibility.',
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

  // --- 2. INTERACTIVE PLAYGROUND ---
  Widget _buildPlaygroundSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Interactive Playground',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 0,
          color: colorScheme.surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: colorScheme.outlineVariant),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Controls Row
                Wrap(
                  spacing: 24,
                  runSpacing: 16,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    // Size Selector
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Size',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        SegmentedButton<MechanixFloatingActionButtonSize>(
                          segments: const [
                            ButtonSegment(
                              value: MechanixFloatingActionButtonSize.small,
                              label: Text('Small (56px)'),
                            ),
                            ButtonSegment(
                              value: MechanixFloatingActionButtonSize.medium,
                              label: Text('Medium (80px)'),
                            ),
                            ButtonSegment(
                              value: MechanixFloatingActionButtonSize.large,
                              label: Text('Large (96px)'),
                            ),
                          ],
                          selected: {_selectedSize},
                          onSelectionChanged: (set) {
                            setState(() => _selectedSize = set.first);
                          },
                        ),
                      ],
                    ),

                    // State Switch
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'State',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Switch(
                              value: _isEnabled,
                              onChanged: (val) =>
                                  setState(() => _isEnabled = val),
                            ),
                            const SizedBox(width: 8),
                            Text(_isEnabled ? 'Enabled' : 'Disabled'),
                          ],
                        ),
                      ],
                    ),

                    // Icon Picker
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Icon',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: _availableIcons.map((icon) {
                            final isSelected = icon == _selectedIcon;
                            return Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: InkWell(
                                onTap: () =>
                                    setState(() => _selectedIcon = icon),
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? colorScheme.primaryContainer
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: isSelected
                                          ? colorScheme.primary
                                          : colorScheme.outlineVariant,
                                    ),
                                  ),
                                  child: Icon(
                                    icon,
                                    size: 20,
                                    color: isSelected
                                        ? colorScheme.onPrimaryContainer
                                        : colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Divider(
                  height: 1,
                  color: colorScheme.outlineVariant.withValues(alpha: 0.6),
                ),
                const SizedBox(height: 24),

                // Preview Output
                Center(
                  child: Column(
                    children: [
                      MechanixFloatingActionButton(
                        size: _selectedSize,
                        icon: Icon(_selectedIcon),
                        tooltip: 'Interactive FAB ($_clickCount clicks)',
                        onPressed: _isEnabled
                            ? () {
                                setState(() => _clickCount++);
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'FAB clicked! Total clicks: $_clickCount',
                                    ),
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              }
                            : null,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Clicks: $_clickCount • Press Tab to focus, Space/Enter to activate',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- 3. SIZES SCALE ---
  Widget _buildSizesSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sizes Scale',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Three standard Material 3 FAB sizes with proportional icon scaling and fully rounded corners.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 0,
          color: colorScheme.surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: colorScheme.outlineVariant),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildSizeItem(
                  context,
                  title: 'Small',
                  badge: '56 x 56 px',
                  iconBadge: '24px icon',
                  fab: MechanixFloatingActionButton(
                    icon: const Icon(Icons.add_rounded),
                    tooltip: 'Small FAB (56px)',
                    onPressed: () {},
                  ),
                ),
                _buildSizeItem(
                  context,
                  title: 'Medium',
                  badge: '80 x 80 px',
                  iconBadge: '32px icon',
                  fab: MechanixFloatingActionButton.medium(
                    icon: const Icon(Icons.add_rounded),
                    tooltip: 'Medium FAB (80px)',
                    onPressed: () {},
                  ),
                ),
                _buildSizeItem(
                  context,
                  title: 'Large',
                  badge: '96 x 96 px',
                  iconBadge: '36px icon',
                  fab: MechanixFloatingActionButton.large(
                    icon: const Icon(Icons.add_rounded),
                    tooltip: 'Large FAB (96px)',
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSizeItem(
    BuildContext context, {
    required String title,
    required String badge,
    required String iconBadge,
    required Widget fab,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        fab,
        const SizedBox(height: 16),
        Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            badge,
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          iconBadge,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  // --- 4. INTERACTIVE STATES ---
  Widget _buildStatesSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Interactive States',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'State layers overlay the secondaryContainer base with smooth 200ms cubic animations.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 0,
          color: colorScheme.surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: colorScheme.outlineVariant),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Wrap(
              spacing: 32,
              runSpacing: 24,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceAround,
              children: [
                _buildStateCard(
                  context,
                  title: 'Enabled',
                  subtitle: 'Default rest state',
                  fab: MechanixFloatingActionButton(
                    icon: const Icon(Icons.edit_rounded),
                    tooltip: 'Enabled FAB',
                    onPressed: () {},
                  ),
                ),
                _buildStateCard(
                  context,
                  title: 'Hovered',
                  subtitle: '8% state layer (hover over me)',
                  fab: MechanixFloatingActionButton(
                    icon: const Icon(Icons.brush_rounded),
                    tooltip: 'Hover me',
                    onPressed: () {},
                  ),
                ),
                _buildStateCard(
                  context,
                  title: 'Pressed',
                  subtitle: '12% state layer (press & hold)',
                  fab: MechanixFloatingActionButton(
                    icon: const Icon(Icons.touch_app_rounded),
                    tooltip: 'Press and hold me',
                    onPressed: () {},
                  ),
                ),
                _buildStateCard(
                  context,
                  title: 'Focused',
                  subtitle: '3px solid outline focus ring',
                  fab: MechanixFloatingActionButton(
                    icon: const Icon(Icons.center_focus_strong_rounded),
                    tooltip: 'Focused FAB',
                    autofocus: true,
                    onPressed: () {},
                  ),
                ),
                _buildStateCard(
                  context,
                  title: 'Disabled',
                  subtitle: '12% container, 38% content',
                  fab: const MechanixFloatingActionButton(
                    icon: Icon(Icons.block_rounded),
                    tooltip: 'Disabled FAB',
                    onPressed: null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStateCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required Widget fab,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: 170,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          fab,
          const SizedBox(height: 12),
          Text(
            title,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  // --- 5. THEME & CUSTOMIZATION ---
  Widget _buildCustomThemeSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Theme Overrides & Brand Colors',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Scoped MechanixFloatingActionButtonTheme and direct property overrides for primary, tertiary, or error intents.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 0,
          color: colorScheme.surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: colorScheme.outlineVariant),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Wrap(
              spacing: 32,
              runSpacing: 24,
              alignment: WrapAlignment.spaceAround,
              children: [
                // Primary Accent FAB
                _buildStateCard(
                  context,
                  title: 'Primary Color',
                  subtitle: 'Custom color properties',
                  fab: MechanixFloatingActionButton(
                    icon: const Icon(Icons.send_rounded),
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    tooltip: 'Primary FAB',
                    onPressed: () {},
                  ),
                ),

                // Error / Delete FAB
                _buildStateCard(
                  context,
                  title: 'Error Container',
                  subtitle: 'Semantic warning/delete action',
                  fab: MechanixFloatingActionButton(
                    icon: const Icon(Icons.delete_outline_rounded),
                    backgroundColor: colorScheme.errorContainer,
                    foregroundColor: colorScheme.onErrorContainer,
                    tooltip: 'Delete Action',
                    onPressed: () {},
                  ),
                ),

                // Theme-Wrapped FAB
                _buildStateCard(
                  context,
                  title: 'Theme-Scoped',
                  subtitle: 'Via MechanixFloatingActionButtonTheme',
                  fab: MechanixFloatingActionButtonTheme(
                    data: FloatingActionButtonThemeDataConfig(
                      backgroundColor: WidgetStatePropertyAll(
                        colorScheme.tertiaryContainer,
                      ),
                      foregroundColor: WidgetStatePropertyAll(
                        colorScheme.onTertiaryContainer,
                      ),
                      focusBorderColor: colorScheme.tertiary,
                      focusBorderWidth: 4.0,
                    ),
                    child: MechanixFloatingActionButton(
                      icon: const Icon(Icons.star_rounded),
                      tooltip: 'Tertiary Theme FAB',
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- 6. SPECIFICATION TABLE ---
  Widget _buildSpecificationSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Design Token & Architecture Specifications',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 0,
          color: colorScheme.surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: colorScheme.outlineVariant),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(1.2),
                1: FlexColumnWidth(1.5),
                2: FlexColumnWidth(2.5),
              },
              children: [
                _buildTableRow(context, [
                  'Property / Token',
                  'Value',
                  'Description',
                ], isHeader: true),
                _buildTableRow(context, [
                  'Small FAB',
                  '56 x 56 px • 24px icon',
                  'Compact action button for standard views',
                ]),
                _buildTableRow(context, [
                  'Medium FAB',
                  '80 x 80 px • 32px icon',
                  'Prominent hero action button for touch-first screens',
                ]),
                _buildTableRow(context, [
                  'Large FAB',
                  '96 x 96 px • 36px icon',
                  'Expansive action button for large display panels',
                ]),
                _buildTableRow(context, [
                  'Container Color',
                  'secondaryContainer',
                  'Secondary container token from color scheme',
                ]),
                _buildTableRow(context, [
                  'Content Color',
                  'primary',
                  'Primary brand icon foreground color',
                ]),
                _buildTableRow(context, [
                  'Corner Radius',
                  'Full (shapeTheme.full)',
                  'Fully rounded pill perimeter across all sizes',
                ]),
                _buildTableRow(context, [
                  'Focus Ring',
                  '3px solid outline',
                  'Drawn outside perimeter with 0px layout box expansion',
                ]),
                _buildTableRow(context, [
                  'Animation Duration',
                  '200ms cubic(0.2, 0, 0, 1)',
                  'Material 3 emphasized easing curve for state transitions',
                ]),
              ],
            ),
          ),
        ),
      ],
    );
  }

  TableRow _buildTableRow(
    BuildContext context,
    List<String> cells, {
    bool isHeader = false,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return TableRow(
      decoration: isHeader
          ? BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: colorScheme.outlineVariant,
                  width: 1.5,
                ),
              ),
            )
          : BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
            ),
      children: cells.map((cell) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Text(
            cell,
            style: isHeader
                ? theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  )
                : theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
          ),
        );
      }).toList(),
    );
  }
}
