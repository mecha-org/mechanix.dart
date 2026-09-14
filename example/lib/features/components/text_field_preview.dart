import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

/// A design-system documentation and showcase page demonstrating all variants,
/// states, and combinations of [MechanixTextField].
class TextFieldPreview extends StatelessWidget {
  const TextFieldPreview({super.key});

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

          MechanixTextField.filled(labelText: 'Enter your name'),
          SizedBox(height: 32),
          MechanixTextField.outlined(labelText: 'Enter your name'),
          // 2. Interactive Playground
          // _PlaygroundSection(),
          // SizedBox(height: 48),

          // 3. Reference Design Matrix (Mirroring the reference image)
          // _ReferenceMatrixSection(),
          // SizedBox(height: 48),

          // // 4. Form Validation Example
          // _FormExampleSection(),
          // SizedBox(height: 48),
        ],
      ),
    );
  }
}

// =============================================================================
// 1. PAGE HEADER
// =============================================================================

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
                'Text Fields',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Text(
                'Text fields allow users to enter text into a UI. They typically appear in forms and dialogs.',
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

// =============================================================================
// 2. INTERACTIVE PLAYGROUND
// =============================================================================

class _PlaygroundSection extends StatefulWidget {
  const _PlaygroundSection();

  @override
  State<_PlaygroundSection> createState() => _PlaygroundSectionState();
}

class _PlaygroundSectionState extends State<_PlaygroundSection> {
  MechanixTextFieldVariant _variant = MechanixTextFieldVariant.filled;
  bool _enabled = true;
  bool _showLabel = true;
  bool _showHint = true;
  bool _showHelper = true;
  bool _showPrefix = true;
  bool _showSuffix = true;
  bool _hasError = false;
  final TextEditingController _controller = TextEditingController(
    text: 'Input',
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Interactive Playground',
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'Experiment with variants, icons, labels, and validation states.',
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),

          // Controls
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              // Variant Choice
              SegmentedButton<MechanixTextFieldVariant>(
                segments: const [
                  ButtonSegment(
                    value: MechanixTextFieldVariant.filled,
                    label: Text('Filled'),
                  ),
                  ButtonSegment(
                    value: MechanixTextFieldVariant.outlined,
                    label: Text('Outlined'),
                  ),
                ],
                selected: {_variant},
                onSelectionChanged: (set) {
                  setState(() {
                    _variant = set.first;
                  });
                },
              ),

              // Filter Chips
              FilterChip(
                label: const Text('Enabled'),
                selected: _enabled,
                onSelected: (val) => setState(() => _enabled = val),
              ),
              FilterChip(
                label: const Text('Show Label'),
                selected: _showLabel,
                onSelected: (val) => setState(() => _showLabel = val),
              ),
              FilterChip(
                label: const Text('Show Hint'),
                selected: _showHint,
                onSelected: (val) => setState(() => _showHint = val),
              ),
              FilterChip(
                label: const Text('Supporting Text'),
                selected: _showHelper,
                onSelected: (val) => setState(() => _showHelper = val),
              ),
              FilterChip(
                label: const Text('Leading Icon'),
                selected: _showPrefix,
                onSelected: (val) => setState(() => _showPrefix = val),
              ),
              FilterChip(
                label: const Text('Trailing Clear'),
                selected: _showSuffix,
                onSelected: (val) => setState(() => _showSuffix = val),
              ),
              FilterChip(
                label: const Text('Error State'),
                selected: _hasError,
                selectedColor: colorScheme.error.withValues(alpha: 0.2),
                onSelected: (val) => setState(() => _hasError = val),
              ),
            ],
          ),
          const SizedBox(height: 28),

          // Rendered Preview
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: MechanixTextField(
                variant: _variant,
                controller: _controller,
                enabled: _enabled,
                labelText: _showLabel ? 'LABEL' : null,
                hintText: _showHint ? 'Placeholder text' : null,
                supportingText: _showHelper ? 'Supporting text' : null,
                errorText: _hasError ? 'This field has an error.' : null,
                prefixIcon: _showPrefix
                    ? const Icon(Icons.search_rounded)
                    : null,
                suffixIcon: _showSuffix
                    ? IconButton(
                        icon: const Icon(Icons.close_rounded, size: 20),
                        onPressed: () => _controller.clear(),
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// 3. REFERENCE DESIGN MATRIX
// =============================================================================

class _ReferenceMatrixSection extends StatelessWidget {
  const _ReferenceMatrixSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Component State Matrix',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          'Complete reference grid matching the design system specifications across all five interaction states.',
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 24),

        // 1. Filled Variants
        const _MatrixSubheader(
          title: 'Filled Variant (Underline Active Indicator)',
        ),
        const SizedBox(height: 12),
        const _StateMatrixTable(variant: MechanixTextFieldVariant.filled),

        const SizedBox(height: 36),

        // 2. Outlined Variants
        const _MatrixSubheader(
          title: 'Outlined Variant (4-Sided Outline Border)',
        ),
        const SizedBox(height: 12),
        const _StateMatrixTable(variant: MechanixTextFieldVariant.outlined),
      ],
    );
  }
}

