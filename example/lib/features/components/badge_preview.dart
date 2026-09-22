import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

/// Catalog demonstration for [MechanixBadge].
class BadgePreview extends StatelessWidget {
  const BadgePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PageHeader(),
          SizedBox(height: 32),
          _SmallBadgesSection(),
          SizedBox(height: 32),
          _CountBadgesSection(),
          SizedBox(height: 32),
          _TextBadgesSection(),
          SizedBox(height: 32),
          _SemanticVariantsSection(),
          SizedBox(height: 32),
          _StandaloneBadgesSection(),
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
            Icons.mark_chat_unread_outlined,
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
                'Badges',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Text(
                'Badges convey dynamic notifications, counts, or status information '
                'attached to navigation items, icons, and buttons, or displayed standalone.',
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

class _SmallBadgesSection extends StatelessWidget {
  const _SmallBadgesSection();

  @override
  Widget build(BuildContext context) {
    return const _SectionCard(
      title: 'Small Badges (Status Indicators)',
      subtitle: 'Compact 6dp filled dot indicators that signal unread activity without count numbers.',
      child: Wrap(
        spacing: 32,
        runSpacing: 16,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          MechanixBadge.small(
            child: Icon(Icons.notifications_outlined, size: 28),
          ),
          MechanixBadge.small(
            variant: MechanixBadgeVariant.primary,
            child: Icon(Icons.chat_bubble_outline_rounded, size: 28),
          ),
          MechanixBadge.small(
            variant: MechanixBadgeVariant.neutral,
            child: Icon(Icons.mail_outline_rounded, size: 28),
          ),
          MechanixBadge.small(
            child: CircleAvatar(
              radius: 18,
              child: Icon(Icons.person, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class _CountBadgesSection extends StatelessWidget {
  const _CountBadgesSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Count Badges',
      subtitle: 'Displays numeric information with automatic stadium width adaptation and 99+ / 999+ formatting.',
      child: Wrap(
        spacing: 32,
        runSpacing: 16,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          MechanixBadge.count(
            count: 3,
            child: const Icon(Icons.shopping_cart_outlined, size: 28),
          ),
          MechanixBadge.count(
            count: 42,
            child: const Icon(Icons.email_outlined, size: 28),
          ),
          MechanixBadge.count(
            count: 128,
            maxCount: 99,
            child: const Icon(Icons.inbox_outlined, size: 28),
          ),
          MechanixBadge.count(
            count: 1450,
            maxCount: 999,
            child: const Icon(Icons.notifications_outlined, size: 28),
          ),
        ],
      ),
    );
  }
}

class _TextBadgesSection extends StatelessWidget {
  const _TextBadgesSection();

  @override
  Widget build(BuildContext context) {
    return const _SectionCard(
      title: 'Text Label Badges',
      subtitle: 'Supports short text announcements such as "NEW", "PRO", or "BETA".',
      child: Wrap(
        spacing: 32,
        runSpacing: 16,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          MechanixBadge(
            label: Text('NEW'),
            child: Icon(Icons.auto_awesome, size: 28),
          ),
          MechanixBadge(
            variant: MechanixBadgeVariant.primary,
            label: Text('PRO'),
            child: Icon(Icons.workspace_premium, size: 28),
          ),
          MechanixBadge(
            variant: MechanixBadgeVariant.neutral,
            label: Text('BETA'),
            child: Icon(Icons.science_outlined, size: 28),
          ),
        ],
      ),
    );
  }
}

class _SemanticVariantsSection extends StatelessWidget {
  const _SemanticVariantsSection();

  @override
  Widget build(BuildContext context) {
    return const _SectionCard(
      title: 'Semantic Color Variants',
      subtitle: 'Harmonious color roles: Error (Alerts), Primary (Brand Orange), Neutral (Container), and Surface.',
      child: Wrap(
        spacing: 24,
        runSpacing: 16,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Column(
            children: [
              MechanixBadge(
                variant: MechanixBadgeVariant.error,
                label: Text('Alert'),
                child: Icon(Icons.error_outline, size: 28),
              ),
              SizedBox(height: 8),
              Text('Error (Default)', style: TextStyle(fontSize: 12)),
            ],
          ),
          Column(
            children: [
              MechanixBadge(
                variant: MechanixBadgeVariant.primary,
                label: Text('Active'),
                child: Icon(Icons.star_outline, size: 28),
              ),
              SizedBox(height: 8),
              Text('Primary', style: TextStyle(fontSize: 12)),
            ],
          ),
          Column(
            children: [
              MechanixBadge(
                variant: MechanixBadgeVariant.neutral,
                label: Text('Inbox'),
                child: Icon(Icons.folder_open, size: 28),
              ),
              SizedBox(height: 8),
              Text('Neutral', style: TextStyle(fontSize: 12)),
            ],
          ),
          Column(
            children: [
              MechanixBadge(
                variant: MechanixBadgeVariant.surface,
                label: Text('Draft'),
                child: Icon(Icons.drafts_outlined, size: 28),
              ),
              SizedBox(height: 8),
              Text('Surface', style: TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

class _StandaloneBadgesSection extends StatelessWidget {
  const _StandaloneBadgesSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Standalone Badges (Without Child)',
      subtitle: 'Badges can be rendered standalone as status indicators or labels inside tables, rows, or cards.',
      child: Wrap(
        spacing: 16,
        runSpacing: 12,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const MechanixBadge.small(),
          const MechanixBadge.small(variant: MechanixBadgeVariant.primary),
          const MechanixBadge.small(variant: MechanixBadgeVariant.neutral),
          MechanixBadge.count(count: 8),
          MechanixBadge.count(count: 24, variant: MechanixBadgeVariant.primary),
          const MechanixBadge(
            variant: MechanixBadgeVariant.neutral,
            label: Text('PENDING'),
          ),
          const MechanixBadge(
            variant: MechanixBadgeVariant.surface,
            label: Text('ARCHIVED'),
          ),
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
