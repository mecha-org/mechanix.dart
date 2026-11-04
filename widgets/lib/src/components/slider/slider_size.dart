import 'package:flutter/foundation.dart';

import 'slider_enums.dart';

/// Resolved dimensions (bar height, pointer height, tick and pointer widths)
/// corresponding to a given [MechanixSliderSize].
@immutable
class SliderSizeConfig {
  /// Length of each tick across the slider axis.
  final double barHeight;

  /// Length of the value pointer across the slider axis.
  ///
  /// The pointer is centered on the bar, so it overflows the bar by
  /// `(pointerHeight - barHeight) / 2` on each side.
  final double pointerHeight;

  /// Thickness of each tick along the slider axis.
  final double tickWidth;

  /// Space between two adjacent ticks along the slider axis.
  final double tickGap;

  /// Thickness of the value pointer along the slider axis.
  final double pointerWidth;

  const SliderSizeConfig({
    required this.barHeight,
    required this.pointerHeight,
    this.tickWidth = 2,
    this.tickGap = 4,
    this.pointerWidth = 2,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SliderSizeConfig &&
        barHeight == other.barHeight &&
        pointerHeight == other.pointerHeight &&
        tickWidth == other.tickWidth &&
        tickGap == other.tickGap &&
        pointerWidth == other.pointerWidth;
  }

  @override
  int get hashCode =>
      Object.hash(barHeight, pointerHeight, tickWidth, tickGap, pointerWidth);

  factory SliderSizeConfig.of(MechanixSliderSize size) {
    switch (size) {
      case MechanixSliderSize.xSmall:
        return const SliderSizeConfig(barHeight: 16, pointerHeight: 32);
      case MechanixSliderSize.small:
        return const SliderSizeConfig(barHeight: 24, pointerHeight: 36);
      case MechanixSliderSize.medium:
        return const SliderSizeConfig(barHeight: 40, pointerHeight: 52);
      case MechanixSliderSize.large:
        return const SliderSizeConfig(barHeight: 56, pointerHeight: 68);
      case MechanixSliderSize.xLarge:
        return const SliderSizeConfig(barHeight: 96, pointerHeight: 108);
    }
  }
}
