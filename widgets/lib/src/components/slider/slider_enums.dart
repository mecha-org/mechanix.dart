/// Visual variants of the [MechanixSlider].
enum MechanixSliderVariant {
  /// Fills from the minimum value up to the current value.
  standard,

  /// Fills outwards from the midpoint of the range to the current value.
  ///
  /// Not implemented yet.
  centered,

  /// Two pointers selecting a start and end value.
  ///
  /// Not implemented yet.
  range,
}

/// Pre-set sizing scale of the [MechanixSlider].
enum MechanixSliderSize { xSmall, small, medium, large, xLarge }
