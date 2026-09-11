import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

export 'button_enums.dart';
export 'button_size.dart';

/// A highly customizable button component following the
/// Mechanix design system specifications, wrapping Flutter Material's
/// [FilledButton], [OutlinedButton], and [TextButton].
class MechanixButton extends StatelessWidget {
  const MechanixButton({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.label,
    this.labelText,
    this.icon,
    this.showIcon = true,
    this.type = ButtonType.square,
    this.variant = ButtonVariant.filled,
    this.size = ButtonSize.medium,
    this.widthSizing = ButtonLayoutSizing.hug,
    this.heightSizing = ButtonLayoutSizing.hug,
    this.width,
    this.height,
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
    this.theme,
  });

  /// Factory constructor for a Filled [MechanixButton].
  const MechanixButton.filled({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.label,
    this.labelText,
    this.icon,
    this.showIcon = true,
    this.type = ButtonType.square,
    this.size = ButtonSize.medium,
    this.widthSizing = ButtonLayoutSizing.hug,
    this.heightSizing = ButtonLayoutSizing.hug,
    this.width,
    this.height,
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
    this.theme,
  }) : variant = ButtonVariant.filled;

  /// Factory constructor for an Outline [MechanixButton].
  const MechanixButton.outline({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.label,
    this.labelText,
    this.icon,
    this.showIcon = true,
    this.type = ButtonType.square,
    this.size = ButtonSize.medium,
    this.widthSizing = ButtonLayoutSizing.hug,
    this.heightSizing = ButtonLayoutSizing.hug,
    this.width,
    this.height,
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
    this.theme,
  }) : variant = ButtonVariant.outline;

  /// Alias constructor for an Outline [MechanixButton].
  const MechanixButton.outlined({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.label,
    this.labelText,
    this.icon,
    this.showIcon = true,
    this.type = ButtonType.square,
    this.size = ButtonSize.medium,
    this.widthSizing = ButtonLayoutSizing.hug,
    this.heightSizing = ButtonLayoutSizing.hug,
    this.width,
    this.height,
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
    this.theme,
  }) : variant = ButtonVariant.outline;

  /// Factory constructor for a Text [MechanixButton].
  const MechanixButton.text({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.label,
    this.labelText,
    this.icon,
    this.showIcon = true,
    this.type = ButtonType.square,
    this.size = ButtonSize.medium,
    this.widthSizing = ButtonLayoutSizing.hug,
    this.heightSizing = ButtonLayoutSizing.hug,
    this.width,
    this.height,
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
    this.theme,
  }) : variant = ButtonVariant.text;

  /// Callback when button is clicked. If null, button is disabled.
  final VoidCallback? onPressed;

  /// Callback when button is long pressed.
  final VoidCallback? onLongPress;

  /// String label text.
  final String? label;

  /// Custom Widget label text (overrides [label] string if provided).
  final Widget? labelText;

  /// Icon widget or IconData to display.
  final dynamic icon;

  /// Controls whether the icon should be displayed. Defaults to true.
  final bool showIcon;

  /// Corner/shape style type ([ButtonType.square], [rounded]).
  final ButtonType type;

  /// Visual style variant ([ButtonVariant.filled], [outline], [text]).
  final ButtonVariant variant;

  /// Button scale size ([ButtonSize.xSmall], [small], [medium], [large], [xLarge]).
  final ButtonSize size;

  /// Width sizing strategy (hug, fill, fixed).
  final ButtonLayoutSizing widthSizing;

  /// Height sizing strategy (hug, fill, fixed).
  final ButtonLayoutSizing heightSizing;

  /// Explicit width when [widthSizing] is fixed.
  final double? width;

  /// Explicit height when [heightSizing] is fixed.
  final double? height;

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

  /// Foreground / Text / Icon color overrides.
  final Color? foregroundColor;
  final Color? hoverForegroundColor;
  final Color? pressedForegroundColor;
  final Color? disabledForegroundColor;

  /// Border styling overrides.
  final Color? borderColor;
  final double? borderWidth;
  final Color? focusBorderColor;

  /// Custom theme override for this button instance.
  final ButtonThemeDataConfig? theme;

  bool get isEnabled => onPressed != null || onLongPress != null;

  (double?, double?) _resolveDimensions(double defaultHeight) {
    double? resolvedWidth;
    if (widthSizing == ButtonLayoutSizing.fill) {
      resolvedWidth = double.infinity;
    } else if (widthSizing == ButtonLayoutSizing.fixed) {
      resolvedWidth = width;
    }

    double? resolvedHeight;
    if (heightSizing == ButtonLayoutSizing.fill) {
      resolvedHeight = double.infinity;
    } else if (heightSizing == ButtonLayoutSizing.fixed) {
      resolvedHeight = height;
    } else {
      resolvedHeight = height ?? defaultHeight;
    }

    return (resolvedWidth, resolvedHeight);
  }

