import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

/// A preview widget demonstrating the active Mechanix theme mode, brightness,
/// color scheme roles, and sample interactive components.
class ThemePreview extends StatelessWidget {
  const ThemePreview({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = MechanixTheme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.palette_outlined,
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
                    'Theme Overview',
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Reactive theme mode, resolved brightness, and color scheme roles',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Current Theme Status Card
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
                  'Reactive Theme State',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildStatusRow(
                  context,
                  label: 'Configured ThemeMode',
                  value: theme.mode.name.toUpperCase(),
                ),
                const SizedBox(height: 8),
                _buildStatusRow(
                  context,
                  label: 'Resolved Brightness',
                  value: theme.activeBrightness.name.toUpperCase(),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Color Palette Swatches
        Text(
          'Color Roles',
          style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildColorSection(
          context,
          title: 'Primary Roles',
          chips: [
            _buildColorChip(
              label: 'Primary',
              color: colorScheme.primary,
              textColor: colorScheme.onPrimary,
            ),
            _buildColorChip(
              label: 'On Primary',
              color: colorScheme.onPrimary,
              textColor: colorScheme.primary,
            ),
            _buildColorChip(
              label: 'Primary Container',
              color: colorScheme.primaryContainer,
              textColor: colorScheme.onPrimaryContainer,
            ),
            _buildColorChip(
              label: 'On Primary Container',
              color: colorScheme.onPrimaryContainer,
              textColor: colorScheme.primaryContainer,
            ),
            _buildColorChip(
              label: 'Primary Fixed',
              color: colorScheme.primaryFixed,
              textColor: colorScheme.onPrimaryFixed,
            ),
            _buildColorChip(
              label: 'Primary Fixed Dim',
              color: colorScheme.primaryFixedDim,
              textColor: colorScheme.onPrimaryFixedVariant,
            ),
            _buildColorChip(
              label: 'On Primary Fixed',
              color: colorScheme.onPrimaryFixed,
              textColor: colorScheme.primaryFixed,
            ),
            _buildColorChip(
              label: 'On Primary Fixed Variant',
              color: colorScheme.onPrimaryFixedVariant,
              textColor: colorScheme.primaryFixed,
            ),
            _buildColorChip(
              label: 'Inverse Primary',
              color: colorScheme.inversePrimary,
              textColor: colorScheme.inverseSurface,
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildColorSection(
          context,
          title: 'Secondary Roles',
          chips: [
            _buildColorChip(
              label: 'Secondary',
              color: colorScheme.secondary,
              textColor: colorScheme.onSecondary,
            ),
            _buildColorChip(
              label: 'On Secondary',
              color: colorScheme.onSecondary,
              textColor: colorScheme.secondary,
            ),
            _buildColorChip(
              label: 'Secondary Container',
              color: colorScheme.secondaryContainer,
              textColor: colorScheme.onSecondaryContainer,
            ),
            _buildColorChip(
              label: 'On Secondary Container',
              color: colorScheme.onSecondaryContainer,
              textColor: colorScheme.secondaryContainer,
            ),
            _buildColorChip(
              label: 'Secondary Fixed',
              color: colorScheme.secondaryFixed,
              textColor: colorScheme.onSecondaryFixed,
            ),
            _buildColorChip(
              label: 'Secondary Fixed Dim',
              color: colorScheme.secondaryFixedDim,
              textColor: colorScheme.onSecondaryFixedVariant,
            ),
            _buildColorChip(
              label: 'On Secondary Fixed',
              color: colorScheme.onSecondaryFixed,
              textColor: colorScheme.secondaryFixed,
            ),
            _buildColorChip(
              label: 'On Secondary Fixed Variant',
              color: colorScheme.onSecondaryFixedVariant,
              textColor: colorScheme.secondaryFixed,
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildColorSection(
          context,
          title: 'Tertiary Roles',
          chips: [
            _buildColorChip(
              label: 'Tertiary',
              color: colorScheme.tertiary,
              textColor: colorScheme.onTertiary,
            ),
            _buildColorChip(
              label: 'On Tertiary',
              color: colorScheme.onTertiary,
              textColor: colorScheme.tertiary,
            ),
            _buildColorChip(
              label: 'Tertiary Container',
              color: colorScheme.tertiaryContainer,
              textColor: colorScheme.onTertiaryContainer,
            ),
            _buildColorChip(
              label: 'On Tertiary Container',
              color: colorScheme.onTertiaryContainer,
              textColor: colorScheme.tertiaryContainer,
            ),
            _buildColorChip(
              label: 'Tertiary Fixed',
              color: colorScheme.tertiaryFixed,
              textColor: colorScheme.onTertiaryFixed,
            ),
            _buildColorChip(
              label: 'Tertiary Fixed Dim',
              color: colorScheme.tertiaryFixedDim,
              textColor: colorScheme.onTertiaryFixedVariant,
            ),
            _buildColorChip(
              label: 'On Tertiary Fixed',
              color: colorScheme.onTertiaryFixed,
              textColor: colorScheme.tertiaryFixed,
            ),
            _buildColorChip(
              label: 'On Tertiary Fixed Variant',
              color: colorScheme.onTertiaryFixedVariant,
              textColor: colorScheme.tertiaryFixed,
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildColorSection(
          context,
          title: 'Error Roles',
          chips: [
            _buildColorChip(
              label: 'Error',
              color: colorScheme.error,
              textColor: colorScheme.onError,
            ),
            _buildColorChip(
              label: 'On Error',
              color: colorScheme.onError,
              textColor: colorScheme.error,
            ),
            _buildColorChip(
              label: 'Error Container',
              color: colorScheme.errorContainer,
              textColor: colorScheme.onErrorContainer,
            ),
            _buildColorChip(
              label: 'On Error Container',
              color: colorScheme.onErrorContainer,
              textColor: colorScheme.errorContainer,
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildColorSection(
          context,
          title: 'Surface & Container Roles',
          chips: [
            _buildColorChip(
              label: 'Surface',
              color: colorScheme.surface,
              textColor: colorScheme.onSurface,
            ),
            _buildColorChip(
              label: 'On Surface',
              color: colorScheme.onSurface,
              textColor: colorScheme.surface,
            ),
            _buildColorChip(
              label: 'On Surface Variant',
              color: colorScheme.onSurfaceVariant,
            ),
            _buildColorChip(
              label: 'Surface Dim',
              color: colorScheme.surfaceDim,
              textColor: colorScheme.onSurface,
            ),
            _buildColorChip(
              label: 'Surface Bright',
              color: colorScheme.surfaceBright,
              textColor: colorScheme.onSurface,
            ),
            _buildColorChip(
              label: 'Surface Container Lowest',
              color: colorScheme.surfaceContainerLowest,
              textColor: colorScheme.onSurface,
            ),
            _buildColorChip(
              label: 'Surface Container Low',
              color: colorScheme.surfaceContainerLow,
              textColor: colorScheme.onSurface,
            ),
            _buildColorChip(
              label: 'Surface Container',
              color: colorScheme.surfaceContainer,
              textColor: colorScheme.onSurface,
            ),
            _buildColorChip(
              label: 'Surface Container High',
              color: colorScheme.surfaceContainerHigh,
              textColor: colorScheme.onSurface,
            ),
            _buildColorChip(
              label: 'Surface Container Highest',
              color: colorScheme.surfaceContainerHighest,
              textColor: colorScheme.onSurface,
            ),
            _buildColorChip(
              label: 'Inverse Surface',
              color: colorScheme.inverseSurface,
              textColor: colorScheme.onInverseSurface,
            ),
            _buildColorChip(
              label: 'On Inverse Surface',
              color: colorScheme.onInverseSurface,
              textColor: colorScheme.inverseSurface,
            ),
            _buildColorChip(
              label: 'Surface Tint',
              color: colorScheme.surfaceTint,
              textColor: colorScheme.onSurface,
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildColorSection(
          context,
          title: 'Outline & Other Roles',
          chips: [
            _buildColorChip(label: 'Outline', color: colorScheme.outline),
            _buildColorChip(
              label: 'Outline Variant',
              color: colorScheme.outlineVariant,
            ),
            _buildColorChip(label: 'Shadow', color: colorScheme.shadow),
            _buildColorChip(label: 'Scrim', color: colorScheme.scrim),
          ],
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildStatusRow(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    final theme = MechanixTheme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: theme.colorScheme.onSurfaceVariant,
              fontSize: 13,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildColorSection(
    BuildContext context, {
    required String title,
    required List<Widget> chips,
  }) {
    final theme = MechanixTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: theme.colorScheme.onSurfaceVariant,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(spacing: 12, runSpacing: 12, children: chips),
      ],
    );
  }

  Widget _buildColorChip({
    required String label,
    required Color color,
    Color? textColor,
  }) {
    final isDark =
        ThemeData.estimateBrightnessForColor(color) == Brightness.dark;
    final fallbackTextColor = isDark ? Colors.white : const Color(0xFF141415);

    Color effectiveTextColor = fallbackTextColor;
    if (textColor != null) {
      final textIsDark =
          ThemeData.estimateBrightnessForColor(textColor) == Brightness.dark;
      if (isDark != textIsDark) {
        effectiveTextColor = textColor;
      }
    }

    final borderColor = (isDark ? Colors.white : Colors.black).withValues(
      alpha: 0.12,
    );

    return Container(
      width: 155,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: effectiveTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            '#${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}',
            style: TextStyle(
              color: effectiveTextColor.withValues(alpha: 0.8),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
