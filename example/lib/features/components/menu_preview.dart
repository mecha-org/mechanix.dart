import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

/// Catalog demonstration for [MechanixMenu] and [MechanixDropdownMenu],
/// replicating the design system specifications from the Menus reference.
class MenuPreview extends StatelessWidget {
  const MenuPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PageHeader(),
          SizedBox(height: 32),
          _ExamplesAndUsageSection(),
          SizedBox(height: 32),
          _BasicVariantsSection(),
          SizedBox(height: 32),
          _BuildingBlocksSection(),
          SizedBox(height: 48),
        ],
      ),
    );
  }
}

class _PageHeader extends StatelessWidget {
  const _PageHeader();

  @override
  Widget build(BuildContext context) {
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
            Icons.menu_open_rounded,
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
                'Menus',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Text(
                'Menus display a list of choices on a temporary surface. They appear '
                'when users interact with a button, action, or other control.\n'
                'For Android the target minimum is always 48dp minimum.',
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
}

/// SECTION 1: Examples & Usage
/// Demonstrates the 4 anchor types shown in the visual reference.
class _ExamplesAndUsageSection extends StatefulWidget {
  const _ExamplesAndUsageSection();

  @override
  State<_ExamplesAndUsageSection> createState() =>
      _ExamplesAndUsageSectionState();
}

class _ExamplesAndUsageSectionState extends State<_ExamplesAndUsageSection> {
  String? _dropdownVal1 = 'Label 3';
  String? _dropdownVal2 = 'Label 3';
  String? _chipVal;
  String? _iconBtnVal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return _SectionCard(
      title: 'Examples & Usage',
      subtitle: 'Supports various anchor styles: Text-field dropdowns, pill chips, and icon buttons.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 700;
          return Wrap(
            spacing: 32,
            runSpacing: 24,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              // Anchor 1: Text-field dropdown
              SizedBox(
                width: isNarrow ? double.infinity : 220,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Text-Field Dropdown',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    MechanixDropdownMenu<String>(
                      labelText: 'LABEL',
                      hintText: 'Input',
                      selectedValue: _dropdownVal1,
                      onSelected: (val) => setState(() => _dropdownVal1 = val),
                      entries: const [
                        MechanixMenuItem(value: 'Label 1', labelText: 'Label'),
                        MechanixMenuItem(value: 'Label 2', labelText: 'Label'),
                        MechanixMenuItem(
                          value: 'Label 3',
                          labelText: 'Label',
                          leadingIcon: Icons.wifi_rounded,
                        ),
                        MechanixMenuItem(value: 'Label 4', labelText: 'Label'),
                        MechanixMenuItem(value: 'Label 5', labelText: 'Label'),
                      ],
                    ),
                  ],
                ),
              ),

              // Anchor 2: Search Dropdown
              SizedBox(
                width: isNarrow ? double.infinity : 220,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Search Dropdown',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    MechanixDropdownMenu<String>(
                      labelText: 'LABEL',
                      hintText: 'Input',
                      leadingIcon: Icons.search_rounded,
                      selectedValue: _dropdownVal2,
                      onSelected: (val) => setState(() => _dropdownVal2 = val),
                      entries: const [
                        MechanixMenuItem(
                          value: 'Label 1',
                          labelText: 'Label',
                          leadingIcon: Icons.history_rounded,
                        ),
                        MechanixMenuItem(
                          value: 'Label 2',
                          labelText: 'Label',
                          leadingIcon: Icons.history_rounded,
                        ),
                        MechanixMenuItem(
                          value: 'Label 3',
                          labelText: 'Label',
                          leadingIcon: Icons.history_rounded,
                        ),
                        MechanixMenuItem(
                          value: 'Label 4',
                          labelText: 'Label',
                          leadingIcon: Icons.history_rounded,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Anchor 3: Chip / Pill Anchor
              SizedBox(
                width: isNarrow ? double.infinity : 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chip / Pill Anchor',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    MechanixMenu<String>(
                      onSelected: (val) => setState(() => _chipVal = val),
                      anchorBuilder: (context, controller, _) {
                        return InkWell(
                          onTap: controller.toggle,
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.history_rounded,
                                  size: 18,
                                  color: colorScheme.onSurface,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _chipVal ?? 'Label',
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      entries: const [
                        MechanixMenuItem(
                          value: 'Opt 1',
                          labelText: 'Label',
                          leadingIcon: Icons.history_rounded,
                          trailingIcon: Icons.chat_bubble_outline_rounded,
                        ),
                        MechanixMenuItem(
                          value: 'Opt 2',
                          labelText: 'Label',
                          leadingIcon: Icons.history_rounded,
                          trailingIcon: Icons.chat_bubble_outline_rounded,
                        ),
                        MechanixMenuItem(
                          value: 'Opt 3',
                          labelText: 'Label',
                          leadingIcon: Icons.history_rounded,
                          trailingIcon: Icons.chat_bubble_outline_rounded,
                        ),
                        MechanixMenuItem(
                          value: 'Opt 4',
                          labelText: 'Label',
                          leadingIcon: Icons.history_rounded,
                          trailingIcon: Icons.chat_bubble_outline_rounded,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Anchor 4: Accent Icon Button Anchor
              SizedBox(
                width: isNarrow ? double.infinity : 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _iconBtnVal != null
                          ? 'Selected: $_iconBtnVal'
                          : 'Icon-Button Anchor',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    MechanixMenu<String>(
                      size: MechanixMenuSize.small,
                      onSelected: (val) => setState(() => _iconBtnVal = val),
                      anchorBuilder: (context, controller, _) {
                        return MechanixIconButton.filled(
                          type: IconButtonType.rounded,
                          icon: Icons.history_rounded,
                          onPressed: controller.toggle,
                        );
                      },
                      entries: const [
                        MechanixMenuGroup(
                          entries: [
                            MechanixMenuItem(
                              value: 'Act 1',
                              labelText: 'Label',
                              trailingIcon: Icons.chat_bubble_outline_rounded,
                            ),
                            MechanixMenuItem(
                              value: 'Act 2',
                              labelText: 'Label',
                              trailingIcon: Icons.wifi_rounded,
                            ),
                            MechanixMenuItem(
                              value: 'Act 3',
                              labelText: 'Label',
                              trailingIcon: Icons.chat_bubble_outline_rounded,
                            ),
                          ],
                        ),
                        MechanixMenuGroup(
                          showDivider: true,
                          entries: [
                            MechanixMenuItem(
                              value: 'Act 4',
                              labelText: 'Label',
                              trailingIcon: Icons.chat_bubble_outline_rounded,
                            ),
                            MechanixMenuItem(
                              value: 'Act 5',
                              labelText: 'Label',
                              trailingIcon: Icons.chat_bubble_outline_rounded,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// SECTION 2: Basic Variants
/// Shows Regular and Small menu panels across 1, 2, and 3 groups.
class _BasicVariantsSection extends StatelessWidget {
  const _BasicVariantsSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return _SectionCard(
      title: 'Basic Variants',
      subtitle: 'Regular and Small scale variants supporting 1, 2, and 3 groups with subtle container shades.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'REGULAR SIZE (44dp)',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              const Spacer(),
              Text(
                'SMALL SIZE (36dp / 48dp on Touch)',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Regular - 1 Group
                _buildStaticMenuPanel(
                  context,
                  size: MechanixMenuSize.regular,
                  entries: _generateEntries(count: 6),
                ),
                const SizedBox(width: 16),

                // Regular - 2 Groups
                _buildStaticMenuPanel(
                  context,
                  size: MechanixMenuSize.regular,
                  entries: [
                    MechanixMenuGroup(entries: _generateEntries(count: 6)),
                    MechanixMenuGroup(
                      showDivider: true,
                      entries: _generateEntries(count: 2),
                    ),
                  ],
                ),
                const SizedBox(width: 16),

                // Regular - 3 Groups
                _buildStaticMenuPanel(
                  context,
                  size: MechanixMenuSize.regular,
                  entries: [
                    MechanixMenuGroup(entries: _generateEntries(count: 6)),
                    MechanixMenuGroup(
                      showDivider: true,
                      entries: _generateEntries(count: 3),
                    ),
                    MechanixMenuGroup(
                      showDivider: true,
                      entries: _generateEntries(count: 3),
                    ),
                  ],
                ),
                const SizedBox(width: 32),

                // Small - 1 Group
                _buildStaticMenuPanel(
                  context,
                  size: MechanixMenuSize.small,
                  entries: _generateEntries(count: 6),
                ),
                const SizedBox(width: 16),

                // Small - 2 Groups
                _buildStaticMenuPanel(
                  context,
                  size: MechanixMenuSize.small,
                  entries: [
                    MechanixMenuGroup(entries: _generateEntries(count: 6)),
                    MechanixMenuGroup(
                      showDivider: true,
                      entries: _generateEntries(count: 3),
                    ),
                  ],
                ),
                const SizedBox(width: 16),

                // Small - 3 Groups
                _buildStaticMenuPanel(
                  context,
                  size: MechanixMenuSize.small,
                  entries: [
                    MechanixMenuGroup(entries: _generateEntries(count: 6)),
                    MechanixMenuGroup(
                      showDivider: true,
                      entries: _generateEntries(count: 3),
                    ),
                    MechanixMenuGroup(
                      showDivider: true,
                      entries: _generateEntries(count: 3),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static List<MechanixMenuEntry<int>> _generateEntries({required int count}) {
    return List.generate(
      count,
      (i) => MechanixMenuItem<int>(
        value: i,
        labelText: 'Label',
        leadingIcon: Icons.history_rounded,
        trailingIcon: Icons.chat_bubble_outline_rounded,
      ),
    );
  }

  Widget _buildStaticMenuPanel(
    BuildContext context, {
    required MechanixMenuSize size,
    required List<MechanixMenuEntry<int>> entries,
  }) {
    final theme = MechanixMenuTheme.of(context);
    return Container(
      width: 180,
      decoration: BoxDecoration(
        color:
            theme.surfaceColor ??
            Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(8),
      ),
      child: MechanixMenu<int>(
        size: size,
        anchorBuilder: (context, controller, _) {
          return InkWell(
            onTap: controller.toggle,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Preview Menu',
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_drop_down, size: 18),
                ],
              ),
            ),
          );
        },
        entries: entries,
      ),
    );
  }
}

/// SECTION 3: Building Blocks
/// Shows all states (Enabled, Hovered, Focused, Pressed, Selected, Disabled)
/// and anatomy slots (leading, trailing, badges, shortcuts, label-only).
class _BuildingBlocksSection extends StatelessWidget {
  const _BuildingBlocksSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return _SectionCard(
      title: 'Building Blocks',
      subtitle: 'Item states and anatomy slots: leading icons, badges, shortcut text, and custom widgets.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // States demonstration cards
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 650;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildStatesCard(
                      context,
                      title: 'Standard Item States',
                      items: [
                        _buildStateItem(
                          context,
                          'Enabled (Default)',
                          false,
                          false,
                        ),
                        _buildStateItem(context, 'Hovered', true, false),
                        _buildStateItem(context, 'Selected', false, true),
                        _buildStateItem(
                          context,
                          'Disabled',
                          false,
                          false,
                          enabled: false,
                        ),
                      ],
                    ),
                  ),
                  if (isWide) const SizedBox(width: 24),
                  if (isWide)
                    Expanded(
                      child: _buildStatesCard(
                        context,
                        title: 'Slots & Anatomy',
                        items: [
                          _buildSlotItem(
                            context,
                            label: 'Shortcut Key',
                            trailingText: '⌘C',
                          ),
                          _buildSlotItem(
                            context,
                            label: 'Feature Item',
                            badge: const MechanixBadge(
                              label: Text('New'),
                              variant: MechanixBadgeVariant.error,
                            ),
                          ),
                          _buildSlotItem(
                            context,
                            label: 'Supporting Text',
                            supportingText: 'Additional description',
                          ),
                          _buildSlotItem(context, label: 'Label Only Item'),
                        ],
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),

          // Slots Anatomy Bar
          Text(
            'SLOT ANATOMY',
            style: theme.textTheme.labelSmall?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Wrap(
              spacing: 24,
              runSpacing: 16,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                // Leading Slot
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.history_rounded, size: 20),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'slot',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                // Trailing Slot
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Label', style: theme.textTheme.bodyMedium),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'slot',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                // Full Anatomy
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.history_rounded, size: 20),
                    const SizedBox(width: 6),
                    const Icon(Icons.chat_bubble_outline_rounded, size: 18),
                    const SizedBox(width: 8),
                    Text('Label', style: theme.textTheme.bodyMedium),
                    const SizedBox(width: 8),
                    const MechanixBadge(
                      label: Text('New'),
                      variant: MechanixBadgeVariant.error,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '⌘C',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),

                // Label Only
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text('Label', style: theme.textTheme.bodyMedium),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatesCard(
    BuildContext context, {
    required String title,
    required List<Widget> items,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          ...items,
        ],
      ),
    );
  }

  Widget _buildStateItem(
    BuildContext context,
    String label,
    bool isHovered,
    bool isSelected, {
    bool enabled = true,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final bg = isSelected
        ? colorScheme.onSurface.withValues(alpha: 0.12)
        : isHovered
        ? colorScheme.onSurface.withValues(alpha: 0.08)
        : Colors.transparent;

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Icon(
            Icons.history_rounded,
            size: 20,
            color: enabled
                ? colorScheme.onSurface
                : colorScheme.onSurface.withValues(alpha: 0.38),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: enabled
                    ? colorScheme.onSurface
                    : colorScheme.onSurface.withValues(alpha: 0.38),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.chat_bubble_outline_rounded,
            size: 18,
            color: enabled
                ? colorScheme.onSurfaceVariant
                : colorScheme.onSurface.withValues(alpha: 0.38),
          ),
        ],
      ),
    );
  }

  Widget _buildSlotItem(
    BuildContext context, {
    required String label,
    String? trailingText,
    Widget? badge,
    String? supportingText,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Icon(Icons.history_rounded, size: 20, color: colorScheme.onSurface),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: TextStyle(color: colorScheme.onSurface),
                  overflow: TextOverflow.ellipsis,
                ),
                if (supportingText != null)
                  Text(
                    supportingText,
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: colorScheme.onSurfaceVariant),
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ?badge,
          if (trailingText != null) ...[
            const SizedBox(width: 8),
            Text(
              trailingText,
              style: Theme.of(context).textTheme.labelSmall
                  ?.copyWith(color: colorScheme.onSurfaceVariant),
            ),
          ],
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}
