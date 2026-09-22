import 'package:flutter/material.dart';

/// A polished design-system documentation page demonstrating the Material 3 [TextTheme].
class TypographyPreview extends StatelessWidget {
  const TypographyPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final groups = [
      _TypographyGroup(
        title: 'Display',
        items: [
          _TypographyItem('Display Large', textTheme.displayLarge),
          _TypographyItem('Display Medium', textTheme.displayMedium),
          _TypographyItem('Display Small', textTheme.displaySmall),
        ],
      ),
      _TypographyGroup(
        title: 'Headline',
        items: [
          _TypographyItem('Headline Large', textTheme.headlineLarge),
          _TypographyItem('Headline Medium', textTheme.headlineMedium),
          _TypographyItem('Headline Small', textTheme.headlineSmall),
        ],
      ),
      _TypographyGroup(
        title: 'Title',
        items: [
          _TypographyItem('Title Large', textTheme.titleLarge),
          _TypographyItem('Title Medium', textTheme.titleMedium),
          _TypographyItem('Title Small', textTheme.titleSmall),
        ],
      ),
      _TypographyGroup(
        title: 'Body',
        items: [
          _TypographyItem('Body Large', textTheme.bodyLarge),
          _TypographyItem('Body Medium', textTheme.bodyMedium),
          _TypographyItem('Body Small', textTheme.bodySmall),
        ],
      ),
      _TypographyGroup(
        title: 'Label',
        items: [
          _TypographyItem('Label Large', textTheme.labelLarge),
          _TypographyItem('Label Medium', textTheme.labelMedium),
          _TypographyItem('Label Small', textTheme.labelSmall),
        ],
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Page Header
        _buildPageHeader(context),
        const SizedBox(height: 24),

        // 2. About Section Card
        // _buildAboutCard(context),
        // const SizedBox(height: 32),

        // 3. Five Typography Group Cards
        for (int i = 0; i < groups.length; i++) ...[
          if (i > 0) const SizedBox(height: 32),
          _buildGroupSection(context, groups[i]),
        ],
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
            Icons.text_fields_rounded,
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
                'Typography',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                'Material 3 Type Scale',
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

  /*
  Widget _buildAboutCard(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final isDesktop = MediaQuery.sizeOf(context).width >= 900;

    final fontFamily = textTheme.bodyLarge?.fontFamily ?? 'Sora';
    final baseFontSize = textTheme.bodyLarge?.fontSize != null
        ? '${textTheme.bodyLarge!.fontSize!.toStringAsFixed(0)}px'
        : '16px';

    final metadataContent = [
      _buildAboutMetaRow('Font Family', fontFamily, colorScheme),
      const SizedBox(height: 8),
      _buildAboutMetaRow('Base Font Size', baseFontSize, colorScheme),
      const SizedBox(height: 8),
      _buildAboutMetaRow('Scale', 'Material 3', colorScheme),
      const SizedBox(height: 8),
      _buildAboutMetaRow('Source', 'Theme.of(context).textTheme', colorScheme),
    ];

    return Card(
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
              'About',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            if (isDesktop)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Text(
                      'The typography system is based on Material 3 guidelines and configured through the active theme.',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: metadataContent,
                    ),
                  ),
                ],
              )
            else ...[
              Text(
                'The typography system is based on Material 3 guidelines and configured through the active theme.',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 16),
              ...metadataContent,
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAboutMetaRow(
    String label,
    String value,
    ColorScheme colorScheme,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              fontFamily: 'monospace',
              color: colorScheme.onSurface,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
  */

  Widget _buildGroupSection(BuildContext context, _TypographyGroup group) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Group Header
        Text(
          group.title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        // Group Card enclosing the 3 styles
        Card(
          elevation: 0,
          color: colorScheme.surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: colorScheme.outlineVariant),
          ),
          child: Column(
            children: [
              for (int i = 0; i < group.items.length; i++) ...[
                if (i > 0)
                  Divider(
                    height: 1,
                    color: colorScheme.outlineVariant.withValues(alpha: 0.6),
                  ),
                _buildStyleRow(context, group.items[i]),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStyleRow(BuildContext context, _TypographyItem item) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final style = item.style;
    final isDesktop = MediaQuery.sizeOf(context).width >= 900;

    // Derived metadata
    // final rawFamily = style?.fontFamily ?? 'Default';
    // final fontFamily = rawFamily.replaceFirst('packages/widgets/', '');
    final fontSize = style?.fontSize != null
        ? '${style!.fontSize!.toStringAsFixed(0)}px'
        : 'Default';
    final fontWeight = style?.fontWeight != null
        ? '${style!.fontWeight!.value}'
        : 'Default';
    final lineHeight =
        style != null && style.height != null && style.fontSize != null
        ? '${(style.height! * style.fontSize!).toStringAsFixed(0)}px (${style.height!.toStringAsFixed(2)})'
        : (style?.height?.toStringAsFixed(2) ?? 'Default');
    final letterSpacing = style?.letterSpacing != null
        ? '${style!.letterSpacing!.toStringAsFixed(2)}px'
        : 'Default';

    final metadataBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // _buildMetaItem('Font Family', fontFamily, colorScheme),
        _buildMetaItem('Font Family', '', colorScheme),
        const SizedBox(height: 3),
        _buildMetaItem('Size', fontSize, colorScheme),
        const SizedBox(height: 3),
        _buildMetaItem('Weight', fontWeight, colorScheme),
        const SizedBox(height: 3),
        _buildMetaItem('Line Height', lineHeight, colorScheme),
        const SizedBox(height: 3),
        _buildMetaItem('Letter Spacing', letterSpacing, colorScheme),
      ],
    );

    if (isDesktop) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Column 1: Style Name
            SizedBox(
              width: 140,
              child: Text(
                item.name,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Column 2: Live Typography Sample
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Text(
                  item.name,
                  style: style,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),

            // Column 3: Metadata Block
            // SizedBox(width: 240, child: metadataBlock),
          ],
        ),
      );
    }

    // Mobile / Tablet Vertical Layout
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Style Name Label
          Text(
            item.name,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),

          // Live Typography Sample
          Text(item.name, style: style, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 12),

          // Metadata in Container
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: colorScheme.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
            child: metadataBlock,
          ),
        ],
      ),
    );
  }

  Widget _buildMetaItem(String label, String value, ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 11, color: colorScheme.onSurfaceVariant),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _TypographyGroup {
  final String title;
  final List<_TypographyItem> items;

  const _TypographyGroup({required this.title, required this.items});
}

class _TypographyItem {
  final String name;
  final TextStyle? style;

  const _TypographyItem(this.name, this.style);
}
