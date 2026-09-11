import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

/// Design system catalog page demonstrating all states and options of [MechanixSwitch].
class SwitchPreview extends StatefulWidget {
  const SwitchPreview({super.key});

  @override
  State<SwitchPreview> createState() => _SwitchPreviewState();
}

class _SwitchPreviewState extends State<SwitchPreview> {
  bool _switchVal1 = false;
  bool _customVal1 = true;
  bool _customVal2 = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Page Header
        _buildPageHeader(context),
        const SizedBox(height: 24),

        // 2. Interactive Switch
        _buildInteractiveSection(context),
        const SizedBox(height: 32),

        // 3. States Matrix Section (Enabled, Hovered, Focused, Pressed, Disabled)
        _buildStatesMatrixSection(context),
        const SizedBox(height: 32),

        // 4. Custom Theme / Label Overrides
        _buildCustomizationsSection(context),
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
            Icons.toggle_on_outlined,
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
                'Switch',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                'Mechanix Toggle Switch Component with 88x40 Visual Track, 96x48 Hug Container & Focused Border, and State-Aware Colors',
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

  Widget _buildInteractiveSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Interactive Switch',
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
              spacing: 32,
              runSpacing: 20,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MechanixSwitch(
                      value: _switchVal1,
                      onChanged: (val) => setState(() => _switchVal1 = val),
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

  Widget _buildStatesMatrixSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Interactive States',
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
                  'OFF State Overview',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 24,
                  runSpacing: 16,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _buildStateSample(
                      context,
                      label: 'OFF Enabled',
                      widget: MechanixSwitch(value: false, onChanged: (_) {}),
                    ),
                    _buildStateSample(
                      context,
                      label: 'OFF Disabled',
                      widget: const MechanixSwitch(
                        value: false,
                        onChanged: null,
                      ),
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
                  'ON State Overview',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 24,
                  runSpacing: 16,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _buildStateSample(
                      context,
                      label: 'ON Enabled',
                      widget: MechanixSwitch(value: true, onChanged: (_) {}),
                    ),
                    _buildStateSample(
                      context,
                      label: 'ON Disabled',
                      widget: const MechanixSwitch(
                        value: true,
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

  Widget _buildStateSample(
    BuildContext context, {
    required String label,
    required Widget widget,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 6),
        widget,
      ],
    );
  }

  Widget _buildCustomizationsSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Labels & Custom Theme Overrides',
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
              spacing: 32,
              runSpacing: 20,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                _buildStateSample(
                  context,
                  label: 'Custom Labels (YES / NO)',
                  widget: MechanixSwitch(
                    value: _customVal1,
                    labelOn: 'YES',
                    labelOff: 'NO',
                    onChanged: (val) => setState(() => _customVal1 = val),
                  ),
                ),
                _buildStateSample(
                  context,
                  label: 'No Internal Text Label',
                  widget: MechanixSwitch(
                    value: _customVal2,
                    showLabel: false,
                    onChanged: (val) => setState(() => _customVal2 = val),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
