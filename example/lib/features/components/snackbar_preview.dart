import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

/// A polished design-system documentation page demonstrating all variants,
/// layouts, building blocks, and live interactive behaviors of [MechanixSnackbar].
class SnackbarPreview extends StatefulWidget {
  const SnackbarPreview({super.key});

  @override
  State<SnackbarPreview> createState() => _SnackbarPreviewState();
}

class _SnackbarPreviewState extends State<SnackbarPreview> {
  String? _lastActionMessage;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Page Header
          _buildPageHeader(context),
          const SizedBox(height: 24),

          // 2. Interactive Trigger Playground
          _buildInteractivePlaygroundSection(context),
          const SizedBox(height: 32),

          // 3. Design System Matrix (Exact 10 variants from M3 reference)
          _buildDesignMatrixSection(context),
          const SizedBox(height: 32),

          // 4. Building Blocks (Labels & Dismiss Icons)
          _buildBuildingBlocksSection(context),
          const SizedBox(height: 32),
        ],
      ),
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
            Icons.chat_bubble_outline,
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
                'Snackbars',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                'Snackbars provide brief messages about app processes at the bottom of the screen.',
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

  Widget _buildInteractivePlaygroundSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
              'Live Interactive Triggers',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Click any button below to trigger a live floating MechanixSnackbar via ScaffoldMessenger:',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                MechanixButton.outline(
                  label: 'Simple Message',
                  onPressed: () {
                    MechanixSnackbar.text(
                      width: 400,
                      text: 'File deleted from your device.',
                    ).show(context);
                  },
                ),
                MechanixButton.outline(
                  label: 'With Action',
                  onPressed: () {
                    MechanixSnackbar.text(
                      text: 'Connection lost. Offline mode active.',
                      action: MechanixSnackbarAction(
                        label: 'RETRY',
                        onPressed: () {
                          setState(() => _lastActionMessage = 'Retry invoked!');
                        },
                      ),
                    ).show(context);
                  },
                ),
                MechanixButton.outline(
                  label: 'With Action & Close',
                  onPressed: () {
                    MechanixSnackbar.text(
                      text: 'Photo archived to cloud album.',
                      action: MechanixSnackbarAction(
                        label: 'UNDO',
                        onPressed: () {
                          setState(() => _lastActionMessage = 'Undo invoked!');
                        },
                      ),
                      showCloseIcon: true,
                    ).show(context);
                  },
                ),
                MechanixButton.outline(
                  label: 'Multiline (Inline Action)',
                  onPressed: () {
                    MechanixSnackbar.text(
                      text:
                          'A software update is ready for installation. Reboot required to complete setup.',
                      action: MechanixSnackbarAction(
                        label: 'REBOOT',
                        onPressed: () {},
                      ),
                      showCloseIcon: true,
                    ).show(context);
                  },
                ),
                MechanixButton.filled(
                  label: 'Stacked (Action Below)',
                  onPressed: () {
                    MechanixSnackbar.text(
                      layout: SnackbarLayout.stacked,
                      text:
                          'Changes could not be synchronized with server because local buffer is full.',
                      action: MechanixSnackbarAction(
                        label: 'MANAGE STORAGE',
                        onPressed: () {},
                      ),
                      showCloseIcon: true,
                    ).show(context);
                  },
                ),
              ],
            ),
            if (_lastActionMessage != null) ...[
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Callback event: $_lastActionMessage',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDesignMatrixSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isWide = MediaQuery.sizeOf(context).width >= 960;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Visual Specification Matrix',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'All 10 variations representing the complete Material 3 & Mechanix design system specification:',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        if (isWide)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildMatrixColumn(
                  context,
                  title: 'Without Dismiss Button',
                  showDismiss: false,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _buildMatrixColumn(
                  context,
                  title: 'With Dismiss Button',
                  showDismiss: true,
                ),
              ),
            ],
          )
        else ...[
          _buildMatrixColumn(
            context,
            title: 'Without Dismiss Button',
            showDismiss: false,
          ),
          const SizedBox(height: 24),
          _buildMatrixColumn(
            context,
            title: 'With Dismiss Button',
            showDismiss: true,
          ),
        ],
      ],
    );
  }

  Widget _buildMatrixColumn(
    BuildContext context, {
    required String title,
    required bool showDismiss,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 14),

            // Variant 1: One-line message
            _buildSampleWrapper(
              context,
              caption: '1. One-line message',
              child: MechanixSnackbar.text(
                text: 'One-line snackbar with...',
                showCloseIcon: showDismiss,
              ),
            ),
            const SizedBox(height: 12),

            // Variant 2: One-line message with longer action
            _buildSampleWrapper(
              context,
              caption: '2. One-line with action',
              child: MechanixSnackbar.text(
                text: 'One-line snackbar with longer action',
                layout: SnackbarLayout.inline,
                action: MechanixSnackbarAction(
                  label: 'Action',
                  onPressed: () {},
                ),
                showCloseIcon: showDismiss,
              ),
            ),
            const SizedBox(height: 12),

            // Variant 3: Multiline message
            _buildSampleWrapper(
              context,
              caption: '3. Multiline message only',
              child: MechanixSnackbar.text(
                text: 'One-line snackbar with longer action that spans across multiple lines for detailed notification.',
                showCloseIcon: showDismiss,
              ),
            ),
            const SizedBox(height: 12),

            // Variant 4: Multiline with action (inline)
            _buildSampleWrapper(
              context,
              caption: '4. Multiline with action (inline)',
              child: MechanixSnackbar.text(
                text: 'One-line snackbar with longer action that spans across lines.',
                layout: SnackbarLayout.inline,
                action: MechanixSnackbarAction(
                  label: 'Action',
                  onPressed: () {},
                ),
                showCloseIcon: showDismiss,
              ),
            ),
            const SizedBox(height: 12),

            // Variant 5: Multiline with longer action (stacked below)
            _buildSampleWrapper(
              context,
              caption: '5. Multiline with longer action (stacked)',
              child: MechanixSnackbar.text(
                text: 'One-line snackbar with longer action placed on second row below.',
                layout: SnackbarLayout.stacked,
                action: MechanixSnackbarAction(
                  label: 'Longer Action',
                  onPressed: () {},
                ),
                showCloseIcon: showDismiss,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSampleWrapper(
    BuildContext context, {
    required String caption,
    required Widget child,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          caption,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 4),
        child,
      ],
    );
  }

  Widget _buildBuildingBlocksSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
              'Building Blocks',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Atomic visual building blocks supporting the snackbar anatomy:',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),

            // Label Chips
            Text(
              'Label Chips',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildChip(context, label: 'Label'),
                _buildChip(
                  context,
                  label: 'Label',
                  backgroundColor: colorScheme.surfaceContainerHighest,
                ),
                _buildChip(
                  context,
                  label: 'Label',
                  hasDot: true,
                  dotColor: colorScheme.primary,
                ),
                _buildChip(
                  context,
                  label: 'Label',
                  backgroundColor: colorScheme.surfaceContainerHigh,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Dismiss Actions
            Text(
              'Dismiss Action Buttons (Icons)',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                for (int i = 0; i < 4; i++) ...[
                  if (i > 0) const SizedBox(width: 16),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: colorScheme.outline.withValues(alpha: 0.5),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      MechanixIcons.x,
                      size: 18,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(
    BuildContext context, {
    required String label,
    Color? backgroundColor,
    bool hasDot = false,
    Color? dotColor,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor ?? colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.6),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasDot) ...[
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: dotColor ?? colorScheme.primary,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
