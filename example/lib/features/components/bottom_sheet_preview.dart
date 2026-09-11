import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

/// A catalog demonstration for [MechanixBottomSheet] covering standard, modal,
/// drag handle, scrollable, keyboard input, and runtime theme switching scenarios.
class BottomSheetPreview extends StatelessWidget {
  const BottomSheetPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PageHeader(),
          SizedBox(height: 32),
          _ModalSection(),
          SizedBox(height: 32),
          _StandardSection(),
          SizedBox(height: 32),
          _ScrollableSection(),
          SizedBox(height: 32),
          _InputSection(),
          SizedBox(height: 32),
          _RuntimeThemeSection(),
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
            MechanixIcons.comet,
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
                'Bottom Sheet',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Text(
                'Bottom sheets are surfaces containing supplementary content anchored to the bottom of the screen. '
                'Mechanix provides both Modal and Standard (persistent) bottom sheets adhering to Material 3 tokens, '
                'with responsive 640dp desktop constraints, drag handles, and reactive theming.',
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

class _ModalSection extends StatelessWidget {
  const _ModalSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return _SectionCard(
      title: 'Modal Bottom Sheet',
      subtitle: 'Modal bottom sheets present a dismissible surface above the application content with a scrim backdrop.',
      child: Wrap(
        spacing: 16,
        runSpacing: 12,
        children: [
          MechanixButton.filled(
            label: 'Open Modal Sheet',
            icon: const Icon(Icons.open_in_browser_rounded),
            onPressed: () {
              MechanixBottomSheet.showModal(
                context: context,
                builder: (sheetContext) => _SheetContent(
                  title: 'Modal Options',
                  subtitle: 'Select an action from this modal sheet.',
                  actions: [
                    MechanixButton.filled(
                      label: 'Confirm',
                      onPressed: () => Navigator.pop(sheetContext),
                    ),
                    const SizedBox(width: 8),
                    MechanixButton.outline(
                      label: 'Cancel',
                      onPressed: () => Navigator.pop(sheetContext),
                    ),
                  ],
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.share_rounded),
                        title: const Text('Share document'),
                        onTap: () => Navigator.pop(sheetContext),
                      ),
                      ListTile(
                        leading: const Icon(Icons.link_rounded),
                        title: const Text('Copy link'),
                        onTap: () => Navigator.pop(sheetContext),
                      ),
                      ListTile(
                        leading: const Icon(Icons.delete_outline_rounded),
                        title: const Text('Delete'),
                        onTap: () => Navigator.pop(sheetContext),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          MechanixButton.outline(
            label: 'Modal Without Drag Handle',
            onPressed: () {
              MechanixBottomSheet.showModal(
                context: context,
                showDragHandle: false,
                builder: (sheetContext) => _SheetContent(
                  title: 'No Drag Handle',
                  subtitle: 'This modal sheet has showDragHandle: false.',
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'You can still drag to dismiss or tap the outer scrim barrier.',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StandardSection extends StatefulWidget {
  const _StandardSection();

  @override
  State<_StandardSection> createState() => _StandardSectionState();
}

class _StandardSectionState extends State<_StandardSection> {
  PersistentBottomSheetController? _controller;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Standard (Persistent) Bottom Sheet',
      subtitle: 'Standard bottom sheets coexist with primary content without a scrim, remaining non-modal and interactive.',
      child: Wrap(
        spacing: 16,
        runSpacing: 12,
        children: [
          MechanixButton.filled(
            label: _controller == null
                ? 'Show Persistent Sheet'
                : 'Close Persistent Sheet',
            icon: Icon(
              _controller == null
                  ? Icons.vertical_align_bottom_rounded
                  : Icons.close_rounded,
            ),
            onPressed: () {
              if (_controller != null) {
                _controller?.close();
                setState(() => _controller = null);
              } else {
                _controller = MechanixBottomSheet.show(
                  context: context,
                  builder: (sheetContext) => Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        const Icon(Icons.music_note_rounded, size: 36),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Persistent Audio Player',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Playing: Mechanix Soundscape #42',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.pause_rounded),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.close_rounded),
                          onPressed: () {
                            _controller?.close();
                            setState(() => _controller = null);
                          },
                        ),
                      ],
                    ),
                  ),
                );
                _controller?.closed.then((_) {
                  if (mounted) setState(() => _controller = null);
                });
                setState(() {});
              }
            },
          ),
        ],
      ),
    );
  }
}

class _ScrollableSection extends StatelessWidget {
  const _ScrollableSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Scrollable & Long Content',
      subtitle: 'Bottom sheets expand naturally with isScrollControlled: true, coordinating nested scroll gestures smoothly.',
      child: MechanixButton.filled(
        label: 'Open Scrollable List (50 items)',
        icon: const Icon(Icons.format_list_numbered_rounded),
        onPressed: () {
          MechanixBottomSheet.showModal(
            context: context,
            isScrollControlled: true,
            builder: (sheetContext) => SizedBox(
              height: 480,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Text(
                      'Long Scrollable Items',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 50,
                      itemBuilder: (context, index) => ListTile(
                        leading: CircleAvatar(child: Text('${index + 1}')),
                        title: Text('Mechanix Item #${index + 1}'),
                        subtitle: Text(
                          'Supplementary detail for entry number ${index + 1}',
                        ),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _InputSection extends StatefulWidget {
  const _InputSection();

  @override
  State<_InputSection> createState() => _InputSectionState();
}

class _InputSectionState extends State<_InputSection> {
  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Keyboard & Input Support',
      subtitle: 'Text fields inside bottom sheets adapt to software keyboard insets with safe area protection.',
      child: MechanixButton.filled(
        label: 'Open Sheet with Text Fields',
        icon: const Icon(Icons.edit_note_rounded),
        onPressed: () {
          MechanixBottomSheet.showModal(
            context: context,
            isScrollControlled: true,
            builder: (sheetContext) => Padding(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 12,
                bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Feedback Form',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Subject',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Your comments',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  MechanixButton.filled(
                    label: 'Submit Feedback',
                    onPressed: () => Navigator.pop(sheetContext),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RuntimeThemeSection extends StatelessWidget {
  const _RuntimeThemeSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Runtime Theme Reactivity',
      subtitle: 'Open the sheet and toggle the theme mode directly inside. The mounted bottom sheet updates dynamically.',
      child: MechanixButton.filled(
        label: 'Test Runtime Theme Toggle Sheet',
        icon: const Icon(Icons.palette_rounded),
        onPressed: () {
          MechanixBottomSheet.showModal(
            context: context,
            builder: (sheetContext) {
              return Builder(
                builder: (context) {
                  final activeBrightness = Theme.of(context).brightness;
                  final currentMode =
                      MechanixTheme.maybeOf(context)?.mode ?? ThemeMode.system;

                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Dynamic Theme Reactive Sheet',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Current Brightness: ${activeBrightness.name.toUpperCase()}',
                        ),
                        Text('Active ThemeMode: ${currentMode.name}'),
                        const SizedBox(height: 20),
                        const Text('Switch Theme Mode:'),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            MechanixButton.filled(
                              label: 'Light',
                              onPressed: () => MechanixTheme.setThemeMode(
                                context,
                                ThemeMode.light,
                              ),
                            ),
                            const SizedBox(width: 8),
                            MechanixButton.filled(
                              label: 'Dark',
                              onPressed: () => MechanixTheme.setThemeMode(
                                context,
                                ThemeMode.dark,
                              ),
                            ),
                            const SizedBox(width: 8),
                            MechanixButton.outline(
                              label: 'System',
                              onPressed: () => MechanixTheme.setThemeMode(
                                context,
                                ThemeMode.system,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
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

class _SheetContent extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final List<Widget>? actions;

  const _SheetContent({
    required this.title,
    this.subtitle,
    required this.child,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            const SizedBox(height: 16),
            child,
            if (actions != null) ...[
              const SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: actions!),
            ],
          ],
        ),
      ),
    );
  }
}
