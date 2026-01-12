import 'package:flutter/material.dart';

extension ColorExtension on BuildContext {
  Color get primary => Theme.of(this).colorScheme.primary;

  Color get onPrimary => Theme.of(this).colorScheme.onPrimary;

  Color get primaryContainer => Theme.of(this).colorScheme.primaryContainer;

  Color get primaryFixed => Theme.of(this).colorScheme.primaryFixed;

  Color get onPrimaryFixed => Theme.of(this).colorScheme.onPrimaryFixed;

  Color get primaryFixedDim => Theme.of(this).colorScheme.primaryFixedDim;

  Color get onPrimaryFixedVariant =>
      Theme.of(this).colorScheme.onPrimaryFixedVariant;

  Color get secondary => Theme.of(this).colorScheme.secondary;

  Color get onSecondary => Theme.of(this).colorScheme.onSecondary;

  Color get secondaryContainer => Theme.of(this).colorScheme.secondaryContainer;

  Color get secondaryFixed => Theme.of(this).colorScheme.secondaryFixed;

  Color get onSecondaryFixed => Theme.of(this).colorScheme.onSecondaryFixed;

  Color get secondaryFixedDim => Theme.of(this).colorScheme.secondaryFixedDim;

  Color get onSecondaryFixedVariant =>
      Theme.of(this).colorScheme.onSecondaryFixedVariant;

  Color get tertiary => Theme.of(this).colorScheme.tertiary;

  Color get tertiaryFixedDim => Theme.of(this).colorScheme.tertiaryFixedDim;

  Color get outline => Theme.of(this).colorScheme.outline;

  Color get surface => Theme.of(this).colorScheme.surface;

  Color get surfaceDim => Theme.of(this).colorScheme.surfaceDim;

  Color get onSurface => Theme.of(this).colorScheme.onSurface;

  Color get surfaceContainer => Theme.of(this).colorScheme.surfaceContainer;

  Color get surfaceContainerHighest =>
      Theme.of(this).colorScheme.surfaceContainerHighest;

  Color get onSurfaceVariant => Theme.of(this).colorScheme.onSurfaceVariant;

  Color get error => Theme.of(this).colorScheme.error;

  Color get errorContainer => Theme.of(this).colorScheme.errorContainer;

  Color get scrim => Theme.of(this).colorScheme.scrim;

  Color get shadow => Theme.of(this).colorScheme.shadow;

  Color get tertiaryContainer => Theme.of(this).colorScheme.tertiaryContainer;

  Color get outlineVariant => Theme.of(this).colorScheme.outlineVariant;

  Color get onInverseSurface => Theme.of(this).colorScheme.onInverseSurface;

  Color get surfaceContainerHigh =>
      Theme.of(this).colorScheme.surfaceContainerHigh;

  Color get surfaceContainerLow =>
      Theme.of(this).colorScheme.surfaceContainerLow;
}
