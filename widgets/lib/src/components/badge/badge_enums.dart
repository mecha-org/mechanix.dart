import 'package:flutter/material.dart';

import 'badge.dart';

/// Semantic color variants for [MechanixBadge].
enum MechanixBadgeVariant {
  /// Alert and notification badge using [ColorScheme.error] and [ColorScheme.onError].
  ///
  /// This is the standard Material 3 default for notifications and alerts.
  error,

  /// Brand accent badge using [ColorScheme.primary] and [ColorScheme.onPrimary].
  primary,

  /// Subtle secondary container badge using [ColorScheme.secondaryContainer] and
  /// [ColorScheme.onSecondaryContainer].
  neutral,

  /// Surface container badge using [ColorScheme.surfaceContainerHigh] and
  /// [ColorScheme.onSurface].
  surface,
}
