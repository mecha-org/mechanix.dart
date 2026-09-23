import 'package:flutter/material.dart';

import 'icon_button_enums.dart';
import 'icon_button_size.dart';
import 'icon_button_style.dart';
import 'icon_button_theme.dart';

export 'icon_button_enums.dart';
export 'icon_button_size.dart';
export 'icon_button_style.dart';
export 'icon_button_theme.dart';

/// A highly customizable Icon Button component following the
/// Mechanix design system specifications.
class MechanixIconButton extends StatelessWidget {
  const MechanixIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.selectedIcon,
    this.isSelected,
    this.onLongPress,
    this.type = IconButtonType.square,
    this.variant = IconButtonVariant.filled,
    this.size = IconButtonSize.medium,
    this.showFocusIndicator = true,
    this.focusNode,
    this.autofocus = false,
    this.duration = const Duration(milliseconds: 200),
    this.curve = const Cubic(0.2, 0.0, 0.0, 1.0),
    this.backgroundColor,
    this.hoverColor,
    this.pressedColor,
    this.disabledColor,
    this.foregroundColor,
    this.hoverForegroundColor,
    this.pressedForegroundColor,
    this.disabledForegroundColor,
    this.borderColor,
    this.borderWidth,
    this.focusBorderColor,
    this.selectedBackgroundColor,
    this.selectedHoverColor,
    this.selectedPressedColor,
    this.selectedForegroundColor,
    this.selectedHoverForegroundColor,
    this.selectedPressedForegroundColor,
    this.selectedBorderColor,
    this.theme,
  });

  /// Factory constructor for a Filled [MechanixIconButton].
  const MechanixIconButton.filled({
    super.key,
    required this.onPressed,
    required this.icon,
    this.selectedIcon,
    this.isSelected,
    this.onLongPress,
    this.type = IconButtonType.square,
    this.size = IconButtonSize.medium,
    this.showFocusIndicator = true,
    this.focusNode,
    this.autofocus = false,
    this.duration = const Duration(milliseconds: 200),
    this.curve = const Cubic(0.2, 0.0, 0.0, 1.0),
    this.backgroundColor,
    this.hoverColor,
    this.pressedColor,
    this.disabledColor,
    this.foregroundColor,
    this.hoverForegroundColor,
    this.pressedForegroundColor,
    this.disabledForegroundColor,
    this.borderColor,
    this.borderWidth,
    this.focusBorderColor,
    this.selectedBackgroundColor,
    this.selectedHoverColor,
    this.selectedPressedColor,
    this.selectedForegroundColor,
    this.selectedHoverForegroundColor,
    this.selectedPressedForegroundColor,
    this.selectedBorderColor,
    this.theme,
  }) : variant = IconButtonVariant.filled;

  /// Factory constructor for a Tonal [MechanixIconButton].
  const MechanixIconButton.tonal({
    super.key,
    required this.onPressed,
    required this.icon,
    this.selectedIcon,
    this.isSelected,
    this.onLongPress,
    this.type = IconButtonType.square,
    this.size = IconButtonSize.medium,
    this.showFocusIndicator = true,
    this.focusNode,
    this.autofocus = false,
    this.duration = const Duration(milliseconds: 200),
    this.curve = const Cubic(0.2, 0.0, 0.0, 1.0),
    this.backgroundColor,
    this.hoverColor,
    this.pressedColor,
    this.disabledColor,
    this.foregroundColor,
    this.hoverForegroundColor,
    this.pressedForegroundColor,
    this.disabledForegroundColor,
    this.borderColor,
    this.borderWidth,
    this.focusBorderColor,
    this.selectedBackgroundColor,
    this.selectedHoverColor,
    this.selectedPressedColor,
    this.selectedForegroundColor,
    this.selectedHoverForegroundColor,
    this.selectedPressedForegroundColor,
    this.selectedBorderColor,
    this.theme,
  }) : variant = IconButtonVariant.tonal;

  /// Factory constructor for an Outline [MechanixIconButton].
  const MechanixIconButton.outline({
    super.key,
    required this.onPressed,
    required this.icon,
    this.selectedIcon,
    this.isSelected,
    this.onLongPress,
    this.type = IconButtonType.square,
    this.size = IconButtonSize.medium,
    this.showFocusIndicator = true,
    this.focusNode,
    this.autofocus = false,
    this.duration = const Duration(milliseconds: 200),
    this.curve = const Cubic(0.2, 0.0, 0.0, 1.0),
    this.backgroundColor,
    this.hoverColor,
    this.pressedColor,
    this.disabledColor,
    this.foregroundColor,
    this.hoverForegroundColor,
    this.pressedForegroundColor,
    this.disabledForegroundColor,
    this.borderColor,
    this.borderWidth,
    this.focusBorderColor,
    this.selectedBackgroundColor,
    this.selectedHoverColor,
    this.selectedPressedColor,
    this.selectedForegroundColor,
    this.selectedHoverForegroundColor,
    this.selectedPressedForegroundColor,
    this.selectedBorderColor,
    this.theme,
  }) : variant = IconButtonVariant.outline;

  /// Factory constructor for a Standard [MechanixIconButton].
  const MechanixIconButton.standard({
    super.key,
    required this.onPressed,
    required this.icon,
    this.selectedIcon,
    this.isSelected,
    this.onLongPress,
    this.type = IconButtonType.square,
    this.size = IconButtonSize.medium,
    this.showFocusIndicator = true,
    this.focusNode,
    this.autofocus = false,
    this.duration = const Duration(milliseconds: 200),
    this.curve = const Cubic(0.2, 0.0, 0.0, 1.0),
    this.backgroundColor,
    this.hoverColor,
    this.pressedColor,
    this.disabledColor,
    this.foregroundColor,
    this.hoverForegroundColor,
    this.pressedForegroundColor,
    this.disabledForegroundColor,
    this.borderColor,
    this.borderWidth,
    this.focusBorderColor,
    this.selectedBackgroundColor,
    this.selectedHoverColor,
    this.selectedPressedColor,
    this.selectedForegroundColor,
    this.selectedHoverForegroundColor,
    this.selectedPressedForegroundColor,
    this.selectedBorderColor,
    this.theme,
  }) : variant = IconButtonVariant.standard;

  /// Callback when button is clicked. If null, button is disabled.
  final VoidCallback? onPressed;

  /// Callback when button is long pressed.
  final VoidCallback? onLongPress;

  /// Icon widget or IconData to display when unselected or in normal push mode.
  final dynamic icon;

  /// Icon widget or IconData to display when [isSelected] is true.
  /// If null and [isSelected] is true, [icon] will be displayed.
  final dynamic selectedIcon;

  /// Whether this icon button is currently selected (toggled).
  ///
  /// If null, this button behaves as a standard push button.
  /// If true or false, this button behaves as a toggleable icon button.
  final bool? isSelected;

  /// Corner/shape style type ([IconButtonType.square], [rounded]).
  final IconButtonType type;

  /// Visual style variant ([IconButtonVariant.filled], [tonal], [outline], [standard]).
  final IconButtonVariant variant;

  /// Button scale size ([IconButtonSize.xSmall], [small], [medium], [large], [xLarge], [twoXLarge]).
  final IconButtonSize size;

  /// Controls whether focus border indicator outline is shown when focused.
  final bool showFocusIndicator;

  /// Optional FocusNode.
  final FocusNode? focusNode;

  /// Whether this button should auto focus on init.
  final bool autofocus;

  /// Hover/press/focus animation duration.
  final Duration duration;

  /// Hover/press/focus animation easing curve.
  final Curve curve;

  /// Background color overrides.
  final Color? backgroundColor;
  final Color? hoverColor;
  final Color? pressedColor;
  final Color? disabledColor;

  /// Foreground / Icon color overrides.
  final Color? foregroundColor;
  final Color? hoverForegroundColor;
  final Color? pressedForegroundColor;
  final Color? disabledForegroundColor;

  /// Border styling overrides.
  final Color? borderColor;
  final double? borderWidth;
  final Color? focusBorderColor;

  /// Selected state color overrides.
  final Color? selectedBackgroundColor;
  final Color? selectedHoverColor;
  final Color? selectedPressedColor;
  final Color? selectedForegroundColor;
  final Color? selectedHoverForegroundColor;
  final Color? selectedPressedForegroundColor;
  final Color? selectedBorderColor;

  /// Custom theme override for this button instance.
  final IconButtonThemeDataConfig? theme;

  bool get isEnabled => onPressed != null || onLongPress != null;

  @override
  Widget build(BuildContext context) {
    final mergedTheme = MechanixIconButtonTheme.of(context).merge(theme);
    final sizeSpec = size.spec(context);

    final buttonStyle = IconButtonStyleResolver.createButtonStyle(
      context: context,
      variant: variant,
      type: type,
      sizeSpec: sizeSpec,
      isToggleable: isSelected != null,
      theme: mergedTheme,
      customBackgroundColor: backgroundColor,
      customHoverColor: hoverColor,
      customPressedColor: pressedColor,
      customDisabledColor: disabledColor,
      customForegroundColor: foregroundColor,
      customHoverForegroundColor: hoverForegroundColor,
      customPressedForegroundColor: pressedForegroundColor,
      customDisabledForegroundColor: disabledForegroundColor,
      customBorderColor: borderColor,
      customBorderWidth: borderWidth,
      customFocusBorderColor: focusBorderColor,
      customSelectedBackgroundColor: selectedBackgroundColor,
      customSelectedHoverColor: selectedHoverColor,
      customSelectedPressedColor: selectedPressedColor,
      customSelectedForegroundColor: selectedForegroundColor,
      customSelectedHoverForegroundColor: selectedHoverForegroundColor,
      customSelectedPressedForegroundColor: selectedPressedForegroundColor,
      customSelectedBorderColor: selectedBorderColor,
      duration: duration,
      curve: curve,
      showFocusIndicator: showFocusIndicator,
    );

    final iconWidget = _buildIcon(mergedTheme, sizeSpec, icon);
    final selectedIconWidget = selectedIcon != null
        ? _buildIcon(mergedTheme, sizeSpec, selectedIcon)
        : null;

    Widget buttonWidget;
    switch (variant) {
      case IconButtonVariant.filled:
        buttonWidget = IconButton.filled(
          onPressed: onPressed,
          focusNode: focusNode,
          autofocus: autofocus,
          style: buttonStyle,
          isSelected: isSelected,
          selectedIcon: selectedIconWidget,
          icon: iconWidget,
        );
        break;
      case IconButtonVariant.tonal:
        buttonWidget = IconButton.filledTonal(
          onPressed: onPressed,
          focusNode: focusNode,
          autofocus: autofocus,
          style: buttonStyle,
          isSelected: isSelected,
          selectedIcon: selectedIconWidget,
          icon: iconWidget,
        );
        break;
      case IconButtonVariant.outline:
        buttonWidget = IconButton.outlined(
          onPressed: onPressed,
          focusNode: focusNode,
          autofocus: autofocus,
          style: buttonStyle,
          isSelected: isSelected,
          selectedIcon: selectedIconWidget,
          icon: iconWidget,
        );
        break;
      case IconButtonVariant.standard:
        buttonWidget = IconButton(
          onPressed: onPressed,
          focusNode: focusNode,
          autofocus: autofocus,
          style: buttonStyle,
          isSelected: isSelected,
          selectedIcon: selectedIconWidget,
          icon: iconWidget,
        );
        break;
    }

    if (onLongPress != null) {
      buttonWidget = GestureDetector(
        behavior: HitTestBehavior.translucent,
        onLongPress: onLongPress,
        child: buttonWidget,
      );
    }

    buttonWidget = SizedBox(
      width: sizeSpec.dimension,
      height: sizeSpec.dimension,
      child: buttonWidget,
    );

    if (sizeSpec.minTapTargetSize > 0) {
      buttonWidget = GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onPressed,
        onLongPress: onLongPress,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: sizeSpec.minTapTargetSize,
            minHeight: sizeSpec.minTapTargetSize,
          ),
          child: Center(
            widthFactor: 1.0,
            heightFactor: 1.0,
            child: buttonWidget,
          ),
        ),
      );
    }

    return buttonWidget;
  }

  Widget _buildIcon(
    IconButtonThemeDataConfig theme,
    IconButtonSizeConfig sizeSpec,
    dynamic targetIcon,
  ) {
    final targetIconSize = theme.iconSize ?? sizeSpec.iconSize;
    if (targetIcon is Widget) {
      return IconTheme.merge(
        data: IconThemeData(size: targetIconSize),
        child: targetIcon,
      );
    } else if (targetIcon is IconData) {
      return Icon(targetIcon, size: targetIconSize);
    }
    return const SizedBox.shrink();
  }
}
