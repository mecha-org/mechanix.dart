import 'package:flutter/material.dart';

import 'divider_enums.dart';

class MechanixDivider extends StatelessWidget {
  /// Creates a horizontal [MechanixDivider].
  const MechanixDivider({
    super.key,
    this.space,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
    this.radius,
  }) : assert(space == null || space >= 0.0, 'space must be non-negative'),
       assert(
         thickness == null || thickness >= 0.0,
         'thickness must be non-negative',
       ),
       assert(indent == null || indent >= 0.0, 'indent must be non-negative'),
       assert(
         endIndent == null || endIndent >= 0.0,
         'endIndent must be non-negative',
       ),
       orientation = MechanixDividerOrientation.horizontal;

  /// Creates a vertical [MechanixDivider].
  ///
  /// Note: When placed inside a [Row], the row should be wrapped in an
  /// [IntrinsicHeight] or the divider must be given bounded height constraints.
  const MechanixDivider.vertical({
    super.key,
    this.space,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
    this.radius,
  }) : assert(space == null || space >= 0.0, 'space must be non-negative'),
       assert(
         thickness == null || thickness >= 0.0,
         'thickness must be non-negative',
       ),
       assert(indent == null || indent >= 0.0, 'indent must be non-negative'),
       assert(
         endIndent == null || endIndent >= 0.0,
         'endIndent must be non-negative',
       ),
       orientation = MechanixDividerOrientation.vertical;

  /// The orientation of this divider.
  final MechanixDividerOrientation orientation;

  /// The amount of space occupied by the divider.
  ///
  /// For horizontal dividers, this is the total height.
  /// For vertical dividers, this is the total width.
  ///
  /// Defaults to [DividerThemeData.space] or [MechanixSpacing.medium] (16.0).
  final double? space;

  /// The thickness of the line drawn within the divider.
  ///
  /// Defaults to [DividerThemeData.thickness] or 1.0.
  final double? thickness;

  /// The amount of empty space at the leading edge of the divider.
  ///
  /// Defaults to [DividerThemeData.indent] or 0.0.
  final double? indent;

  /// The amount of empty space at the trailing edge of the divider.
  ///
  /// Defaults to [DividerThemeData.endIndent] or 0.0.
  final double? endIndent;

  /// The color to use when painting the line.
  ///
  /// Defaults to [DividerThemeData.color], resolving to
  /// [ColorScheme.outlineVariant].
  final Color? color;

  /// The border radius applied to the divider corners.
  final BorderRadiusGeometry? radius;

  @override
  Widget build(BuildContext context) {
    if (orientation == MechanixDividerOrientation.vertical) {
      return VerticalDivider(
        width: space,
        thickness: thickness,
        indent: indent,
        endIndent: endIndent,
        color: color,
        radius: radius,
      );
    }

    return Divider(
      height: space,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
      color: color,
      radius: radius,
    );
  }
}

/// A convenience component for vertical dividers following the Mechanix design system.
///
/// Equivalent to [MechanixDivider.vertical]. When placed inside a [Row], the row
/// should be wrapped in an [IntrinsicHeight] or the divider must be given bounded
/// height constraints.
class MechanixVerticalDivider extends StatelessWidget {
  /// Creates a vertical Mechanix divider.
  const MechanixVerticalDivider({
    super.key,
    this.space,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
    this.radius,
  }) : assert(space == null || space >= 0.0, 'space must be non-negative'),
       assert(
         thickness == null || thickness >= 0.0,
         'thickness must be non-negative',
       ),
       assert(indent == null || indent >= 0.0, 'indent must be non-negative'),
       assert(
         endIndent == null || endIndent >= 0.0,
         'endIndent must be non-negative',
       );

  /// The horizontal space occupied by the divider.
  ///
  /// Defaults to [DividerThemeData.space] or [MechanixSpacing.medium] (16.0).
  final double? space;

  /// The thickness of the line drawn within the divider.
  ///
  /// Defaults to [DividerThemeData.thickness] or 1.0.
  final double? thickness;

  /// The amount of empty space at the top edge of the vertical divider.
  ///
  /// Defaults to [DividerThemeData.indent] or 0.0.
  final double? indent;

  /// The amount of empty space at the bottom edge of the vertical divider.
  ///
  /// Defaults to [DividerThemeData.endIndent] or 0.0.
  final double? endIndent;

  /// The color to use when painting the line.
  ///
  /// Defaults to [DividerThemeData.color], resolving to
  /// [ColorScheme.outlineVariant].
  final Color? color;

  /// The border radius applied to the divider corners.
  final BorderRadiusGeometry? radius;

  @override
  Widget build(BuildContext context) {
    return MechanixDivider.vertical(
      space: space,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
      color: color,
      radius: radius,
    );
  }
}