  @override
  Widget build(BuildContext context) {
    final mergedTheme = MechanixButtonTheme.of(context).merge(theme);
    final sizeSpec = size.spec(context);

    final buttonStyle = ButtonStyleResolver.createButtonStyle(
      context: context,
      variant: variant,
      type: type,
      sizeSpec: sizeSpec,
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
      duration: duration,
      curve: curve,
      showFocusIndicator: showFocusIndicator,
    );

    final buttonChild = Builder(
      builder: (context) => _buildContent(context, mergedTheme, sizeSpec),
    );

    Widget buttonWidget;
    switch (variant) {
      case ButtonVariant.filled:
        buttonWidget = FilledButton(
          onPressed: onPressed,
          onLongPress: onLongPress,
          focusNode: focusNode,
          autofocus: autofocus,
          style: buttonStyle,
          child: buttonChild,
        );
        break;
      case ButtonVariant.outline:
        buttonWidget = OutlinedButton(
          onPressed: onPressed,
          onLongPress: onLongPress,
          focusNode: focusNode,
          autofocus: autofocus,
          style: buttonStyle,
          child: buttonChild,
        );
        break;
      case ButtonVariant.text:
        buttonWidget = TextButton(
          onPressed: onPressed,
          onLongPress: onLongPress,
          focusNode: focusNode,
          autofocus: autofocus,
          style: buttonStyle,
          child: buttonChild,
        );
        break;
    }

    final (resolvedWidth, resolvedHeight) = _resolveDimensions(sizeSpec.height);

    Widget resultWidget = buttonWidget;

    if (resolvedWidth != null || resolvedHeight != null) {
      resultWidget = SizedBox(
        width: resolvedWidth,
        height: resolvedHeight,
        child: resultWidget,
      );
    }

    if (sizeSpec.minTapTargetSize > 0) {
      resultWidget = GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onPressed,
        onLongPress: onLongPress,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: sizeSpec.minTapTargetSize,
            minHeight: sizeSpec.minTapTargetSize,
          ),
          child: Center(
            widthFactor: widthSizing == ButtonLayoutSizing.hug ? 1.0 : null,
            heightFactor: heightSizing == ButtonLayoutSizing.hug ? 1.0 : null,
            child: resultWidget,
          ),
        ),
      );
    } else if (widthSizing == ButtonLayoutSizing.hug ||
        heightSizing == ButtonLayoutSizing.hug) {
      resultWidget = Center(
        widthFactor: widthSizing == ButtonLayoutSizing.hug ? 1.0 : null,
        heightFactor: heightSizing == ButtonLayoutSizing.hug ? 1.0 : null,
        child: resultWidget,
      );
    }

    return resultWidget;
  }

  Widget _buildContent(
    BuildContext context,
    ButtonThemeDataConfig theme,
    ButtonSizeConfig sizeSpec,
  ) {
    final iconWidget = _buildIcon(theme, sizeSpec);
    final textWidget = _buildText(context, theme, sizeSpec);

    if (iconWidget == null && textWidget != null) {
      return textWidget;
    }
    if (iconWidget != null && textWidget == null) {
      return iconWidget;
    }

    final children = <Widget>[];

    if (iconWidget != null) {
      children.add(iconWidget);
    }

    if (iconWidget != null && textWidget != null) {
      children.add(SizedBox(width: sizeSpec.iconLabelGap));
    }

    if (textWidget != null) {
      children.add(
        textWidget is Flexible ? textWidget : Flexible(child: textWidget),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget? _buildIcon(ButtonThemeDataConfig theme, ButtonSizeConfig sizeSpec) {
    if (!showIcon || icon == null) return null;

    if (icon is Widget) {
      return icon as Widget;
    } else if (icon is IconData) {
      return Icon(icon as IconData, size: theme.iconSize ?? sizeSpec.iconSize);
    }
    return null;
  }

  Widget? _buildText(
    BuildContext context,
    ButtonThemeDataConfig theme,
    ButtonSizeConfig sizeSpec,
  ) {
    if (labelText != null) {
      return labelText;
    }
    if (label != null) {
      final baseStyle = theme.textStyle ?? sizeSpec.labelTextStyle;
      final defaultColor = DefaultTextStyle.of(context).style.color;
      return Text(
        label!,
        style: baseStyle.copyWith(color: defaultColor),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }
    return null;
  }
}
