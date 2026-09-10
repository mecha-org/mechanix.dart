import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

/// A polished design-system documentation page demonstrating all states,
/// groups, and label variations of [MechanixRadio].
class RadioPreview extends StatelessWidget {
  const RadioPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Page Header matching reference design
        _PageHeader(),
        SizedBox(height: 16),
        Divider(),
        SizedBox(height: 32),

        // 2. Visual State Matrix (2 rows x 5 columns matching reference design)
        _StateMatrixSection(),
        SizedBox(height: 48),

        // 3. Interactive Playground
        _PlaygroundSection(),
        SizedBox(height: 48),

        // 4. Mutually Exclusive Radio Group
        _RadioGroupSection(),
        SizedBox(height: 48),

        // 5. Modern RadioGroup Ancestor
        _ModernRadioGroupSection(),
        SizedBox(height: 48),

        // 6. Rich Labeled Options
        _RichLabeledSection(),
        SizedBox(height: 48),
      ],
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(MechanixIcons.comet, size: 36, color: colorScheme.primary),
        const SizedBox(height: 20),
        Text(
          'Radio buttons',
          style: textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 12),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Text(
            "Radio buttons allow users to select one option from a set. They're a selection control "
            'that often appears when users are asked to make decisions or select a choice from options.',
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

/// Exact 2x5 state matrix matching the reference image:
/// Columns: Enabled | Hovered | Focused | Pressed | Disabled
/// Rows: Selected | Unselected
class _StateMatrixSection extends StatelessWidget {
  const _StateMatrixSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    const columnHeaders = [
      'Enabled',
      'Hovered',
      'Focused',
      'Pressed',
      'Disabled',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'State Matrix',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Visual states corresponding to Material 3 interaction specifications.',
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Column Headers
                Row(
                  children: [
                    const SizedBox(width: 90),
                    for (final header in columnHeaders)
                      SizedBox(
                        width: 90,
                        child: Center(
                          child: Text(
                            header,
                            style: textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 24),

                // Row 1: Selected (Checked)
                Row(
                  children: [
                    SizedBox(
                      width: 90,
                      child: Text(
                        'Selected',
                        style: textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    // 1. Enabled
                    _buildMatrixCell(
                      MechanixRadio<int>(
                        value: 1,
                        groupValue: 1,
                        onChanged: (_) {},
                      ),
                    ),
                    // 2. Hovered
                    _buildMatrixCell(
                      MechanixRadio<int>(
                        value: 1,
                        groupValue: 1,
                        hoverColor: Colors.transparent,
                        fillColor: WidgetStateProperty.all(colorScheme.primary),
                        onChanged: (_) {},
                      ),
                    ),
                    // 3. Focused
                    _buildMatrixCell(
                      MechanixRadio<int>(
                        value: 1,
                        groupValue: 1,
                        focusColor: Colors.transparent,
                        fillColor: WidgetStateProperty.all(colorScheme.primary),
                        onChanged: (_) {},
                      ),
                    ),
                    // 4. Pressed
                    _buildMatrixCell(
                      MechanixRadio<int>(
                        value: 1,
                        groupValue: 1,
                        overlayColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),
                        fillColor: WidgetStateProperty.all(colorScheme.primary),
                        onChanged: (_) {},
                      ),
                    ),
                    // 5. Disabled
                    _buildMatrixCell(
                      const MechanixRadio<int>(
                        value: 1,
                        groupValue: 1,
                        onChanged: null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Row 2: Unselected (Unchecked)
                Row(
                  children: [
                    SizedBox(
                      width: 90,
                      child: Text(
                        'Unselected',
                        style: textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    // 1. Enabled
                    _buildMatrixCell(
                      MechanixRadio<int>(
                        value: 1,
                        groupValue: 2,
                        onChanged: (_) {},
                      ),
                    ),
                    // 2. Hovered
                    _buildMatrixCell(
                      MechanixRadio<int>(
                        value: 1,
                        groupValue: 2,
                        fillColor: WidgetStateProperty.all(
                          colorScheme.onSurface,
                        ),
                        onChanged: (_) {},
                      ),
                    ),
                    // 3. Focused
                    _buildMatrixCell(
                      MechanixRadio<int>(
                        value: 1,
                        groupValue: 2,
                        fillColor: WidgetStateProperty.all(
                          colorScheme.onSurface,
                        ),
                        onChanged: (_) {},
                      ),
                    ),
                    // 4. Pressed
                    _buildMatrixCell(
                      MechanixRadio<int>(
                        value: 1,
                        groupValue: 2,
                        fillColor: WidgetStateProperty.all(
                          colorScheme.onSurface,
                        ),
                        onChanged: (_) {},
                      ),
                    ),
                    // 5. Disabled
                    _buildMatrixCell(
                      const MechanixRadio<int>(
                        value: 1,
                        groupValue: 2,
                        onChanged: null,
                      ),
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

  Widget _buildMatrixCell(Widget radio) {
    return SizedBox(width: 90, child: Center(child: radio));
  }
}

class _PlaygroundSection extends StatefulWidget {
  const _PlaygroundSection();

  @override
  State<_PlaygroundSection> createState() => _PlaygroundSectionState();
}

class _PlaygroundSectionState extends State<_PlaygroundSection> {
  int? _playgroundValue = 1;
  int? _toggleableValue = 1;
  int? _errorValue = 1;

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
          'Test individual radio interactions, keyboard navigation, error states, and toggleable behavior.',
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
          child: Wrap(
            spacing: 24,
            runSpacing: 20,
            children: [
              _PlaygroundItem(
                title: 'Selected Radio',
                subtitle: 'Active selection',
                child: MechanixRadio<int>(
                  value: 1,
                  groupValue: _playgroundValue,
                  onChanged: (v) => setState(() => _playgroundValue = v),
                ),
              ),
              _PlaygroundItem(
                title: 'Unselected Radio',
                subtitle: 'Available choice',
                child: MechanixRadio<int>(
                  value: 2,
                  groupValue: _playgroundValue,
                  onChanged: (v) => setState(() => _playgroundValue = v),
                ),
              ),
              _PlaygroundItem(
                title: 'Toggleable Radio',
                subtitle: 'Tap selected to clear',
                child: MechanixRadio<int>(
                  value: 1,
                  groupValue: _toggleableValue,
                  toggleable: true,
                  onChanged: (v) => setState(() => _toggleableValue = v),
                ),
              ),
              _PlaygroundItem(
                title: 'Error State',
                subtitle: 'isError: true',
                child: MechanixRadio<int>(
                  value: 1,
                  groupValue: _errorValue,
                  isError: true,
                  onChanged: (v) => setState(() => _errorValue = v),
                ),
              ),
              const _PlaygroundItem(
                title: 'Disabled Selected',
                subtitle: 'onChanged: null',
                child: MechanixRadio<int>(
                  value: 1,
                  groupValue: 1,
                  onChanged: null,
                ),
              ),
              const _PlaygroundItem(
                title: 'Disabled Unselected',
                subtitle: 'onChanged: null',
                child: MechanixRadio<int>(
                  value: 2,
                  groupValue: 1,
                  onChanged: null,
                ),
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
      width: 200,
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

class _RadioGroupSection extends StatefulWidget {
  const _RadioGroupSection();

  @override
  State<_RadioGroupSection> createState() => _RadioGroupSectionState();
}

class _RadioGroupSectionState extends State<_RadioGroupSection> {
  String _selectedShipping = 'standard';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Radio Group (Mutual Exclusion)',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Selecting any radio button in the group automatically deselects the previously chosen option.',
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
                'Shipping Method',
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              MechanixRadio<String>.labeled(
                value: 'standard',
                groupValue: _selectedShipping,
                labelText: 'Standard Delivery (3-5 business days) - Free',
                onChanged: (v) => setState(() => _selectedShipping = v!),
              ),
              const SizedBox(height: 12),
              MechanixRadio<String>.labeled(
                value: 'express',
                groupValue: _selectedShipping,
                labelText: 'Express Shipping (1-2 business days) - \$9.99',
                onChanged: (v) => setState(() => _selectedShipping = v!),
              ),
              const SizedBox(height: 12),
              MechanixRadio<String>.labeled(
                value: 'overnight',
                groupValue: _selectedShipping,
                labelText: 'Overnight Courier (Next morning) - \$19.99',
                onChanged: (v) => setState(() => _selectedShipping = v!),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 18,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Selected: $_selectedShipping',
                      style: textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ModernRadioGroupSection extends StatefulWidget {
  const _ModernRadioGroupSection();

  @override
  State<_ModernRadioGroupSection> createState() =>
      _ModernRadioGroupSectionState();
}

class _ModernRadioGroupSectionState extends State<_ModernRadioGroupSection> {
  String _selectedPayment = 'card';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Modern RadioGroup Ancestor',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Individual radios omit groupValue and onChanged, automatically inheriting them from the RadioGroup<T> ancestor.',
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
          child: RadioGroup<String>(
            groupValue: _selectedPayment,
            onChanged: (v) {
              if (v != null) {
                setState(() => _selectedPayment = v);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Options',
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const MechanixRadio<String>.labeled(
                  value: 'card',
                  labelText: 'Credit or Debit Card',
                ),
                const SizedBox(height: 12),
                const MechanixRadio<String>.labeled(
                  value: 'digital',
                  labelText: 'Apple Pay / Google Wallet',
                ),
                const SizedBox(height: 12),
                const MechanixRadio<String>.labeled(
                  value: 'bank',
                  labelText: 'Direct Bank Wire Transfer',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RichLabeledSection extends StatefulWidget {
  const _RichLabeledSection();

  @override
  State<_RichLabeledSection> createState() => _RichLabeledSectionState();
}

class _RichLabeledSectionState extends State<_RichLabeledSection> {
  String _selectedPlan = 'pro';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Labeled Radios & Rich Custom Content',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Using custom rich label widgets with titles, descriptions, and status badges.',
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
              _buildRichOption(
                value: 'starter',
                title: 'Starter Plan',
                subtitle: 'For individual developers and small personal side projects',
                price: 'Free',
              ),
              const SizedBox(height: 16),
              _buildRichOption(
                value: 'pro',
                title: 'Pro Team Plan',
                subtitle: 'Collaborative workspaces, unlimited exports, priority support',
                price: '\$29 / mo',
                isPopular: true,
              ),
              const SizedBox(height: 16),
              _buildRichOption(
                value: 'enterprise',
                title: 'Enterprise Organization',
                subtitle: 'Custom SLA, dedicated infrastructure, SSO & compliance audit logs',
                price: 'Custom',
                enabled: false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRichOption({
    required String value,
    required String title,
    required String subtitle,
    required String price,
    bool isPopular = false,
    bool enabled = true,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isSelected = _selectedPlan == value;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: enabled ? () => setState(() => _selectedPlan = value) : null,
      mouseCursor: enabled
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: enabled
              ? (isSelected
                    ? colorScheme.primary.withValues(alpha: 0.08)
                    : colorScheme.surfaceContainer)
              : colorScheme.surfaceContainer.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: enabled
                ? (isSelected
                      ? colorScheme.primary
                      : colorScheme.outlineVariant)
                : colorScheme.outlineVariant.withValues(alpha: 0.4),
            width: isSelected ? 2.0 : 1.0,
          ),
        ),
        child: Row(
          children: [
            MechanixRadio<String>(
              value: value,
              groupValue: _selectedPlan,
              enabled: enabled,
              onChanged: enabled
                  ? (v) => setState(() => _selectedPlan = v!)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: enabled
                              ? colorScheme.onSurface
                              : colorScheme.onSurface.withValues(alpha: 0.38),
                        ),
                      ),
                      if (isPopular) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'POPULAR',
                            style: textTheme.labelSmall?.copyWith(
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: textTheme.bodySmall?.copyWith(
                      color: enabled
                          ? colorScheme.onSurfaceVariant
                          : colorScheme.onSurface.withValues(alpha: 0.38),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Text(
              price,
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: enabled
                    ? colorScheme.primary
                    : colorScheme.onSurface.withValues(alpha: 0.38),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
