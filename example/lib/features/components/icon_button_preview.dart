import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

/// A polished design-system documentation page demonstrating all variants,
/// shape types, sizes, interactive states, and touch targets of [MechanixIconButton].
class IconButtonPreview extends StatelessWidget {
  const IconButtonPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Page Header
        _buildPageHeader(context),
        const SizedBox(height: 24),

        // 2. Variants & Shape Types
        _buildVariantsAndTypesSection(context),
        const SizedBox(height: 32),

        // 3. Button States (Enabled, Disabled, Custom Severities)
        _buildStatesSection(context),
        const SizedBox(height: 32),

        // 4. Icon Button Sizes Scale
        _buildSizesSection(context),
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
            Icons.info_outline_rounded,
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
                'Icon Buttons',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                'Mechanix Icon Button Variants, Shapes, Sizing Scale (32px to 136px), States & 48px Touch Targets',
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

  // --- SECTION 2: VARIANTS & TYPES ---
  Widget _buildVariantsAndTypesSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final items = [
      _VariantTypeItem(
        title: 'Filled - Square & Rounded',
        description:
            'Primary solid background with square or rounded pill corners',
        variant: IconButtonVariant.filled,
      ),
      _VariantTypeItem(
        title: 'Tonal - Square & Rounded',
        description: 'Secondary background with square or rounded pill corners',
        variant: IconButtonVariant.tonal,
      ),
      _VariantTypeItem(
        title: 'Outline - Square & Rounded',
        description: 'Outlined border with surface variant background',
        variant: IconButtonVariant.outline,
      ),
      _VariantTypeItem(
        title: 'Standard - Square & Rounded',
        description:
            'Transparent background with state layer on hover/press/focus',
        variant: IconButtonVariant.standard,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Variants & Shape Types',
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
          child: Column(
            children: [
              for (int i = 0; i < items.length; i++) ...[
                if (i > 0)
                  Divider(
                    height: 1,
                    color: colorScheme.outlineVariant.withValues(alpha: 0.6),
                  ),
                _buildVariantTypeRow(context, items[i]),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVariantTypeRow(BuildContext context, _VariantTypeItem item) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDesktop = MediaQuery.sizeOf(context).width >= 900;

    final samples = Wrap(
      spacing: 16,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        MechanixIconButton(
          variant: item.variant,
          type: IconButtonType.square,
          icon: Icons.settings_rounded,
          onPressed: () {},
        ),
        MechanixIconButton(
          variant: item.variant,
          type: IconButtonType.rounded,
          icon: Icons.share_rounded,
          onPressed: () {},
        ),
      ],
    );

    if (isDesktop) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            SizedBox(
              width: 240,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            Expanded(child: samples),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.description,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          samples,
        ],
      ),
    );
  }

  // --- SECTION 3: BUTTON STATES ---
  Widget _buildStatesSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Interactive States & Custom Styling',
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Interactive & Disabled States',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 20,
                  runSpacing: 16,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text('Filled', style: theme.textTheme.bodySmall),
                        const SizedBox(height: 6),
                        MechanixIconButton.filled(
                          icon: Icons.check_circle_outline_rounded,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Tonal', style: theme.textTheme.bodySmall),
                        const SizedBox(height: 6),
                        MechanixIconButton.tonal(
                          icon: Icons.edit_rounded,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Outline', style: theme.textTheme.bodySmall),
                        const SizedBox(height: 6),
                        MechanixIconButton.outline(
                          icon: Icons.refresh_rounded,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Standard', style: theme.textTheme.bodySmall),
                        const SizedBox(height: 6),
                        MechanixIconButton.standard(
                          icon: Icons.more_vert_rounded,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Filled Disabled',
                          style: theme.textTheme.bodySmall,
                        ),
                        const SizedBox(height: 6),
                        const MechanixIconButton.filled(
                          icon: Icons.block_rounded,
                          onPressed: null,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Outline Disabled',
                          style: theme.textTheme.bodySmall,
                        ),
                        const SizedBox(height: 6),
                        const MechanixIconButton.outline(
                          icon: Icons.block_rounded,
                          onPressed: null,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Tonal Disabled',
                          style: theme.textTheme.bodySmall,
                        ),
                        const SizedBox(height: 6),
                        const MechanixIconButton.tonal(
                          icon: Icons.block_rounded,
                          onPressed: null,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Standard Disabled',
                          style: theme.textTheme.bodySmall,
                        ),
                        const SizedBox(height: 6),
                        const MechanixIconButton.standard(
                          icon: Icons.block_rounded,
                          onPressed: null,
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
                Text(
                  'Color Overrides & Status Severities',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 16,
                  runSpacing: 12,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    MechanixIconButton(
                      icon: Icons.delete_forever_rounded,
                      backgroundColor: colorScheme.error,
                      foregroundColor: colorScheme.onError,
                      onPressed: () {},
                    ),
                    MechanixIconButton(
                      icon: Icons.check_rounded,
                      backgroundColor: const Color(0xFF2E7D32),
                      foregroundColor: Colors.white,
                      onPressed: () {},
                    ),
                    MechanixIconButton.outline(
                      icon: Icons.warning_amber_rounded,
                      borderColor: const Color(0xFFED6C02),
                      foregroundColor: const Color(0xFFED6C02),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- SECTION 4: BUTTON SIZES ---
  Widget _buildSizesSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final sizes = [
      _SizeItem(
        size: IconButtonSize.xSmall,
        name: 'Extra Small (xSmall)',
        codeName: 'xSmall',
      ),
      _SizeItem(
        size: IconButtonSize.small,
        name: 'Small (small)',
        codeName: 'small',
      ),
      _SizeItem(
        size: IconButtonSize.medium,
        name: 'Medium (medium)',
        codeName: 'medium',
      ),
      _SizeItem(
        size: IconButtonSize.large,
        name: 'Large (large)',
        codeName: 'large',
      ),
      _SizeItem(
        size: IconButtonSize.xLarge,
        name: 'Extra Large (xLarge)',
        codeName: 'xLarge',
      ),
      _SizeItem(
        size: IconButtonSize.xxLarge,
        name: '2X Large (xxLarge)',
        codeName: 'xxLarge',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Icon Button Scale & Sizes (xSmall to 2xl)',
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
          child: Column(
            children: [
              for (int i = 0; i < sizes.length; i++) ...[
                if (i > 0)
                  Divider(
                    height: 1,
                    color: colorScheme.outlineVariant.withValues(alpha: 0.6),
                  ),
                _buildSizeRow(context, sizes[i]),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSizeRow(BuildContext context, _SizeItem item) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final spec = item.size.spec(context);
    final isDesktop = MediaQuery.sizeOf(context).width >= 900;

    final metadataContent = [
      _buildMetaRow(
        'Dimension',
        '${spec.dimension.toStringAsFixed(0)}x${spec.dimension.toStringAsFixed(0)}px',
        colorScheme,
      ),
      const SizedBox(height: 2),
      _buildMetaRow('Icon Size', '${spec.iconSize}px', colorScheme),
      const SizedBox(height: 2),
      _buildMetaRow(
        'Tap Target',
        spec.minTapTargetSize > 0
            ? '${spec.minTapTargetSize.toStringAsFixed(0)}x${spec.minTapTargetSize.toStringAsFixed(0)}px'
            : 'Standard',
        colorScheme,
      ),
    ];

    final buttonSamples = Wrap(
      spacing: 16,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        MechanixIconButton(
          size: item.size,
          icon: Icons.rocket_launch_rounded,
          onPressed: () {},
        ),
        MechanixIconButton.tonal(
          size: item.size,
          icon: Icons.rocket_launch_rounded,
          onPressed: () {},
        ),
        MechanixIconButton.outline(
          size: item.size,
          icon: Icons.rocket_launch_rounded,
          onPressed: () {},
        ),
        MechanixIconButton.standard(
          size: item.size,
          icon: Icons.rocket_launch_rounded,
          onPressed: () {},
        ),
      ],
    );

    if (isDesktop) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.codeName,
                    style: TextStyle(
                      fontSize: 10,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: metadataContent,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(child: buttonSamples),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.name,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            item.codeName,
            style: TextStyle(
              fontSize: 11,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          buttonSamples,
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: colorScheme.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
            child: Column(children: metadataContent),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaRow(String label, String value, ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 11, color: colorScheme.onSurfaceVariant),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

class _VariantTypeItem {
  final String title;
  final String description;
  final IconButtonVariant variant;

  const _VariantTypeItem({
    required this.title,
    required this.description,
    required this.variant,
  });
}

class _SizeItem {
  final IconButtonSize size;
  final String name;
  final String codeName;

  const _SizeItem({
    required this.size,
    required this.name,
    required this.codeName,
  });
}
