import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

class CheckboxPreview extends StatelessWidget {
  const CheckboxPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Page Header
          _PageHeader(),
          SizedBox(height: 32),

          // 3. Interactive Playground
          _PlaygroundSection(),
          SizedBox(height: 48),

          // 4. Labeled Checkboxes & Form Selection
          _LabeledSelectionSection(),
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
                'Checkboxes',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Text(
                'Checkboxes allow users to select one or more items from a set and can be used to turn an option on or off. '
                "They're a kind of selection control that helps users make a choice from a set of options.",
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

class _PlaygroundSection extends StatefulWidget {
  const _PlaygroundSection();

  @override
  State<_PlaygroundSection> createState() => _PlaygroundSectionState();
}

class _PlaygroundSectionState extends State<_PlaygroundSection> {
  bool? _singleChecked = true;
  bool? _tristateValue;
  bool? _errorChecked = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Interactive Playground',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Test live checkbox interactions, keyboard navigation, and tristate cycling.',
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: Wrap(
            spacing: 32,
            runSpacing: 24,
            children: [
              _PlaygroundItem(
                title: 'Standard Checkbox',
                subtitle: 'Value: $_singleChecked',
                child: MechanixCheckbox(
                  value: _singleChecked,
                  onChanged: (v) => setState(() => _singleChecked = v),
                ),
              ),
              _PlaygroundItem(
                title: 'Tristate (Indeterminate)',
                subtitle: 'Value: ${_tristateValue ?? 'null (dash)'}',
                child: MechanixCheckbox(
                  tristate: true,
                  value: _tristateValue,
                  onChanged: (v) => setState(() => _tristateValue = v),
                ),
              ),
              _PlaygroundItem(
                title: 'Error State',
                subtitle: 'isError: true',
                child: MechanixCheckbox(
                  isError: true,
                  value: _errorChecked,
                  onChanged: (v) => setState(() => _errorChecked = v),
                ),
              ),
              const _PlaygroundItem(
                title: 'Disabled Checked',
                subtitle: 'onChanged: null',
                child: MechanixCheckbox(value: true, onChanged: null),
              ),
              const _PlaygroundItem(
                title: 'Disabled Unchecked',
                subtitle: 'onChanged: null',
                child: MechanixCheckbox(value: false, onChanged: null),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PlaygroundItem extends StatelessWidget {
  const _PlaygroundItem({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      width: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [child, const Spacer()]),
          const SizedBox(height: 12),
          Text(
            title,
            style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _LabeledSelectionSection extends StatefulWidget {
  const _LabeledSelectionSection();

  @override
  State<_LabeledSelectionSection> createState() =>
      _LabeledSelectionSectionState();
}

class _LabeledSelectionSectionState extends State<_LabeledSelectionSection> {
  bool? _termsChecked = false;
  final Set<String> _selectedOptions = {'notifications', 'updates'};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Labeled Checkboxes & Selection Lists',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Synchronized label click targets with full accessibility semantics.',
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 20),
        Container(
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
                'Notification Preferences',
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              MechanixCheckbox.labeled(
                value: _selectedOptions.contains('notifications'),
                labelText: 'Push notifications for important account updates',
                onChanged: (checked) {
                  setState(() {
                    if (checked == true) {
                      _selectedOptions.add('notifications');
                    } else {
                      _selectedOptions.remove('notifications');
                    }
                  });
                },
              ),
              const SizedBox(height: 12),
              MechanixCheckbox.labeled(
                value: _selectedOptions.contains('updates'),
                labelText: 'Weekly digest and system announcements',
                onChanged: (checked) {
                  setState(() {
                    if (checked == true) {
                      _selectedOptions.add('updates');
                    } else {
                      _selectedOptions.remove('updates');
                    }
                  });
                },
              ),
              const SizedBox(height: 12),
              MechanixCheckbox.labeled(
                value: _selectedOptions.contains('marketing'),
                labelText: 'Promotional offers and partner content',
                onChanged: (checked) {
                  setState(() {
                    if (checked == true) {
                      _selectedOptions.add('marketing');
                    } else {
                      _selectedOptions.remove('marketing');
                    }
                  });
                },
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 16),
              MechanixCheckbox.labeled(
                value: _termsChecked,
                fillColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return const Color(0xFFFFB800);
                  }
                  return null;
                }),
                side: const BorderSide(color: Color(0xFFFFB800), width: 2.0),
                checkColor: const Color(0xFF1E1E1E),
                focusRingColor: const Color(0xFFFFB800),
                labelText: 'I agree to the Terms of Service and Privacy Policy',
                onChanged: (v) => setState(() => _termsChecked = v),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
