import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

/// A polished design-system documentation page demonstrating all types,
/// variants, sizes, states, and layouts of [MechanixButton].
class ButtonPreview extends StatelessWidget {
  const ButtonPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Page Header
        _buildPageHeader(context),
        const SizedBox(height: 24),

        // 2. Button Variants & Shape Types
        _buildVariantsAndTypesSection(context),
        const SizedBox(height: 32),

        // 3. Button States (Enabled, Disabled, Custom Severities)
        _buildStatesSection(context),
        const SizedBox(height: 32),

        // 4. Button Sizes Scale
        _buildSizesSection(context),
        const SizedBox(height: 32),

        // 5. Content Variations
        _buildContentVariationsSection(context),
        const SizedBox(height: 32),

        // 6. Sizing Strategies
        _buildSizingStrategiesSection(context),
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
            Icons.smart_button_outlined,
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
                'Buttons',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                'Mechanix Button Component Variants, Types, Sizes, States & Layouts',
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
        title: 'Filled - Square',
        description: 'Solid background with square corners',
        variant: ButtonVariant.filled,
        type: ButtonType.square,
      ),
      _VariantTypeItem(
        title: 'Filled - Rounded',
        description: 'Solid background with rounded pill corners',
        variant: ButtonVariant.filled,
        type: ButtonType.rounded,
      ),
      _VariantTypeItem(
        title: 'Outline - Square',
        description: 'Outlined border with square corners',
        variant: ButtonVariant.outline,
        type: ButtonType.square,
      ),
      _VariantTypeItem(
        title: 'Outline - Rounded',
        description: 'Outlined border with rounded pill corners',
        variant: ButtonVariant.outline,
        type: ButtonType.rounded,
      ),
      _VariantTypeItem(
        title: 'Text - Square',
        description: 'Transparent background and no border with square corners',
        variant: ButtonVariant.text,
        type: ButtonType.square,
      ),
      _VariantTypeItem(
        title: 'Text - Rounded',
        description:
            'Transparent background and no border with rounded pill corners',
        variant: ButtonVariant.text,
        type: ButtonType.rounded,
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
      spacing: 12,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        MechanixButton(
          variant: item.variant,
          type: item.type,
          icon: Icons.add_rounded,
          label: 'Button',
          onPressed: () {},
        ),
        MechanixButton(
          variant: item.variant,
          type: item.type,
          label: 'Text Only',
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
              width: 220,
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
                // Standard States
                Text(
                  'Interactive & Disabled States',
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enabled',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 6),
                        MechanixButton(
                          icon: Icons.check_circle_outline_rounded,
                          label: 'Enabled',
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Disabled',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const MechanixButton(
                          icon: Icons.block_rounded,
                          label: 'Disabled',
                          onPressed: null,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Outline Disabled',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const MechanixButton.outline(
                          icon: Icons.block_rounded,
                          label: 'Disabled',
                          onPressed: null,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Text Disabled',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const MechanixButton.text(
                          icon: Icons.block_rounded,
                          label: 'Disabled',
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

                // Custom Colors / Severity States
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
                    // Danger / Error
                    MechanixButton(
                      icon: Icons.delete_forever_rounded,
                      label: 'Delete',
                      backgroundColor: colorScheme.error,
                      foregroundColor: colorScheme.onError,
                      onPressed: () {},
                    ),
                    // Custom Accent / Positive
                    MechanixButton(
                      icon: Icons.check_rounded,
                      label: 'Save',
                      backgroundColor: const Color(0xFF2E7D32),
                      foregroundColor: Colors.white,
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
        size: ButtonSize.xSmall,
        name: 'Extra Small',
        codeName: 'extraSmall',
      ),
      _SizeItem(size: ButtonSize.small, name: 'Small', codeName: 'small'),
      _SizeItem(size: ButtonSize.medium, name: 'Medium', codeName: 'medium'),
      _SizeItem(size: ButtonSize.large, name: 'Large', codeName: 'large'),
      _SizeItem(
        size: ButtonSize.xLarge,
        name: 'Extra Large',
        codeName: 'xLarge',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Button Scale & Sizes',
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
        'Height',
        '${spec.height.toStringAsFixed(0)}px',
        colorScheme,
      ),
      const SizedBox(height: 2),
      _buildMetaRow(
        'Icon Size',
        '${spec.iconSize.toStringAsFixed(0)}px',
        colorScheme,
      ),
      const SizedBox(height: 2),
      _buildMetaRow(
        'Gap',
        '${spec.iconLabelGap.toStringAsFixed(0)}px',
        colorScheme,
      ),
    ];

    final buttonSamples = Wrap(
      spacing: 12,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        MechanixButton(
          size: item.size,
          icon: Icons.rocket_launch_rounded,
          label: 'Button',
          onPressed: () {},
        ),
        MechanixButton.outline(
          size: item.size,
          icon: Icons.rocket_launch_rounded,
          label: 'Outline',
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
            // Label & Code Name
            SizedBox(
              width: 140,
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

            // Metadata Column
            SizedBox(
              width: 140,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: metadataContent,
              ),
            ),
            const SizedBox(width: 24),

            // Live Button Preview Samples
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
            style: TextStyle(fontSize: 11, color: colorScheme.onSurfaceVariant),
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

  // --- SECTION 5: CONTENT VARIATIONS ---
  Widget _buildContentVariationsSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Content & Composition Variations',
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
            child: Wrap(
              spacing: 24,
              runSpacing: 20,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                _buildContentSampleBox(
                  context,
                  title: 'Icon + Text Label',
                  button: MechanixButton(
                    icon: Icons.send_rounded,
                    label: 'Send',
                    onPressed: () {},
                  ),
                ),
                _buildContentSampleBox(
                  context,
                  title: 'Text Label Only',
                  button: MechanixButton(label: 'Continue', onPressed: () {}),
                ),
                _buildContentSampleBox(
                  context,
                  title: 'Icon Only',
                  button: MechanixButton(
                    icon: Icons.settings_rounded,
                    onPressed: () {},
                  ),
                ),
                _buildContentSampleBox(
                  context,
                  title: 'Custom Label Widget',
                  button: MechanixButton(
                    icon: Icons.cloud_upload_rounded,
                    labelText: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Upload'),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_upward_rounded, size: 14),
                      ],
                    ),
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

  Widget _buildContentSampleBox(
    BuildContext context, {
    required String title,
    required Widget button,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        button,
      ],
    );
  }

  // --- SECTION 6: SIZING STRATEGIES ---
  Widget _buildSizingStrategiesSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Width Sizing Strategies',
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
                // Hug Content
                Text(
                  'Hug Content (widthSizing: ButtonLayoutSizing.hug)',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                MechanixButton(
                  widthSizing: ButtonLayoutSizing.hug,
                  icon: Icons.fit_screen_rounded,
                  label: 'Hug Content',
                  onPressed: () {},
                ),
                const SizedBox(height: 20),

                // Fixed Width
                Text(
                  'Fixed Width (widthSizing: ButtonLayoutSizing.fixed, width: 180)',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                MechanixButton(
                  widthSizing: ButtonLayoutSizing.fixed,
                  width: 180,
                  icon: Icons.straighten_rounded,
                  label: 'Fixed 180px',
                  onPressed: () {},
                ),
                const SizedBox(height: 20),

                // Fill Available Width
                Text(
                  'Fill Width (widthSizing: ButtonLayoutSizing.fill)',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                MechanixButton(
                  widthSizing: ButtonLayoutSizing.fill,
                  icon: Icons.fullscreen_rounded,
                  label: 'Full Width',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ],
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
  final ButtonVariant variant;
  final ButtonType type;

  const _VariantTypeItem({
    required this.title,
    required this.description,
    required this.variant,
    required this.type,
  });
}

class _SizeItem {
  final ButtonSize size;
  final String name;
  final String codeName;

  const _SizeItem({
    required this.size,
    required this.name,
    required this.codeName,
  });
}
