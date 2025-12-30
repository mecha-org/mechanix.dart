import 'package:flutter/material.dart';
import 'package:widgets/extensions/theme_extension.dart';
import 'package:widgets/mechanix.dart';
import 'package:widgets/widgets/filled_button/mechanix_filled_button_theme.dart';

class MechanixFilledButton extends StatelessWidget {
  const MechanixFilledButton({
    super.key,
    this.mouseCursor,
    this.backgroundBuilder,
    this.foregroundBuilder,
    required this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.buttonStyle,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.statesController,
    this.theme,
    required this.label,
  }) : labelText = null;

  const MechanixFilledButton.textWidget({
    super.key,
    this.mouseCursor,
    this.backgroundBuilder,
    this.foregroundBuilder,
    required this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.buttonStyle,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.statesController,
    this.theme,
    required this.labelText,
  }) : label = '';

  final WidgetStateProperty<MouseCursor?>? mouseCursor;
  final ButtonLayerBuilder? backgroundBuilder;
  final ButtonLayerBuilder? foregroundBuilder;

  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final ButtonStyle? buttonStyle;
  final Clip? clipBehavior;
  final FocusNode? focusNode;
  final bool autofocus;
  final WidgetStatesController? statesController;

  final String label;
  final Text? labelText;
  final MechanixFilledButtonThemeData? theme;

  @override
  Widget build(BuildContext context) {
    final buttonTheme =
        MechanixFilledButtonTheme.of(context).merge(theme, context);

    return FilledButton(
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      onHover: onHover,
      onLongPress: onLongPress,
      statesController: statesController,
      onPressed: onPressed,
      style: Theme.of(context).filledButtonTheme.style?.copyWith(
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            backgroundColor: WidgetStateProperty.resolveWith(
              (states) {
                if (states.contains(WidgetState.pressed)) {
                  return buttonTheme.pressedButtonColor ?? context.tertiary;
                }

                return buttonTheme.buttonColor ?? context.secondary;
              },
            ),
            minimumSize: WidgetStateProperty.all(buttonTheme.buttonSize),
            padding: WidgetStateProperty.all(buttonTheme.padding),
            splashFactory: NoSplash.splashFactory,
            textStyle: WidgetStateProperty.all(buttonTheme.textStyle),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
      child: labelText ??
          Text(
            label,
            style: context.textTheme.bodySmall,
          ).padOnly(top: 9, bottom: 9),
    );
  }
}
