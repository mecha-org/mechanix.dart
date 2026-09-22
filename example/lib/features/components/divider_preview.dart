import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

/// Catalog demonstration for [MechanixDivider] and [MechanixVerticalDivider].
class DividerPreview extends StatelessWidget {
  const DividerPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PageHeader(),
          SizedBox(height: 32),
          _StandardDividersSection(),
          SizedBox(height: 32),
          _InsetDividersSection(),
          SizedBox(height: 32),
          _VerticalDividersSection(),
          SizedBox(height: 32),
          _CardSeparatorsSection(),
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
            Icons.horizontal_rule_rounded,
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
                'Dividers',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Text(
                'Dividers are thin visual lines that group, separate, and structure content '
                'in lists, cards, and page layouts. Mechanix provides both horizontal and vertical '
                'dividers configured with outlineVariant tokens and Material 3 geometry.',
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

class _StandardDividersSection extends StatelessWidget {
  const _StandardDividersSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return _SectionCard(
      title: 'Horizontal Dividers',
      subtitle: 'Separates stacked items with customizable thickness, spacing, color, and corner radius.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Standard Default (1.0dp thickness, outlineVariant)'),
          const SizedBox(height: 8),
          const MechanixDivider(),
          const SizedBox(height: 16),

          const Text('Custom Thickness (3.0dp)'),
          const SizedBox(height: 8),
          const MechanixDivider(thickness: 3.0),
          const SizedBox(height: 16),

          const Text('Accent Colored Divider (Brand Primary)'),
          const SizedBox(height: 8),
          MechanixDivider(color: colorScheme.primary, thickness: 2.0),
          const SizedBox(height: 16),

          const Text('Rounded Radius Divider (4dp border radius)'),
          const SizedBox(height: 8),
          const MechanixDivider(
            thickness: 4.0,
            radius: BorderRadius.all(Radius.circular(4.0)),
          ),
        ],
      ),
    );
  }
}

class _InsetDividersSection extends StatelessWidget {
  const _InsetDividersSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Inset Dividers',
      subtitle: 'Uses indent and endIndent to align with content typography or avatar boundaries.',
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: const Text('Alice Cooper'),
              subtitle: const Text('alice@example.com'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ),
          const MechanixDivider(indent: 72, endIndent: 16),
          Material(
            color: Colors.transparent,
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: const Text('Bob Martin'),
              subtitle: const Text('bob@example.com'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ),
          const MechanixDivider(indent: 72, endIndent: 16),
          Material(
            color: Colors.transparent,
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: const Text('Charlie Brown'),
              subtitle: const Text('charlie@example.com'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class _VerticalDividersSection extends StatelessWidget {
  const _VerticalDividersSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Vertical Dividers',
      subtitle: 'Separates items horizontally in toolbars, button rows, or inline controls using IntrinsicHeight.',
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.format_bold),
                  onPressed: () {},
                  tooltip: 'Bold',
                ),
                IconButton(
                  icon: const Icon(Icons.format_italic),
                  onPressed: () {},
                  tooltip: 'Italic',
                ),
                IconButton(
                  icon: const Icon(Icons.format_underlined),
                  onPressed: () {},
                  tooltip: 'Underline',
                ),
                const MechanixDivider.vertical(space: 24),
                IconButton(
                  icon: const Icon(Icons.format_align_left),
                  onPressed: () {},
                  tooltip: 'Align Left',
                ),
                IconButton(
                  icon: const Icon(Icons.format_align_center),
                  onPressed: () {},
                  tooltip: 'Align Center',
                ),
                IconButton(
                  icon: const Icon(Icons.format_align_right),
                  onPressed: () {},
                  tooltip: 'Align Right',
                ),
                const MechanixVerticalDivider(space: 24),
                IconButton(
                  icon: const Icon(Icons.link),
                  onPressed: () {},
                  tooltip: 'Insert Link',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CardSeparatorsSection extends StatelessWidget {
  const _CardSeparatorsSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return _SectionCard(
      title: 'Card & Dialog Separators',
      subtitle: 'Structuring composite card elements into clear visual zones.',
      child: Center(
        child: Container(
          width: 440,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.security, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Account Security',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const MechanixDivider(space: 1),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Two-factor authentication is enabled for your organization. '
                  'Security keys and authenticator apps are required for login.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const MechanixDivider(space: 1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () {}, child: const Text('Details')),
                    const SizedBox(width: 8),
                    FilledButton(onPressed: () {}, child: const Text('Manage')),
                  ],
                ),
              ),
            ],
          ),
        ),
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
