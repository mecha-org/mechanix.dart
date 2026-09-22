import 'package:flutter/material.dart';

import 'floating_action_button_enums.dart';

/// Resolved specifications (dimension, icon size) corresponding to a given
/// [MechanixFloatingActionButtonSize].
class FloatingActionButtonSizeConfig {
  /// Width and height of the floating action button.
  final double dimension;

  /// Default icon size for the button.
  final double iconSize;

  const FloatingActionButtonSizeConfig({
    required this.dimension,
    required this.iconSize,
  });

  /// Resolves the sizing configuration for a given [size].
  factory FloatingActionButtonSizeConfig.of(
    BuildContext context,
    MechanixFloatingActionButtonSize size,
  ) {
    switch (size) {
      case MechanixFloatingActionButtonSize.small:
        return const FloatingActionButtonSizeConfig(
          dimension: 56.0,
          iconSize: 24.0,
        );
      case MechanixFloatingActionButtonSize.medium:
        return const FloatingActionButtonSizeConfig(
          dimension: 80.0,
          iconSize: 32.0,
        );
      case MechanixFloatingActionButtonSize.large:
        return const FloatingActionButtonSizeConfig(
          dimension: 96.0,
          iconSize: 36.0,
        );
    }
  }
}

/// Extension on [MechanixFloatingActionButtonSize] for convenient access to its specifications.
extension MechanixFloatingActionButtonSizeExtension
    on MechanixFloatingActionButtonSize {
  /// Resolves the size specifications in the current [BuildContext].
  FloatingActionButtonSizeConfig spec(BuildContext context) {
    return FloatingActionButtonSizeConfig.of(context, this);
  }
}
