import '../button/button_enums.dart';

/// Defines the visual variant of the [MechanixIconButton].
enum IconButtonVariant {
  /// Filled background button style with primary color.
  filled,

  /// Tonal background button style with secondary color.
  tonal,

  /// Outlined border button style with surface variant background.
  outline,

  /// Standard icon button style with transparent background.
  standard,
}

/// Defines the pre-set sizing scale of the [MechanixIconButton].
enum IconButtonSize {
  /// 32x32 button dimension, 20px icon size, min tap target 48x48.
  xSmall,

  /// 40x40 button dimension, 24px icon size, min tap target 48x48.
  small,

  /// 56x56 button dimension, 24px icon size.
  medium,

  /// 72x72 button dimension, 30.86px icon size.
  large,

  /// 96x96 button dimension, 32px icon size.
  xLarge,

  /// 136x136 button dimension, 40px icon size.
  xxLarge,
}

/// Alias for [ButtonType] to define corner/shape style.
typedef IconButtonType = ButtonType;
