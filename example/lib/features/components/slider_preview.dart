import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

/// Design system catalog page demonstrating sizes, directions and states of [MechanixSlider].
class SliderPreview extends StatelessWidget {
  const SliderPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Page Header
        _buildPageHeader(context),
        const SizedBox(height: 24),

        // 2. Interactive Slider
        _buildSection(
          context,
          title: 'Interactive Slider',
          child: const _InteractiveSliderSample(),
        ),
        const SizedBox(height: 32),

        // 3. Size Tokens (horizontal)
        _buildSection(
          context,
          title: 'Size Tokens',
          child: const _SizesSectionSample(),
        ),
        const SizedBox(height: 32),

        // 4. Size Tokens (vertical)
        _buildSection(
          context,
          title: 'Vertical Direction',
          child: const _VerticalSectionSample(),
        ),
        const SizedBox(height: 32),

        // 5. States (Enabled, Disabled, Stepped)
        _buildSection(
          context,
          title: 'States',
          child: const _StatesSectionSample(),
        ),
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
          child: Icon(Icons.tune_rounded, size: 28, color: colorScheme.primary),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Slider',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                'Mechanix Tick Slider with 5 Size Tokens, Horizontal & Vertical Directions, and Accent Value Pointer',
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

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
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
            // Extra top padding leaves room for the value label painted
            // above the pointer while dragging.
            padding: const EdgeInsets.fromLTRB(20, 32, 20, 20),
            child: child,
          ),
        ),
      ],
    );
  }
}

class _SampleLabel extends StatelessWidget {
  const _SampleLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      label,
      style: theme.textTheme.labelMedium?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}

class _InteractiveSliderSample extends StatefulWidget {
  const _InteractiveSliderSample();

  @override
  State<_InteractiveSliderSample> createState() =>
      _InteractiveSliderSampleState();
}

class _InteractiveSliderSampleState extends State<_InteractiveSliderSample> {
  double _value = 50;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MechanixSlider(
          value: _value,
          onChanged: (v) => setState(() => _value = v),
        ),
        const SizedBox(height: 12),
        _SampleLabel(
          label: 'Value: ${_value.toStringAsFixed(1)}',
        ),
      ],
    );
  }
}

class _SizesSectionSample extends StatefulWidget {
  const _SizesSectionSample();

  @override
  State<_SizesSectionSample> createState() => _SizesSectionSampleState();
}

class _SizesSectionSampleState extends State<_SizesSectionSample> {
  final Map<MechanixSliderSize, double> _sizeValues = {
    for (final size in MechanixSliderSize.values) size: 50,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final size in MechanixSliderSize.values) ...[
          _SampleLabel(label: size.name),
          const SizedBox(height: 8),
          MechanixSlider(
            value: _sizeValues[size]!,
            size: size,
            onChanged: (v) => setState(() => _sizeValues[size] = v),
          ),
          const SizedBox(height: 24),
        ],
      ],
    );
  }
}

class _VerticalSectionSample extends StatefulWidget {
  const _VerticalSectionSample();

  @override
  State<_VerticalSectionSample> createState() => _VerticalSectionSampleState();
}

class _VerticalSectionSampleState extends State<_VerticalSectionSample> {
  double _verticalValue = 40;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: Row(
        children: [
          for (final size in MechanixSliderSize.values) ...[
            // Leaves room for the value label painted beside the pointer.
            const SizedBox(width: 32),
            MechanixSlider(
              value: _verticalValue,
              size: size,
              direction: Axis.vertical,
              onChanged: (v) => setState(() => _verticalValue = v),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatesSectionSample extends StatefulWidget {
  const _StatesSectionSample();

  @override
  State<_StatesSectionSample> createState() => _StatesSectionSampleState();
}

class _StatesSectionSampleState extends State<_StatesSectionSample> {
  double _steppedValue = 60;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SampleLabel(label: 'Disabled'),
        const SizedBox(height: 8),
        const MechanixSlider(value: 50, onChanged: null),
        const SizedBox(height: 24),
        const _SampleLabel(label: 'Disabled (0 and 100)'),
        const SizedBox(height: 8),
        const MechanixSlider(value: 0, onChanged: null),
        const SizedBox(height: 8),
        const MechanixSlider(value: 100, onChanged: null),
        const SizedBox(height: 24),
        _SampleLabel(
          label: 'Divisions: 10 (value ${_steppedValue.round()})',
        ),
        const SizedBox(height: 8),
        MechanixSlider(
          value: _steppedValue,
          divisions: 10,
          labelFormatter: (v) => '${v.round()}%',
          onChanged: (v) => setState(() => _steppedValue = v),
        ),
      ],
    );
  }
}