class _MatrixSubheader extends StatelessWidget {
  const _MatrixSubheader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _StateMatrixTable extends StatelessWidget {
  const _StateMatrixTable({required this.variant});

  final MechanixTextFieldVariant variant;

  static const List<String> _columnHeaders = [
    'Default / Resting',
    'Focused',
    'Hovered',
    'Error',
    'Disabled',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                const SizedBox(width: 140), // Row label gutter
                for (final header in _columnHeaders)
                  Container(
                    width: 210,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    child: Text(
                      header,
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: header == 'Focused'
                            ? colorScheme.primary
                            : header == 'Error'
                            ? colorScheme.error
                            : colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 16),

            // Group A: Without Leading Icon
            _MatrixRow(
              rowTitle: 'Input + Trailing',
              variant: variant,
              hasLeading: false,
              hasTrailing: true,
              hasText: true,
            ),
            const SizedBox(height: 16),
            _MatrixRow(
              rowTitle: 'Resting Label',
              variant: variant,
              hasLeading: false,
              hasTrailing: false,
              hasText: false,
            ),
            const SizedBox(height: 16),
            _MatrixRow(
              rowTitle: 'Placeholder',
              variant: variant,
              hasLeading: false,
              hasTrailing: true,
              hasPlaceholder: true,
            ),

            const SizedBox(height: 24),
            const Divider(height: 1),
            const SizedBox(height: 24),

            // Group B: With Leading Icon
            _MatrixRow(
              rowTitle: 'Leading + Input',
              variant: variant,
              hasLeading: true,
              hasTrailing: true,
              hasText: true,
            ),
            const SizedBox(height: 16),
            _MatrixRow(
              rowTitle: 'Leading + Label',
              variant: variant,
              hasLeading: true,
              hasTrailing: false,
              hasText: false,
            ),
            const SizedBox(height: 16),
            _MatrixRow(
              rowTitle: 'Leading + Placeholder',
              variant: variant,
              hasLeading: true,
              hasTrailing: true,
              hasPlaceholder: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _MatrixRow extends StatelessWidget {
  const _MatrixRow({
    required this.rowTitle,
    required this.variant,
    required this.hasLeading,
    required this.hasTrailing,
    this.hasText = false,
    this.hasPlaceholder = false,
  });

  final String rowTitle;
  final MechanixTextFieldVariant variant;
  final bool hasLeading;
  final bool hasTrailing;
  final bool hasText;
  final bool hasPlaceholder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        // Gutter label
        SizedBox(
          width: 140,
          child: Text(
            rowTitle,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),

        // 1. Default / Resting
        _MatrixItem(
          variant: variant,
          hasLeading: hasLeading,
          hasTrailing: hasTrailing,
          hasText: hasText,
          hasPlaceholder: hasPlaceholder,
        ),

        // 2. Focused
        _MatrixItem(
          variant: variant,
          hasLeading: hasLeading,
          hasTrailing: hasTrailing,
          hasText: hasText,
          hasPlaceholder: hasPlaceholder,
          isFocused: true,
        ),

        // 3. Hovered
        _MatrixItem(
          variant: variant,
          hasLeading: hasLeading,
          hasTrailing: hasTrailing,
          hasText: hasText,
          hasPlaceholder: hasPlaceholder,
          isHovered: true,
        ),

        // 4. Error
        _MatrixItem(
          variant: variant,
          hasLeading: hasLeading,
          hasTrailing: hasTrailing,
          hasText: hasText,
          hasPlaceholder: hasPlaceholder,
          errorText: 'Supporting text',
          isError: true,
        ),

        // 5. Disabled
        _MatrixItem(
          variant: variant,
          hasLeading: hasLeading,
          hasTrailing: hasTrailing,
          hasText: hasText,
          hasPlaceholder: hasPlaceholder,
          enabled: false,
        ),
      ],
    );
  }
}

class _MatrixItem extends StatelessWidget {
  const _MatrixItem({
    required this.variant,
    required this.hasLeading,
    required this.hasTrailing,
    this.hasText = false,
    this.hasPlaceholder = false,
    this.enabled = true,
    this.isError = false,
    this.isFocused = false,
    this.isHovered = false,
    this.errorText,
  });

  final MechanixTextFieldVariant variant;
  final bool hasLeading;
  final bool hasTrailing;
  final bool hasText;
  final bool hasPlaceholder;
  final bool enabled;
  final bool isError;
  final bool isFocused;
  final bool isHovered;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final iconColor = isError
        ? colorScheme.error
        : (!enabled
              ? colorScheme.onSurface.withValues(alpha: 0.38)
              : colorScheme.onSurfaceVariant);

    TextFieldThemeDataConfig? themeOverride;
    if (isFocused) {
      themeOverride = TextFieldThemeDataConfig(
        borderColor: WidgetStatePropertyAll(colorScheme.primary),
        borderWidth: const WidgetStatePropertyAll(2.0),
        floatingLabelStyle: TextStyle(color: colorScheme.primary),
      );
    } else if (isHovered) {
      themeOverride = TextFieldThemeDataConfig(
        borderColor: WidgetStatePropertyAll(colorScheme.onSurface),
        borderWidth: const WidgetStatePropertyAll(1.0),
      );
    }

    return Container(
      width: 210,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: MechanixTextField(
        variant: variant,
        enabled: enabled,
        labelText: hasPlaceholder ? 'LABEL' : (hasText ? 'LABEL' : 'Label'),
        hintText: hasPlaceholder ? 'Placeholder' : null,
        supportingText: isError ? null : 'Supporting text',
        errorText: errorText,
        theme: themeOverride,
        controller: hasText ? TextEditingController(text: 'Input') : null,
        prefixIcon: hasLeading
            ? Icon(Icons.search_rounded, size: 20, color: iconColor)
            : null,
        suffixIcon: isError
            ? Icon(Icons.error_outline_rounded, size: 20, color: iconColor)
            : (hasTrailing
                  ? Icon(Icons.close_rounded, size: 18, color: iconColor)
                  : null),
      ),
    );
  }
}

// =============================================================================
// 4. FORM INTEGRATION & VALIDATION
// =============================================================================

class _FormExampleSection extends StatefulWidget {
  const _FormExampleSection();

  @override
  State<_FormExampleSection> createState() => _FormExampleSectionState();
}

class _FormExampleSectionState extends State<_FormExampleSection> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _formStatus;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Form Integration & Validation',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'MechanixTextFormField integrates seamlessly with Flutter FormState and validators.',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),

            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                children: [
                  MechanixTextFormField(
                    controller: _emailController,
                    labelText: 'Work Email',
                    hintText: 'name@company.com',
                    prefixIcon: const Icon(Icons.email_outlined),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email is required';
                      }
                      if (!value.contains('@')) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  MechanixTextFormField(
                    controller: _passwordController,
                    labelText: 'Password',
                    obscureText: true,
                    prefixIcon: const Icon(Icons.lock_outline),
                    supportingText: 'Must be at least 6 characters',
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      MechanixButton(
                        label: 'Submit Form',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _formStatus =
                                  'Form successfully submitted for ${_emailController.text}!';
                            });
                          } else {
                            setState(() {
                              _formStatus = null;
                            });
                          }
                        },
                      ),
                      const SizedBox(width: 12),
                      MechanixButton.outline(
                        label: 'Reset',
                        onPressed: () {
                          _formKey.currentState!.reset();
                          _emailController.clear();
                          _passwordController.clear();
                          setState(() {
                            _formStatus = null;
                          });
                        },
                      ),
                    ],
                  ),
                  if (_formStatus != null) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _formStatus!,
                              style: const TextStyle(color: Colors.green),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
